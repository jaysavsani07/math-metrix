import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/MagicTriangleProvider.dart';
import 'package:mathgame/src/provider/MathGridProvider.dart';
import 'package:mathgame/src/provider/calculatorProvider.dart';
import 'package:mathgame/src/provider/correctAnswerProvider.dart';
import 'package:mathgame/src/provider/mathPairsProvider.dart';
import 'package:mathgame/src/provider/mentalArithmeticProvider.dart';
import 'package:mathgame/src/provider/picturePuzzleProvider.dart';
import 'package:mathgame/src/provider/quickCalculationProvider.dart';
import 'package:mathgame/src/provider/signProvider.dart';
import 'package:mathgame/src/provider/squareRootProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/utility/timeUtil.dart';
import 'package:provider/provider.dart';

class Timer extends StatelessWidget {
  final GameCategoryType type;

  Timer(this.type);

  @override
  Widget build(BuildContext context) {
    var provider;
    int timeConstant;
    if (type == GameCategoryType.CALCULATOR) {
      provider = Provider.of<CalculatorProvider>(context);
      timeConstant = TimeUtil.calculatorTimeOut;
    } else if (type == GameCategoryType.SIGN) {
      provider = Provider.of<SignProvider>(context);
      timeConstant = TimeUtil.signTimeOut;
    } else if (type == GameCategoryType.SQUARE_ROOT) {
      provider = Provider.of<SquareRootProvider>(context);
      timeConstant = TimeUtil.squareRootTimeOut;
    } else if (type == GameCategoryType.MATH_PAIRS) {
      provider = Provider.of<MathPairsProvider>(context);
      timeConstant = TimeUtil.mathMachineTimeOut;
    } else if (type == GameCategoryType.CORRECT_ANSWER) {
      provider = Provider.of<CorrectAnswerProvider>(context);
      timeConstant = TimeUtil.correctAnswerTimeOut;
    } else if (type == GameCategoryType.MENTAL_ARITHMETIC) {
      provider = Provider.of<MentalArithmeticProvider>(context);
      timeConstant = TimeUtil.mentalArithmeticTimeOut;
    } else if (type == GameCategoryType.QUICK_CALCULATION) {
      provider = Provider.of<QuickCalculationProvider>(context);
      timeConstant = TimeUtil.quickCalculationTimeOut;
    } else if (type == GameCategoryType.MAGIC_TRIANGLE) {
      provider = Provider.of<MagicTriangleProvider>(context);
      timeConstant = TimeUtil.magicTriangleTimeOut;
    } else if (type == GameCategoryType.MATH_MACHINE) {
      provider = Provider.of<MathGridProvider>(context);
      timeConstant = TimeUtil.mathMachineTimeOut;
    } else if (type == GameCategoryType.PICTURE_PUZZLE) {
      provider = Provider.of<PicturePuzzleProvider>(context);
      timeConstant = TimeUtil.picturePuzzleTimeOut;
    }
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("Score", style: Theme.of(context).textTheme.subhead),
              Text(provider.currentScore.toInt().toString(),
                  style: Theme.of(context).textTheme.headline)
            ],
          ),
          /* Visibility(
            visible:
                !(type == GameCategoryType.QUICK_CALCULATION) ? true : false,
            child: LinearPercentIndicator(
              width: 140.0,
              lineHeight: 14.0,
              animation: true,
              animateFromLastPercent: true,
              animationDuration: 1000,
              percent: provider.time / timeConstant,
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
            ),
          ),*/
          Visibility(
            visible:
                !(type == GameCategoryType.QUICK_CALCULATION) ? true : false,
            child: Column(children: <Widget>[
              Text("Timer", style: Theme.of(context).textTheme.subhead),
              Text(provider.time.toString(),
                  style: Theme.of(context).textTheme.headline),
              /* AnimatedSwitcher(
                  duration: Duration(milliseconds: 700),
                  child: provider.time % 2 == 1
                      ? Text(provider.time.toString(),
                      key: Key("1"),
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline)
                      : Text(provider.time.toString(),
                      key: Key("2"),
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline))*/
            ]),
          )
        ],
      ),
    );
  }
}
