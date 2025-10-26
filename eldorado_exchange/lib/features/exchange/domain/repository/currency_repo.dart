import '../usecases/load_currencies.dart';

abstract class CurrencyRepo {
  Future<LoadCurrenciesResult> load();
}
