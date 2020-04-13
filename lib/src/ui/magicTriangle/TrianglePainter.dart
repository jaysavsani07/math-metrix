import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    double radius = 40;
    double padding = 20;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4.0;

    var path = Path();
    path.moveTo(size.width / 2, radius + padding);
    path.lineTo(radius + padding, size.height - radius - padding);
    path.lineTo(size.width - radius - padding, size.height - radius - padding);
    path.close();
    canvas.drawPath(path, paint);

    /*
    paint.style = PaintingStyle.stroke;
    paint.color = Colors.blue;
    canvas.drawCircle(Offset(size.width / 2, radius + padding), radius,
        paint); // draw first circle

    canvas.drawCircle(
        Offset(size.width / 4 + ((padding + radius) / 2), size.height / 2),
        radius,
        paint); // second
    canvas.drawCircle(
        Offset(
            (size.width / 4) * 3 - ((radius + padding) / 2), size.height / 2),
        radius,
        paint); // third one

    canvas.drawCircle(Offset(radius + padding, size.height - radius - padding),
        radius, paint); // third one
    canvas.drawCircle(
        Offset(size.width / 2, size.height - radius - padding), radius, paint);
    canvas.drawCircle(
        Offset(size.width - radius - padding, size.height - radius - padding),
        radius,
        paint);*/
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
