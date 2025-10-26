import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:eldorado_exchange/features/exchange/data/datasources/exchange_api.dart';
import 'package:eldorado_exchange/features/exchange/data/repository/exchange_repo_impl.dart';
import 'package:eldorado_exchange/features/exchange/domain/entities/recommendation.dart';

class MockExchangeApi extends Mock implements ExchangeApi {}

void main() {
  late MockExchangeApi api;
  late ExchangeRepoImpl repo;

  setUp(() {
    api = MockExchangeApi();
    repo = ExchangeRepoImpl(api);
  });

  test('maps byPrice node with numeric rate and rounds ETA', () async {
    final response = {
      'data': {
        'byPrice': {
          'fiatToCryptoExchangeRate': 3852.25,
          'offerMakerStats': {'marketMakerOrderTime': 3.7262333333333335},
        },
      },
    };

    when(
      () => api.getRecommendationRaw(
        type: 1,
        cryptoCurrencyId: 'TATUM-TRON-USDT',
        fiatCurrencyId: 'COP',
        amount: 1000.0,
        amountCurrencyId: 'COP',
      ),
    ).thenAnswer((_) async => response);

    final Recommendation rec = await repo.getQuote(
      type: 1,
      cryptoId: 'TATUM-TRON-USDT',
      fiatId: 'COP',
      amount: 1000.0,
      amountCurrencyId: 'COP',
    );

    expect(rec.rateFiatToCrypto, closeTo(3852.25, 1e-9));
    expect(rec.etaMinutes, 4);
  });

  test(
    'returns rate 0.0 and ETA null when fields are missing in byPrice',
    () async {
      final response = {
        'data': {'byPrice': {}},
      };

      when(
        () => api.getRecommendationRaw(
          type: 1,
          cryptoCurrencyId: 'TATUM-TRON-USDT',
          fiatCurrencyId: 'COP',
          amount: 10.0,
          amountCurrencyId: 'COP',
        ),
      ).thenAnswer((_) async => response);

      final rec = await repo.getQuote(
        type: 1,
        cryptoId: 'TATUM-TRON-USDT',
        fiatId: 'COP',
        amount: 10.0,
        amountCurrencyId: 'COP',
      );

      expect(rec.rateFiatToCrypto, 0.0);
      expect(rec.etaMinutes, isNull);
    },
  );

  test('forwards correct params to API', () async {
    when(
      () => api.getRecommendationRaw(
        type: 0,
        cryptoCurrencyId: 'TATUM-TRON-USDT',
        fiatCurrencyId: 'COP',
        amount: 2.5,
        amountCurrencyId: 'TATUM-TRON-USDT',
      ),
    ).thenAnswer(
      (_) async => {
        'data': {
          'byPrice': {
            'fiatToCryptoExchangeRate': 3900,
            'offerMakerStats': {'marketMakerOrderTime': 2.0},
          },
        },
      },
    );

    await repo.getQuote(
      type: 0,
      cryptoId: 'TATUM-TRON-USDT',
      fiatId: 'COP',
      amount: 2.5,
      amountCurrencyId: 'TATUM-TRON-USDT',
    );

    verify(
      () => api.getRecommendationRaw(
        type: 0,
        cryptoCurrencyId: 'TATUM-TRON-USDT',
        fiatCurrencyId: 'COP',
        amount: 2.5,
        amountCurrencyId: 'TATUM-TRON-USDT',
      ),
    ).called(1);
  });
}
