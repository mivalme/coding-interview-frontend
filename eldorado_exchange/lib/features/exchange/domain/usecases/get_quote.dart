import '../entities/recommendation.dart';
import '../repository/exchange_repo.dart';

class GetQuote {
  final ExchangeRepo repo;
  GetQuote(this.repo);

  Future<Recommendation> call({
    required int type,
    required String cryptoId,
    required String fiatId,
    required double amount,
    required String amountCurrencyId,
  }) {
    return repo.getQuote(
      type: type,
      cryptoId: cryptoId,
      fiatId: fiatId,
      amount: amount,
      amountCurrencyId: amountCurrencyId,
    );
  }
}
