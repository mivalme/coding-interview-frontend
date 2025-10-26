import '../../domain/repository/currency_repo.dart';
import '../../domain/usecases/load_currencies.dart';
import '../models/currency_item.dart';
import '../../../../core/constants/currencies.dart';

class CurrencyRepoImpl implements CurrencyRepo {
  const CurrencyRepoImpl();

  @override
  Future<LoadCurrenciesResult> load() async {
    final crypto =
        CryptoCurrency.values
            .map(
              (c) => CurrencyItem(
                id: c.id,
                code: c.code,
                name: c.displayName,
                iconPath: c.iconPath,
                kind: c.kind,
              ),
            )
            .toList()
          ..sort((a, b) => a.code.compareTo(b.code));

    final fiat =
        FiatCurrency.values
            .map(
              (f) => CurrencyItem(
                id: f.id,
                code: f.code,
                name: f.displayName,
                iconPath: f.iconPath,
                kind: f.kind,
              ),
            )
            .toList()
          ..sort((a, b) => a.code.compareTo(b.code));

    return LoadCurrenciesResult(crypto: crypto, fiat: fiat);
  }
}
