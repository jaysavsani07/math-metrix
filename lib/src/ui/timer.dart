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
import 'package:mathgame/src/utility/timeUtil.dart';
import 'package:provider/provider.dart';

class Timer extends StatefulWidget {
  final GameCategoryType type;

  Timer(this.type);

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> avatarSize;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 2200),
      vsync: this,
    );
    avatarSize = Tween(begin: 0.0, end: 1.0).animate(
      new CurvedAnimation(
        parent: _controller,
        curve: new Interval(
          0.100,
          0.400,
          curve: Curves.elasticOut,
        ),
      ),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider;
    int timeConstant;
    if (widget.type == GameCategoryType.CALCULATOR) {
      provider = Provider.of<CalculatorProvider>(context);
      timeConstant = TimeUtil.calculatorTimeOut;
    } else if (widget.type == GameCategoryType.SIGN) {
      provider = Provider.of<SignProvider>(context);
      timeConstant = TimeUtil.signTimeOut;
    } else if (widget.type == GameCategoryType.SQUARE_ROOT) {
      provider = Provider.of<SquareRootProvider>(context);
      timeConstant = TimeUtil.squareRootTimeOut;
    } else if (widget.type == GameCategoryType.MATH_PAIRS) {
      provider = Provider.of<MathPairsProvider>(context);
      timeConstant = TimeUtil.mathMachineTimeOut;
    } else if (widget.type == GameCategoryType.CORRECT_ANSWER) {
      provider = Provider.of<CorrectAnswerProvider>(context);
      timeConstant = TimeUtil.correctAnswerTimeOut;
    } else if (widget.type == GameCategoryType.MENTAL_ARITHMETIC) {
      provider = Provider.of<MentalArithmeticProvider>(context);
      timeConstant = TimeUtil.mentalArithmeticTimeOut;
    } else if (widget.type == GameCategoryType.QUICK_CALCULATION) {
      provider = Provider.of<QuickCalculationProvider>(context);
      timeConstant = TimeUtil.quickCalculationTimeOut;
    } else if (widget.type == GameCategoryType.MAGIC_TRIANGLE) {
      provider = Provider.of<MagicTriangleProvider>(context);
      timeConstant = TimeUtil.magicTriangleTimeOut;
    } else if (widget.type == GameCategoryType.MATH_MACHINE) {
      provider = Provider.of<MathGridProvider>(context);
      timeConstant = TimeUtil.mathMachineTimeOut;
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
            visible: !(widget.type == GameCategoryType.QUICK_CALCULATION)
                ? true
                : false,
            child: Column(children: <Widget>[
              Text("Timer", style: Theme.of(context).textTheme.subhead),
              Text(provider.time.toString(),
                  style: Theme.of(context).textTheme.headline)
            ]),
          )
        ],
      ),
    );
  }
}
