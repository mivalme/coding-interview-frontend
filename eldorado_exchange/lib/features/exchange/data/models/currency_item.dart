import '../../domain/entities/currency.dart';

class CurrencyItem {
  final String id;
  final String code;
  final String name;
  final String iconPath;
  final CurrencyKind kind;

  const CurrencyItem({
    required this.id,
    required this.code,
    required this.name,
    required this.iconPath,
    required this.kind,
  });
}
