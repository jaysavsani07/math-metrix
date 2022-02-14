import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/data/models/picture_puzzle.dart';
import 'package:mathgame/src/ui/picturePuzzle/picture_puzzle_view_model.dart';
import 'package:provider/provider.dart';

class PicturePuzzleAnswerButton extends StatelessWidget {
  final PicturePuzzleShape picturePuzzleShape;

  PicturePuzzleAnswerButton(this.picturePuzzleShape);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.only(left: 10, right: 10),
      style: NeumorphicStyle(
        // shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(18)),
        depth: -8,
        lightSource: LightSource.topLeft,
        color: Theme.of(context).colorScheme.iconBgColor,
      ),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: Selector<PicturePuzzleProvider, String>(
          selector: (p0, p1) => p1.result,
          builder: (context, value, child) => Text(
            value == "" ? "?" : value,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontSize: 24,
                  color: value == ""
                      ? Theme.of(context).colorScheme.crossLightColor
                      : Theme.of(context).colorScheme.crossColor,
                ),
          ),
        ),
      ),
    );
  }
}
