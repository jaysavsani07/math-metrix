import 'package:flutter/material.dart';
import 'package:mathgame/src/models/picturePuzzle/PicturePuzzleRootQandS.dart';
import 'package:mathgame/src/ui/picturePuzzle/CirclePainter.dart';
import 'package:mathgame/src/ui/picturePuzzle/SquarePainter.dart';

import 'TrianglePainter.dart';

class PicturePuzzleShapeButton extends StatelessWidget {
  final PicturePuzzleShape picturePuzzleShape;

  PicturePuzzleShapeButton(this.picturePuzzleShape);

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
                  ? CirclePainter(Colors.red, 2)
                  : (picturePuzzleShape.picturePuzzleShapeType ==
                          PicturePuzzleShapeType.TRIANGLE
                      ? TrianglePainter(Colors.red, 2)
                      : SquarePainter(Colors.red, 2)),
              size: Size(40, 40),
            ),
    ]);
  }
}
