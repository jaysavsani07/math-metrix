import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/calculatorProvider.dart';
import 'package:mathgame/src/provider/signProvider.dart';
import 'package:mathgame/src/provider/squareRootProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:provider/provider.dart';

class Timer extends StatelessWidget {
  final GameCategoryType type;

  Timer(this.type);

  @override
  Widget build(BuildContext context) {
    var timerProvider;
    if (type == GameCategoryType.CALCULATOR) {
      timerProvider = Provider.of<CalculatorProvider>(context);
    } else if (type == GameCategoryType.SIGN) {
      timerProvider = Provider.of<SignProvider>(context);
    } else if (type == GameCategoryType.SQUARE_ROOT) {
      timerProvider = Provider.of<SquareRootProvider>(context);
    }
    return Text(timerProvider.time.toString(), style: TextStyle(fontSize: 20));
  }
}
