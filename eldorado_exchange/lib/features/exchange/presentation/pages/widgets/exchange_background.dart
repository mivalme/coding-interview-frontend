import 'package:flutter/material.dart';

class ExchangeBackground extends StatelessWidget {
  const ExchangeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _ExchangeBackgroundPainter());
  }
}

class _ExchangeBackgroundPainter extends CustomPainter {
  static const _cyan = Color(0xFFEAF9F9);
  static const _orange = Colors.orange;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;

    paint.color = _cyan;
    canvas.drawRect(Offset.zero & size, paint);

    paint.color = _orange;
    final w = size.width, h = size.height;
    final path = Path()
      ..moveTo(w * 0.7, 0)
      ..quadraticBezierTo(w * 0.1, h * 0.4, w * 1, h * 0.85)
      ..lineTo(w, h)
      ..lineTo(w, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
