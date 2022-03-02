import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/data/models/picture_puzzle.dart';
import 'package:mathgame/src/ui/common/CommonNeumorphicView.dart';
import 'package:mathgame/src/ui/picturePuzzle/picture_puzzle_view_model.dart';
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
    return CommonNeumorphicView(
      child: Selector<PicturePuzzleProvider, String>(
        selector: (p0, p1) => p1.result,
        builder: (context, value, child) => Text(
          value == "" ? "?" : value,
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                fontSize: 24,
                color: value == ""
                    ? Theme.of(context).colorScheme.crossLightColor
                    : colorTuple.item1,
              ),
        ),
      ),
    );
  }
}
