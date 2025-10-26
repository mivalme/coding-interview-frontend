import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: Stack(
        children: [
          ModalBarrier(color: Colors.black45, dismissible: false),
          Center(
            child: SizedBox(
              width: 56,
              height: 56,
              child: CircularProgressIndicator(strokeWidth: 4),
            ),
          ),
        ],
      ),
    );
  }
}
