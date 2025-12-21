import 'package:flutter/cupertino.dart';

class LeafPainter extends CustomPainter {
  final Color color;
  final double rotation;

  LeafPainter({required this.color, this.rotation = -30});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(rotation * 3.14159 / 180);

    final path = Path();
    path.addOval(Rect.fromCenter(
      center: Offset.zero,
      width: size.width * 0.7,
      height: size.height,
    ));

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
