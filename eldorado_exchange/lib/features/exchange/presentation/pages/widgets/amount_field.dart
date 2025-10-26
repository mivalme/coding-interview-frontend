import 'package:flutter/material.dart';

class AmountField extends StatelessWidget {
  const AmountField({
    super.key,
    required this.controller,
    required this.prefix,
  });

  final TextEditingController controller;
  final String prefix;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12, right: 8),
          child: Text(
            prefix,
            style: const TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.orange, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.orange, width: 2.5),
        ),
      ),
    );
  }
}
