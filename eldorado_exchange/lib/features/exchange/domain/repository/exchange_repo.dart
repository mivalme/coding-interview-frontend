import '../entities/recommendation.dart';

abstract class ExchangeRepo {
  Future<Recommendation> getQuote({
    required int type,
    required String cryptoId,
    required String fiatId,
    required double amount,
    required String amountCurrencyId,
  });
}
