import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/data/models/mental_arithmetic.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/common/game_provider.dart';

class MentalArithmeticProvider extends GameProvider<MentalArithmetic> {
  late String _result;

  String get result => _result;

  MentalArithmeticProvider({required TickerProvider vsync})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.MENTAL_ARITHMETIC) {
    _result = "";
    startGame();
  }

  Future<void> checkResult(String answer) async {
    if (timerStatus != TimerStatus.pause &&
        _result.length < currentState.answer.toString().length &&
        ((_result.length == 0 && answer == "-") || (answer != "-"))) {
      _result = _result + answer;
      notifyListeners();
      if (_result != "-" && int.parse(_result) == currentState.answer) {
        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired();
        _result = "";
        notifyListeners();
      } else if (_result.length == currentState.answer.toString().length) {
        if (currentScore > 0) {
          wrongAnswer();
        }
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
