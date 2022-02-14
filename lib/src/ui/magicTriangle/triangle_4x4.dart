import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/magicTriangle/magic_triangle_view_model.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_input_button.dart';
import 'package:provider/provider.dart';

class Triangle4x4 extends StatelessWidget {
  final double radius;
  final double padding;
  final double triangleHeight;
  final double triangleWidth;

  Triangle4x4({
    required this.radius,
    required this.padding,
    required this.triangleHeight,
    required this.triangleWidth,
  });

  @override
  Widget build(BuildContext context) {
    final magicTriangleProvider = Provider.of<MagicTriangleProvider>(context);
    return SizedBox(
      width: triangleWidth,
      height: triangleHeight,
      child: Stack(
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
            top: (triangleHeight - ((radius + padding) * 2)) / 3 + padding,
            left: (triangleWidth - ((radius + padding) * 2)) / 3 + padding,
            child: TriangleInputButton(
                magicTriangleProvider.currentState.listTriangle[1], 1),
            height: (radius * 2),
            width: (radius * 2),
          ), // second one
          Positioned(
            top: (triangleHeight - ((radius + padding) * 2)) / 3 + padding,
            right: (triangleWidth - ((radius + padding) * 2)) / 3 + padding,
            child: TriangleInputButton(
                magicTriangleProvider.currentState.listTriangle[2], 2),
            height: (radius * 2),
            width: (radius * 2),
          ), // third
          Positioned(
            bottom: (triangleHeight - ((radius + padding) * 2)) / 3 + padding,
            left: (triangleWidth - ((radius + padding) * 2)) / 6 + padding,
            child: TriangleInputButton(
                magicTriangleProvider.currentState.listTriangle[3], 3),
            height: (radius * 2),
            width: (radius * 2),
          ), // fourth one
          Positioned(
            bottom: (triangleHeight - ((radius + padding) * 2)) / 3 + padding,
            right: (triangleWidth - ((radius + padding) * 2)) / 6 + padding,
            child: TriangleInputButton(
                magicTriangleProvider.currentState.listTriangle[4], 4),
            height: (radius * 2),
            width: (radius * 2),
          ), // fifth
          Positioned(
            bottom: padding,
            left: padding,
            child: TriangleInputButton(
                magicTriangleProvider.currentState.listTriangle[5], 5),
            height: (radius * 2),
            width: (radius * 2),
          ), // fourth
          Positioned(
            bottom: padding,
            left: (triangleWidth - ((radius + padding) * 2)) / 3 + padding,
            child: TriangleInputButton(
                magicTriangleProvider.currentState.listTriangle[6], 6),
            height: (radius * 2),
            width: (radius * 2),
          ), // sixth
          Positioned(
            bottom: padding,
            right: (triangleWidth - ((radius + padding) * 2)) / 3 + padding,
            child: TriangleInputButton(
                magicTriangleProvider.currentState.listTriangle[7], 7),
            height: (radius * 2),
            width: (radius * 2),
          ), // seventh
          Positioned(
            bottom: padding,
            right: padding,
            child: TriangleInputButton(
                magicTriangleProvider.currentState.listTriangle[8], 8),
            height: (radius * 2),
            width: (radius * 2),
          ), //ninth
        ],
      ),
    );
  }
}
