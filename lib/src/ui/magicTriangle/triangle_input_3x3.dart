import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/magicTriangle/magic_triangle_provider.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_button.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class TriangleInput3x3 extends StatelessWidget {
  final Tuple2<Color, Color> colorTuple;

  const TriangleInput3x3({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final magicTriangleProvider = Provider.of<MagicTriangleProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            TriangleButton(
              digit: magicTriangleProvider.currentState.listGrid[0],
              index: 0,
              colorTuple: colorTuple,
            ),
            SizedBox(height: 24),
            TriangleButton(
              digit: magicTriangleProvider.currentState.listGrid[1],
              index: 1,
              colorTuple: colorTuple,
            ),
          ],
        ),
        Column(
          children: <Widget>[
            TriangleButton(
              digit: magicTriangleProvider.currentState.listGrid[2],
              index: 2,
              colorTuple: colorTuple,
            ),
            SizedBox(height: 24),
            TriangleButton(
              digit: magicTriangleProvider.currentState.listGrid[3],
              index: 3,
              colorTuple: colorTuple,
            ),
          ],
        ),
        Column(
          children: <Widget>[
            TriangleButton(
              digit: magicTriangleProvider.currentState.listGrid[4],
              index: 4,
              colorTuple: colorTuple,
            ),
            SizedBox(height: 24),
            TriangleButton(
              digit: magicTriangleProvider.currentState.listGrid[5],
              index: 5,
              colorTuple: colorTuple,
            ),
          ],
        )
      ],
    );
  }
}
