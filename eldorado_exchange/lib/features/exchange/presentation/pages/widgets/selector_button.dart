import 'package:flutter/material.dart';
import '../../../data/models/currency_item.dart';

class SelectorButton extends StatelessWidget {
  const SelectorButton({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
    this.alignRight = false,
  });

  final String label;
  final CurrencyItem value;
  final VoidCallback onTap;
  final bool alignRight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignRight
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(label, style: const TextStyle(fontSize: 12)),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(28),
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.orange, width: 2),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(value.iconPath, width: 22, height: 22),
                  const SizedBox(width: 8),
                  Text(
                    value.code,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.keyboard_arrow_down_rounded),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
