import '../../features/exchange/domain/entities/currency.dart';

enum FiatCurrency {
  brl('BRL'),
  cop('COP'),
  pen('PEN'),
  ves('VES');

  final String id;
  const FiatCurrency(this.id);

  String get code => id;
  String get displayName => id;
  String get iconPath => 'assets/fiat_currencies/$id.png';
  CurrencyKind get kind => CurrencyKind.fiat;
}

enum CryptoCurrency {
  tatumTronUsdt('TATUM-TRON-USDT', 'USDT');

  final String id;
  final String code;
  const CryptoCurrency(this.id, this.code);

  String get displayName => code;
  String get iconPath => 'assets/cripto_currencies/$id.png';
  CurrencyKind get kind => CurrencyKind.crypto;
}
