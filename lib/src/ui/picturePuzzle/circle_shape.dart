import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleShape extends CustomPainter {
  final Color color;
  final double stroke;

  CircleShape(this.color, this.stroke);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = stroke;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
