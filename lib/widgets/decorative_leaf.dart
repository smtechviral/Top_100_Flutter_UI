import 'package:flutter/material.dart';
import '../painters/leaf_painter.dart';

class DecorativeLeaf extends StatelessWidget {
   DecorativeLeaf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 20,
          left: 10,
          child: Opacity(
            opacity: 0.3,
            child: CustomPaint(
              size: const Size(80, 80),
              painter: LeafPainter(
                color: const Color(0xFF6EE7B7),
                rotation: -30,
              ),
            ),
          ),
        ),
        Positioned(
          top: 60,
          right: 20,
          child: Opacity(
            opacity: 0.25,
            child: CustomPaint(
              size: const Size(100, 120),
              painter: LeafPainter(
                color: const Color(0xFF5EEAD4),
                rotation: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
