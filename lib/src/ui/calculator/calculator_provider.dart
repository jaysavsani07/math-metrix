import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/data/models/calculator.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/common/game_provider.dart';

class CalculatorProvider extends GameProvider<Calculator> {
  late String _result;

  String get result => _result;

  CalculatorProvider({required TickerProvider vsync})
      : super(vsync: vsync,gameCategoryType: GameCategoryType.CALCULATOR) {
    _result = "";
    startGame();
  }

  void checkResult(String answer) async {
    if (_result.length < currentState.answer.toString().length &&
        timerStatus != TimerStatus.pause) {
      _result = _result + answer;
      notifyListeners();
      if (int.parse(_result) == currentState.answer) {
        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired();
        _result = "";
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }
        notifyListeners();
      } else if (_result.length == currentState.answer.toString().length) {
        wrongAnswer();
      }
    }
  }

  void backPress() {
    if (_result.length > 0) {
      _result = _result.substring(0, _result.length - 1);
      notifyListeners();
    }
  }

  void clearResult() {
    _result = "";
    notifyListeners();
  }
}
