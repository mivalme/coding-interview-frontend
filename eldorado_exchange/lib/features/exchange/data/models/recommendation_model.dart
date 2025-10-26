class RecommendationModel {
  final double cryptoToFiatRate;
  final int? etaMinutes;

  RecommendationModel({
    required this.cryptoToFiatRate,
    required this.etaMinutes,
  });

  static double _asDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }

  static int? _asMinutes(dynamic v) {
    final d = _asDouble(v);
    if (d <= 0) return null;
    return d.ceil();
  }

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;

    final byPrice = (data is Map) ? (data['byPrice'] ?? data) : {};

    final rate = _asDouble(
      (byPrice is Map) ? byPrice['fiatToCryptoExchangeRate'] : null,
    );

    int? eta;
    if (byPrice is Map) {
      final stats = byPrice['offerMakerStats'];
      if (stats is Map) {
        eta = _asMinutes(stats['marketMakerOrderTime']);
      }
    }

    return RecommendationModel(cryptoToFiatRate: rate, etaMinutes: eta);
  }
}
