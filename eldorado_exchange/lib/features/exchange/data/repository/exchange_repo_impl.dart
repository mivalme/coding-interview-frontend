import '../../domain/entities/recommendation.dart';
import '../../domain/repository/exchange_repo.dart';
import '../datasources/exchange_api.dart';
import '../models/recommendation_model.dart';

class ExchangeRepoImpl implements ExchangeRepo {
  final ExchangeApi api;
  ExchangeRepoImpl(this.api);

  @override
  Future<Recommendation> getQuote({
    required int type,
    required String cryptoId,
    required String fiatId,
    required double amount,
    required String amountCurrencyId,
  }) async {
    final raw = await api.getRecommendationRaw(
      type: type,
      cryptoCurrencyId: cryptoId,
      fiatCurrencyId: fiatId,
      amount: amount,
      amountCurrencyId: amountCurrencyId,
    );

    final model = RecommendationModel.fromJson(raw);

    return Recommendation(
      rateFiatToCrypto: model.cryptoToFiatRate,
      etaMinutes: model.etaMinutes,
    );
  }
}
