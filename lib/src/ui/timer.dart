import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/MagicTriangleProvider.dart';
import 'package:mathgame/src/provider/MathGridProvider.dart';
import 'package:mathgame/src/provider/calculatorProvider.dart';
import 'package:mathgame/src/provider/correctAnswerProvider.dart';
import 'package:mathgame/src/provider/mathPairsProvider.dart';
import 'package:mathgame/src/provider/mentalArithmeticProvider.dart';
import 'package:mathgame/src/provider/quickCalculationProvider.dart';
import 'package:mathgame/src/provider/signProvider.dart';
import 'package:mathgame/src/provider/squareRootProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:provider/provider.dart';

class Timer extends StatelessWidget {
  final GameCategoryType type;

  Timer(this.type);

  @override
  Widget build(BuildContext context) {
    var provider;
    if (type == GameCategoryType.CALCULATOR) {
      provider = Provider.of<CalculatorProvider>(context);
    } else if (type == GameCategoryType.SIGN) {
      provider = Provider.of<SignProvider>(context);
    } else if (type == GameCategoryType.SQUARE_ROOT) {
      provider = Provider.of<SquareRootProvider>(context);
    } else if (type == GameCategoryType.MATH_PAIRS) {
      provider = Provider.of<MathPairsProvider>(context);
    } else if (type == GameCategoryType.CORRECT_ANSWER) {
      provider = Provider.of<CorrectAnswerProvider>(context);
    } else if (type == GameCategoryType.MENTAL_ARITHMETIC) {
      provider = Provider.of<MentalArithmeticProvider>(context);
    } else if (type == GameCategoryType.QUICK_CALCULATION) {
      provider = Provider.of<QuickCalculationProvider>(context);
    } else if (type == GameCategoryType.MAGIC_TRIANGLE) {
      provider = Provider.of<MagicTriangleProvider>(context);
    } else if (type == GameCategoryType.MATH_MACHINE) {
      provider = Provider.of<MathGridProvider>(context);
    }
//    return Text(provider.time.toString(), style: TextStyle(fontSize: 20));
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("Score", style: Theme.of(context).textTheme.subhead),
              Text(provider.currentScore.toString(),
                  style: Theme.of(context).textTheme.headline)
            ],
          ),
          Visibility(
            visible: !(type == GameCategoryType.QUICK_CALCULATION) ? true : false ,
            child: Column(
                children: <Widget>[
                  Text("Timer", style: Theme.of(context).textTheme.subhead),
                  Text(provider.time.toString(),
                      style: Theme.of(context).textTheme.headline)
                ]
            ),
          )
        ],
      ),
    );
  }
}
