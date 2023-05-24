import 'package:flutter/material.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/data/models/math_pairs.dart';
import 'package:mathgame/src/ui/mathPairs/math_pairs_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class MathPairsButton extends StatelessWidget {
  final Pair mathPairs;
  final int index;
  final Tuple2<Color, Color> colorTuple;

  MathPairsButton({
    required this.mathPairs,
    required this.index,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: mathPairs.isVisible ? 1 : 0,
      duration: Duration(milliseconds: 300),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 2,
        child: InkWell(
          onTap: mathPairs.isVisible
              ? () {
                  context
                      .read<MathPairsProvider>()
                      .checkResult(mathPairs, index);
                }
              : null,
          borderRadius: BorderRadius.all(Radius.circular(24)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              border: mathPairs.isActive
                  ? null
                  : Border.all(color: colorTuple.item1),
              gradient: mathPairs.isActive
                  ? LinearGradient(
                      colors: [colorTuple.item1, colorTuple.item2],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  : null,
            ),
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                mathPairs.text,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 24,
                    color: mathPairs.isActive
                        ? Theme.of(context).colorScheme.baseColor
                        : colorTuple.item1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
