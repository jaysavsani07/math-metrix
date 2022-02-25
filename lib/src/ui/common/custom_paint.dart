import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.06593407,0);
    path_0.cubicTo(size.width*0.06593407,0,size.width*0.2829670,size.height*-0.02857143,size.width*0.5000000,size.height*-0.02857143);
    path_0.cubicTo(size.width*0.7170330,size.height*-0.02857143,size.width*0.9340659,0,size.width*0.9340659,0);
    path_0.arcToPoint(Offset(size.width,size.height*0.3428571),radius: Radius.elliptical(size.width*0.06593407, size.height*0.3428571),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.lineTo(size.width,size.height*0.6000000);
    path_0.arcToPoint(Offset(size.width*0.9340659,size.height*0.9428571),radius: Radius.elliptical(size.width*0.06593407, size.height*0.3428571),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.cubicTo(size.width*0.9340659,size.height*0.9428571,size.width*0.7170330,size.height*0.9714286,size.width*0.5000000,size.height*0.9714286);
    path_0.cubicTo(size.width*0.2829670,size.height*0.9714286,size.width*0.06593407,size.height*0.9428571,size.width*0.06593407,size.height*0.9428571);
    path_0.arcToPoint(Offset(0,size.height*0.6000000),radius: Radius.elliptical(size.width*0.06593407, size.height*0.3428571),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.lineTo(0,size.height*0.3428571);
    path_0.arcToPoint(Offset(size.width*0.06593407,0),radius: Radius.elliptical(size.width*0.06593407, size.height*0.3428571),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xfff5f5f5);
    canvas.drawPath(path_0,paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width*0.06593407,0);
    path_1.cubicTo(size.width*0.06593407,0,size.width*0.2829670,size.height*-0.02857143,size.width*0.5000000,size.height*-0.02857143);
    path_1.cubicTo(size.width*0.7170330,size.height*-0.02857143,size.width*0.9340659,0,size.width*0.9340659,0);
    path_1.arcToPoint(Offset(size.width,size.height*0.3428571),radius: Radius.elliptical(size.width*0.06593407, size.height*0.3428571),rotation: 0 ,largeArc: false,clockwise: true);
    path_1.lineTo(size.width,size.height*0.6000000);
    path_1.arcToPoint(Offset(size.width*0.9340659,size.height*0.9428571),radius: Radius.elliptical(size.width*0.06593407, size.height*0.3428571),rotation: 0 ,largeArc: false,clockwise: true);
    path_1.cubicTo(size.width*0.9340659,size.height*0.9428571,size.width*0.7170330,size.height*0.9714286,size.width*0.5000000,size.height*0.9714286);
    path_1.cubicTo(size.width*0.2829670,size.height*0.9714286,size.width*0.06593407,size.height*0.9428571,size.width*0.06593407,size.height*0.9428571);
    path_1.arcToPoint(Offset(0,size.height*0.6000000),radius: Radius.elliptical(size.width*0.06593407, size.height*0.3428571),rotation: 0 ,largeArc: false,clockwise: true);
    path_1.lineTo(0,size.height*0.3428571);
    path_1.arcToPoint(Offset(size.width*0.06593407,0),radius: Radius.elliptical(size.width*0.06593407, size.height*0.3428571),rotation: 0 ,largeArc: false,clockwise: true);
    path_1.close();

    Paint paint_1_fill = Paint()..style=PaintingStyle.fill;
    paint_1_fill.color = Color(0x00000029);
    canvas.drawPath(path_1,paint_1_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}