import 'package:dio/dio.dart';
import 'package:eldorado_exchange/features/exchange/data/repository/currency_repo_impl.dart';
import 'package:eldorado_exchange/features/exchange/domain/usecases/load_currencies.dart';

import '../config/api_config.dart';
import '../network/dio_client.dart';

import 'package:eldorado_exchange/features/exchange/data/datasources/exchange_api.dart';
import 'package:eldorado_exchange/features/exchange/data/repository/exchange_repo_impl.dart';
import 'package:eldorado_exchange/features/exchange/domain/usecases/get_quote.dart';

class Dependencies {
  late final Dio dio;

  // Data sources
  late final ExchangeApi exchangeApi;

  // Repos
  late final ExchangeRepoImpl exchangeRepo;
  late final CurrencyRepoImpl currencyRepo;

  // Use cases
  late final GetQuote getQuote;
  late final LoadCurrencies loadCurrencies;

  Future<void> init() async {
    dio = DioClient().dio;

    exchangeApi = ExchangeApi(dio, baseUrl: kExchangeBaseUrl);

    exchangeRepo = ExchangeRepoImpl(exchangeApi);
    currencyRepo = CurrencyRepoImpl();

    getQuote = GetQuote(exchangeRepo);
    loadCurrencies = LoadCurrencies(currencyRepo);
  }
}

final deps = Dependencies();
