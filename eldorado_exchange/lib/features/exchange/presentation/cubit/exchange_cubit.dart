import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_quote.dart';

sealed class ExchangeState {
  const ExchangeState();
}

class ExchangeIdle extends ExchangeState {
  const ExchangeIdle();
}

class ExchangeLoading extends ExchangeState {
  const ExchangeLoading();
}

class ExchangeLoaded extends ExchangeState {
  final double rateFiatToCrypto;
  final double converted;
  final int? etaMinutes;
  final String targetCode;

  const ExchangeLoaded({
    required this.rateFiatToCrypto,
    required this.converted,
    required this.etaMinutes,
    required this.targetCode,
  });
}

class ExchangeError extends ExchangeState {
  final String message;
  const ExchangeError(this.message);
}

class ExchangeCubit extends Cubit<ExchangeState> {
  final GetQuote getQuote;
  ExchangeCubit(this.getQuote) : super(const ExchangeIdle());

  void clear() => emit(const ExchangeIdle());

  Future<void> request({
    required int type,
    required String cryptoId,
    required String fiatId,
    required double amount,
    required String amountCurrencyId,
    required String targetCode,
  }) async {
    emit(const ExchangeLoading());

    try {
      final quote = await getQuote(
        type: type,
        cryptoId: cryptoId,
        fiatId: fiatId,
        amount: amount,
        amountCurrencyId: amountCurrencyId,
      );

      final double rateFiatToCrypto = quote.rateFiatToCrypto;
      final double convertedAmount = (type == 1)
          ? (amount / rateFiatToCrypto)
          : (amount * rateFiatToCrypto);

      emit(
        ExchangeLoaded(
          rateFiatToCrypto: rateFiatToCrypto,
          converted: convertedAmount,
          etaMinutes: quote.etaMinutes,
          targetCode: targetCode,
        ),
      );
    } catch (error) {
      emit(ExchangeError(error.toString()));
    }
  }
}
