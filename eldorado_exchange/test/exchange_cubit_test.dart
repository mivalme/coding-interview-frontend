import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:eldorado_exchange/features/exchange/presentation/cubit/exchange_cubit.dart';
import 'package:eldorado_exchange/features/exchange/domain/usecases/get_quote.dart';
import 'package:eldorado_exchange/features/exchange/domain/entities/recommendation.dart';

class MockGetQuote extends Mock implements GetQuote {}

void main() {
  group('ExchangeCubit', () {
    late MockGetQuote mockGetQuote;

    setUp(() {
      mockGetQuote = MockGetQuote();
    });

    test('initial state is ExchangeIdle', () {
      final cubit = ExchangeCubit(mockGetQuote);
      expect(cubit.state, isA<ExchangeIdle>());
      cubit.close();
    });

    blocTest<ExchangeCubit, ExchangeState>(
      'FIAT→CRYPTO (type=1): emits [Loading, Loaded] with converted = amount / rate',
      build: () {
        when(
          () => mockGetQuote(
            type: 1,
            cryptoId: 'TATUM-TRON-USDT',
            fiatId: 'COP',
            amount: 1000.0,
            amountCurrencyId: 'COP',
          ),
        ).thenAnswer(
          (_) async =>
              const Recommendation(rateFiatToCrypto: 4000.0, etaMinutes: 4),
        );
        return ExchangeCubit(mockGetQuote);
      },
      act: (cubit) => cubit.request(
        type: 1,
        cryptoId: 'TATUM-TRON-USDT',
        fiatId: 'COP',
        amount: 1000.0,
        amountCurrencyId: 'COP',
        targetCode: 'USDT',
      ),
      expect: () => [
        const ExchangeLoading(),
        predicate<ExchangeState>((s) {
          if (s is! ExchangeLoaded) return false;

          return s.rateFiatToCrypto == 4000.0 &&
              (s.converted - 0.25).abs() < 1e-9 &&
              s.etaMinutes == 4 &&
              s.targetCode == 'USDT';
        }),
      ],
      verify: (_) {
        verify(
          () => mockGetQuote(
            type: 1,
            cryptoId: 'TATUM-TRON-USDT',
            fiatId: 'COP',
            amount: 1000.0,
            amountCurrencyId: 'COP',
          ),
        ).called(1);
      },
    );

    blocTest<ExchangeCubit, ExchangeState>(
      'CRYPTO→FIAT (type=0): emits [Loading, Loaded] with converted = amount * rate',
      build: () {
        when(
          () => mockGetQuote(
            type: 0,
            cryptoId: 'TATUM-TRON-USDT',
            fiatId: 'COP',
            amount: 2.0,
            amountCurrencyId: 'TATUM-TRON-USDT',
          ),
        ).thenAnswer(
          (_) async =>
              const Recommendation(rateFiatToCrypto: 3900.0, etaMinutes: 3),
        );
        return ExchangeCubit(mockGetQuote);
      },
      act: (cubit) => cubit.request(
        type: 0,
        cryptoId: 'TATUM-TRON-USDT',
        fiatId: 'COP',
        amount: 2.0,
        amountCurrencyId: 'TATUM-TRON-USDT',
        targetCode: 'COP',
      ),
      expect: () => [
        const ExchangeLoading(),
        predicate<ExchangeState>((s) {
          if (s is! ExchangeLoaded) return false;

          return s.rateFiatToCrypto == 3900.0 &&
              (s.converted - 7800.0).abs() < 1e-9 &&
              s.etaMinutes == 3 &&
              s.targetCode == 'COP';
        }),
      ],
    );

    blocTest<ExchangeCubit, ExchangeState>(
      'error path: emits [Loading, Error] when GetQuote throws',
      build: () {
        when(
          () => mockGetQuote(
            type: 1,
            cryptoId: 'TATUM-TRON-USDT',
            fiatId: 'COP',
            amount: 1.0,
            amountCurrencyId: 'COP',
          ),
        ).thenThrow(Exception('boom'));
        return ExchangeCubit(mockGetQuote);
      },
      act: (cubit) => cubit.request(
        type: 1,
        cryptoId: 'TATUM-TRON-USDT',
        fiatId: 'COP',
        amount: 1.0,
        amountCurrencyId: 'COP',
        targetCode: 'USDT',
      ),
      expect: () => [const ExchangeLoading(), isA<ExchangeError>()],
    );
  });
}
