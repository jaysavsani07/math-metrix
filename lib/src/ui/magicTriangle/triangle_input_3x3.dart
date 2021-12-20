import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/magicTriangle/magic_triangle_view_model.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_button.dart';
import 'package:provider/provider.dart';

class TriangleInput3x3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final magicTriangleProvider = Provider.of<MagicTriangleProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          children: <Widget>[
            TriangleButton(magicTriangleProvider.currentState.listGrid[0], 0),
            TriangleButton(magicTriangleProvider.currentState.listGrid[1], 1),
          ],
        ),
        Column(
          children: <Widget>[
            TriangleButton(magicTriangleProvider.currentState.listGrid[2], 2),
            TriangleButton(magicTriangleProvider.currentState.listGrid[3], 3),
          ],
        ),
        Column(
          children: <Widget>[
            TriangleButton(magicTriangleProvider.currentState.listGrid[4], 4),
            TriangleButton(magicTriangleProvider.currentState.listGrid[5], 5),
          ],
        )
      ],
    );
  }
}
