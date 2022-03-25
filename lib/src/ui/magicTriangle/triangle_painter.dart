import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final Color color;
  final double radius;
  final double padding;

  TrianglePainter({
    required this.color,
    required this.radius,
    required this.padding,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.style = PaintingStyle.stroke;
    paint.color = color;
    paint.strokeWidth = 2.0;

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
