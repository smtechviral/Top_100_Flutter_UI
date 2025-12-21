import 'package:flutter/material.dart';
import '../painters/plant_pot_painter.dart';

class PlantPotDecoration extends StatelessWidget {
  const PlantPotDecoration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: CustomPaint(
            size: const Size(40, 50),
            painter: PlantPotPainter(),
          ),
        ),
      ),
    );
  }
}