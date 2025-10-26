import 'package:flutter/material.dart';
import '../../../data/models/currency_item.dart';

Future<CurrencyItem?> showCurrencyPicker({
  required BuildContext context,
  required String title,
  required List<CurrencyItem> items,
  required CurrencyItem selected,
}) {
  return showModalBottomSheet<CurrencyItem>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) => _CurrencyPickerSheet(
      title: title,
      items: items,
      selectedId: selected.id,
    ),
  );
}

class _CurrencyPickerSheet extends StatelessWidget {
  const _CurrencyPickerSheet({
    required this.title,
    required this.items,
    required this.selectedId,
  });

  final String title;
  final List<CurrencyItem> items;
  final String selectedId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 56,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 24),
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = item.id == selectedId;
                return ListTile(
                  leading: Image.asset(
                    item.iconPath,
                    width: 28,
                    height: 28,
                    errorBuilder: (_, __, ___) =>
                        const SizedBox(width: 28, height: 28),
                  ),
                  title: Text(
                    item.code,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    item.name,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Colors.amber)
                      : const SizedBox(width: 24),
                  onTap: () => Navigator.of(context).pop(item),
                  selected: isSelected,
                  selectedTileColor: const Color(0xFFFFF7E5),
                  visualDensity: VisualDensity.compact,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
