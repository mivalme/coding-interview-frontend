import 'dart:convert';
import 'package:dio/dio.dart';

class ExchangeApi {
  final Dio dio;
  final String baseUrl;

  ExchangeApi(this.dio, {required this.baseUrl});

  Future<Map<String, dynamic>> getRecommendationRaw({
    required int type,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required double amount,
    required String amountCurrencyId,
  }) async {
    final url = '$baseUrl/orderbook/public/recommendations';

    final resp = await dio.get(
      url,
      queryParameters: {
        'type': type,
        'cryptoCurrencyId': cryptoCurrencyId,
        'fiatCurrencyId': fiatCurrencyId,
        'amount': amount,
        'amountCurrencyId': amountCurrencyId,
      },
      options: Options(validateStatus: (s) => s != null && s >= 200 && s < 600),
    );

    final body = resp.data is String ? jsonDecode(resp.data) : resp.data;

    if (resp.statusCode != 200 || body is! Map<String, dynamic>) {
      throw Exception('API ${resp.statusCode}: $body');
    }

    return body;
  }
}
