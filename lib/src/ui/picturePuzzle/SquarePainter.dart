import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SquarePainter extends CustomPainter {
  final Color color;
  final double stroke;

  SquarePainter(this.color, this.stroke);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.style = PaintingStyle.stroke;
    paint.color = color;
    paint.strokeWidth = stroke;

    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
