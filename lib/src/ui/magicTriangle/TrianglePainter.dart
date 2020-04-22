import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    double radius = 40;
    double padding = 20;
    paint.style = PaintingStyle.stroke;
    paint.color = color;
    paint.strokeWidth = 4.0;

    var path = Path();
    path.moveTo(size.width / 2, radius + padding);
    path.lineTo(radius + padding, size.height - radius - padding);
    path.lineTo(size.width - radius - padding, size.height - radius - padding);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
