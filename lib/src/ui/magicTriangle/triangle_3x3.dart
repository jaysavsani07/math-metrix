import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathgame/src/models/MagicTriangle/MagicTriangleModel.dart';
import 'package:mathgame/src/provider/MagicTriangleProvider.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_input_button.dart';
import 'package:provider/provider.dart';

class Triangle3x3 extends StatelessWidget {
  final double radius;
  final double padding;
  final double triangleHeight;
  double triangleWidth;

  Triangle3x3(this.radius, this.padding, this.triangleHeight);

  @override
  Widget build(BuildContext context) {
    triangleWidth = MediaQuery.of(context).size.width;
    final magicTriangleProvider = Provider.of<MagicTriangleProvider>(context);
    return Stack(
      children: <Widget>[
        Positioned(
          top: padding,
          left: triangleWidth / 2 - radius,
          child: TriangleInputButton(
              magicTriangleProvider.currentState.listTriangle[0], 0),
          height: (radius * 2),
          width: (radius * 2),
        ), // first
        Positioned(
          top: triangleHeight / 2 - radius,
          left: (triangleWidth - ((radius + padding) * 2)) / 4 + padding,
          child: TriangleInputButton(
              magicTriangleProvider.currentState.listTriangle[1], 1),
          height: (radius * 2),
          width: (radius * 2),
        ), // second one
        Positioned(
          top: triangleHeight / 2 - radius,
          right: (triangleWidth - ((radius + padding) * 2)) / 4 + padding,
          child: TriangleInputButton(
              magicTriangleProvider.currentState.listTriangle[2], 2),
          height: (radius * 2),
          width: (radius * 2),
        ), // third
        Positioned(
          bottom: padding,
          left: padding,
          child: TriangleInputButton(
              magicTriangleProvider.currentState.listTriangle[3], 3),
          height: (radius * 2),
          width: (radius * 2),
        ), // fourth
        Positioned(
          bottom: padding,
          left: triangleWidth / 2 - radius,
          child: TriangleInputButton(
              magicTriangleProvider.currentState.listTriangle[4], 4),
          height: (radius * 2),
          width: (radius * 2),
        ), // fifth
        Positioned(
          bottom: padding,
          right: padding,
          child: TriangleInputButton(
              magicTriangleProvider.currentState.listTriangle[5], 5),
          height: (radius * 2),
          width: (radius * 2),
        ),
      ],
    );
  }
}
