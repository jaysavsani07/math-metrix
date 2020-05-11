import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/MagicTriangleProvider.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_button.dart';
import 'package:provider/provider.dart';

class TriangleInput4x4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final magicTriangleProvider = Provider.of<MagicTriangleProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TriangleButton(magicTriangleProvider.currentState.listGrid[0], 0),
            TriangleButton(magicTriangleProvider.currentState.listGrid[1], 1),
            TriangleButton(magicTriangleProvider.currentState.listGrid[2], 2),
            TriangleButton(magicTriangleProvider.currentState.listGrid[3], 3),
            TriangleButton(magicTriangleProvider.currentState.listGrid[4], 4),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TriangleButton(magicTriangleProvider.currentState.listGrid[5], 5),
            TriangleButton(magicTriangleProvider.currentState.listGrid[6], 6),
            TriangleButton(magicTriangleProvider.currentState.listGrid[7], 7),
            TriangleButton(magicTriangleProvider.currentState.listGrid[8], 8),
          ],
        )
      ],
    );
  }
}
