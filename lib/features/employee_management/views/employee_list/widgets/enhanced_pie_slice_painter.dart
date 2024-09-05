import 'dart:math';

import 'package:flutter/material.dart';

class EnhancedPieSlicePainter extends CustomPainter {
  final Color color;

  EnhancedPieSlicePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2);

    final path = Path()
      ..moveTo(size.width / 2, size.height / 2)
      ..arcTo(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2,
        ),
        -pi / 2,
        pi / 3,
        false,
      )
      ..lineTo(size.width / 2, size.height / 2)
      ..close();

    canvas.drawShadow(path, Colors.black.withOpacity(0.2), 4, false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
