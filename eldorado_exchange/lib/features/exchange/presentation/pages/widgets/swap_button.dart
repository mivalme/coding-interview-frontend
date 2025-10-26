import 'package:flutter/material.dart';

class SwapButton extends StatelessWidget {
  const SwapButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orange,
      shape: const CircleBorder(),
      elevation: 6,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox(
          width: 56,
          height: 56,
          child: Icon(Icons.sync_alt_rounded, color: Colors.white),
        ),
      ),
    );
  }
}
