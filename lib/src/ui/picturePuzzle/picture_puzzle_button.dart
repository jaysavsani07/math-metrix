import 'package:flutter/material.dart';
import 'package:mathgame/src/data/models/picture_puzzle.dart';
import 'package:mathgame/src/ui/picturePuzzle/circle_shape.dart';
import 'package:mathgame/src/ui/picturePuzzle/square_shape.dart';

import 'triangle_shape.dart';

class PicturePuzzleButton extends StatelessWidget {
  final PicturePuzzleShape picturePuzzleShape;

  PicturePuzzleButton(this.picturePuzzleShape);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      picturePuzzleShape.isSign
          ? Container(
              width: picturePuzzleShape.isAnswer ? 60 : 35,
              child: Center(
                child: Text(
                  picturePuzzleShape.text,
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
            )
          : CustomPaint(
              painter: picturePuzzleShape.picturePuzzleShapeType ==
                      PicturePuzzleShapeType.CIRCLE
                  ? CircleShape(Theme.of(context).accentColor, 2)
                  : (picturePuzzleShape.picturePuzzleShapeType ==
                          PicturePuzzleShapeType.TRIANGLE
                      ? TriangleShape(Theme.of(context).accentColor, 2)
                      : SquareShape(Theme.of(context).accentColor, 2)),
              size: Size(40, 40),
            ),
    ]);
  }
}
