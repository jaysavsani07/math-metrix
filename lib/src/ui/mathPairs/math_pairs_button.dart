import 'package:flutter/material.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/data/models/math_pairs.dart';
import 'package:mathgame/src/ui/mathPairs/math_pairs_view_model.dart';
import 'package:provider/provider.dart';

class MathPairsButton extends StatelessWidget {
  final Pair mathPairs;
  final int index;
  final Color startColor;
  final Color endColor;

  MathPairsButton({
    required this.mathPairs,
    required this.index,
    required this.startColor,
    required this.endColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<MathPairsProvider>().checkResult(mathPairs, index);
      },
      child: Visibility(
        visible: mathPairs.isVisible,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              border: mathPairs.isActive ? null : Border.all(color: startColor),
              gradient: mathPairs.isActive
                  ? LinearGradient(
                      colors: [startColor, endColor],
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
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 24,
                    color: mathPairs.isActive
                        ? Theme.of(context).colorScheme.baseColor
                        : Color(0xff4895EF)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
