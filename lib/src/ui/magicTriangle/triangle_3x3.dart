import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/magicTriangle/magic_triangle_provider.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_input_button.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class Triangle3x3 extends StatelessWidget {
  final double radius;
  final double padding;
  final double triangleHeight;
  final double triangleWidth;
  final Tuple2<Color, Color> colorTuple;

  Triangle3x3({
    required this.radius,
    required this.padding,
    required this.triangleHeight,
    required this.triangleWidth,
    required this.colorTuple,
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
              input: magicTriangleProvider.currentState.listTriangle[0],
              index: 0,
              colorTuple: colorTuple,
            ),
            height: (radius * 2),
            width: (radius * 2),
          ), // first
          Positioned(
            top: triangleHeight / 2 - radius,
            left: (triangleWidth - ((radius + padding) * 2)) / 4 + padding,
            child: TriangleInputButton(
              input: magicTriangleProvider.currentState.listTriangle[1],
              index: 1,
              colorTuple: colorTuple,
            ),
            height: (radius * 2),
            width: (radius * 2),
          ), // second one
          Positioned(
            top: triangleHeight / 2 - radius,
            right: (triangleWidth - ((radius + padding) * 2)) / 4 + padding,
            child: TriangleInputButton(
              input: magicTriangleProvider.currentState.listTriangle[2],
              index: 2,
              colorTuple: colorTuple,
            ),
            height: (radius * 2),
            width: (radius * 2),
          ), // third
          Positioned(
            bottom: padding,
            left: padding,
            child: TriangleInputButton(
              input: magicTriangleProvider.currentState.listTriangle[3],
              index: 3,
              colorTuple: colorTuple,
            ),
            height: (radius * 2),
            width: (radius * 2),
          ), // fourth
          Positioned(
            bottom: padding,
            left: triangleWidth / 2 - radius,
            child: TriangleInputButton(
              input: magicTriangleProvider.currentState.listTriangle[4],
              index: 4,
              colorTuple: colorTuple,
            ),
            height: (radius * 2),
            width: (radius * 2),
          ), // fifth
          Positioned(
            bottom: padding,
            right: padding,
            child: TriangleInputButton(
              input: magicTriangleProvider.currentState.listTriangle[5],
              index: 5,
              colorTuple: colorTuple,
            ),
            height: (radius * 2),
            width: (radius * 2),
          ),
        ],
      ),
    );
  }
}
