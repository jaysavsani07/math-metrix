import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/data/models/quick_calculation.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/common/game_provider.dart';

class QuickCalculationProvider extends GameProvider<QuickCalculation> {
  late String _result;

  String get result => _result;

  late QuickCalculation nextCurrentState;
  QuickCalculation? previousCurrentState;

  QuickCalculationProvider({required TickerProvider vsync})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.QUICK_CALCULATION) {
    _result = "";
    startGame();
    nextCurrentState = list[index + 1];
  }

  Future<void> checkResult(String answer) async {
    if (_result.length < currentState.answer.toString().length &&
        timerStatus != TimerStatus.pause) {
      _result = _result + answer;
      notifyListeners();
      if (int.parse(_result) == currentState.answer) {
        await Future.delayed(Duration(milliseconds: 300));
        _result = "";
        loadNewDataIfRequired();
        previousCurrentState = list[index - 1];
        nextCurrentState = list[index + 1];
        if (/*time >= 0.0125*/ timerStatus != TimerStatus.pause) increase();
        notifyListeners();
      } else if (_result.length == currentState.answer.toString().length) {
        if (currentScore > 0) {
          wrongAnswer();
        }
      }
    }
  }

  clearResult() {
    _result = "";
    notifyListeners();
  }

  void backPress() {
    if (_result.length > 0) {
      _result = _result.substring(0, _result.length - 1);
      notifyListeners();
    }
  }
}
