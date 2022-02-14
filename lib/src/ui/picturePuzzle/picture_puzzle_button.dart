import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mathgame/src/data/models/picture_puzzle.dart';
import 'package:mathgame/src/ui/picturePuzzle/circle_shape.dart';
import 'package:mathgame/src/ui/picturePuzzle/picture_puzzle_answer_button.dart';
import 'package:mathgame/src/ui/picturePuzzle/square_shape.dart';
import 'triangle_shape.dart';

class PicturePuzzleButton extends StatelessWidget {
  final PicturePuzzleShape picturePuzzleShape;

  PicturePuzzleButton(this.picturePuzzleShape);

  @override
  Widget build(BuildContext context) {
    switch (picturePuzzleShape.type) {
      case PicturePuzzleQuestionItemType.shape:
        return CustomPaint(
          painter: picturePuzzleShape.picturePuzzleShapeType ==
                  PicturePuzzleShapeType.CIRCLE
              ? CircleShape(Color(0xff4895EF), 1)
              : (picturePuzzleShape.picturePuzzleShapeType ==
                      PicturePuzzleShapeType.TRIANGLE
                  ? TriangleShape(Color(0xff4895EF), 1)
                  : SquareShape(Color(0xff4895EF), 1)),
          size: Size(40, 40),
        );
      case PicturePuzzleQuestionItemType.sign:
        return Container(
          width: 35,
          alignment: Alignment.center,
          child: Text(
            picturePuzzleShape.text,
            style:
                Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 24),
          ),
        );
      case PicturePuzzleQuestionItemType.hint:
        return Container(
          width: 60,
          alignment: Alignment.center,
          child: Text(
            picturePuzzleShape.text,
            style:
                Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 24),
          ),
        );
      case PicturePuzzleQuestionItemType.answer:
        return PicturePuzzleAnswerButton(picturePuzzleShape);
    }
  }
}
