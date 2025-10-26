import '../../data/models/currency_item.dart';
import '../repository/currency_repo.dart';

class LoadCurrenciesResult {
  final List<CurrencyItem> crypto;
  final List<CurrencyItem> fiat;
  LoadCurrenciesResult({required this.crypto, required this.fiat});
}

class LoadCurrencies {
  final CurrencyRepo repo;
  LoadCurrencies(this.repo);

  Future<LoadCurrenciesResult> call() => repo.load();
}
