import 'package:flutter/material.dart';
import 'package:mathgame/src/data/models/math_pairs.dart';
import 'package:mathgame/src/ui/mathPairs/math_pairs_view_model.dart';
import 'package:provider/provider.dart';

class MathPairsButton extends StatelessWidget {
  final Pair mathPairs;
  final int index;

  MathPairsButton(this.mathPairs, this.index);

  @override
  Widget build(BuildContext context) {
    final mathPairsProvider = Provider.of<MathPairsProvider>(context);
    return Container(
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          mathPairsProvider.checkResult(mathPairs, index);
        },
        child: Visibility(
          visible: mathPairs.isVisible,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                  width: 2,
                  color: mathPairs.isActive
                      ? Theme.of(context).accentColor
                      : Theme.of(context).dialogBackgroundColor),
            ),
            margin: EdgeInsets.all(5),
            constraints: BoxConstraints.expand(),
            child: Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  mathPairs.text,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
