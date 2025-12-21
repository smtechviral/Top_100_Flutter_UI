import 'package:flutter/material.dart';

class PlantPotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw pot
    final potPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final potPath = Path()
      ..moveTo(size.width * 0.3, size.height * 0.6)
      ..lineTo(size.width * 0.7, size.height * 0.6)
      ..lineTo(size.width * 0.8, size.height)
      ..lineTo(size.width * 0.2, size.height)
      ..close();

    canvas.drawPath(potPath, potPaint);

    // Draw plant leaf
    final leafPaint = Paint()
      ..color = const Color(0xFF5EEAD4)
      ..style = PaintingStyle.fill;

    final leafPath = Path();
    leafPath.addOval(Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.3),
      width: size.width * 0.2,
      height: size.height * 0.5,
    ));

    canvas.save();
    canvas.translate(size.width * 0.5, size.height * 0.3);
    canvas.rotate(-20 * 3.14159 / 180);
    canvas.translate(-size.width * 0.5, -size.height * 0.3);
    canvas.drawPath(leafPath, leafPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}