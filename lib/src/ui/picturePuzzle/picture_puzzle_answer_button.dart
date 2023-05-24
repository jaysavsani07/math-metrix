import 'package:flutter/material.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/data/models/picture_puzzle.dart';
import 'package:mathgame/src/ui/common/common_neumorphic_view.dart';
import 'package:mathgame/src/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathgame/src/ui/picturePuzzle/picture_puzzle_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class PicturePuzzleAnswerButton extends StatelessWidget {
  final PicturePuzzleShape picturePuzzleShape;
  final Tuple2<Color, Color> colorTuple;

  PicturePuzzleAnswerButton({
    required this.picturePuzzleShape,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<PicturePuzzleProvider, Tuple2<double, double>>(
      selector: (p0, p1) => Tuple2(p1.currentScore, p1.oldScore),
      builder: (context, tuple2, child) {
        return CommonWrongAnswerAnimationView(
          currentScore: tuple2.item1.toInt(),
          oldScore: tuple2.item2.toInt(),
          child: child!,
        );
      },
      child: CommonNeumorphicView(
        child: Selector<PicturePuzzleProvider, String>(
          selector: (p0, p1) => p1.result,
          builder: (context, value, child) => Text(
            value == "" ? "?" : value,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 24,
                  color: value == ""
                      ? Theme.of(context).colorScheme.crossLightColor
                      : colorTuple.item1,
                ),
          ),
        ),
      ),
    );
  }
}
