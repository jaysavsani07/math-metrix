import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/calculatorProvider.dart';
import 'package:mathgame/src/provider/correctAnswerProvider.dart';
import 'package:mathgame/src/provider/mathPairsProvider.dart';
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
    }
    return Text(provider.time.toString(), style: TextStyle(fontSize: 20));
  }
}
