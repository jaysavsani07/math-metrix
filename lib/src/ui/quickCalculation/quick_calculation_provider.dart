import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/data/models/quick_calculation.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/app/game_provider.dart';

class QuickCalculationProvider extends GameProvider<QuickCalculation> {

  late QuickCalculation nextCurrentState;
  QuickCalculation? previousCurrentState;

  QuickCalculationProvider({required TickerProvider vsync})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.QUICK_CALCULATION) {
    startGame();
    nextCurrentState = list[index + 1];
  }

  Future<void> checkResult(String answer) async {
    if (result.length < currentState.answer.toString().length &&
        timerStatus != TimerStatus.pause) {
      result = result + answer;
      notifyListeners();
      if (int.parse(result) == currentState.answer) {
        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired();
        previousCurrentState = list[index - 1];
        nextCurrentState = list[index + 1];
        if (/*time >= 0.0125*/ timerStatus != TimerStatus.pause) increase();
        notifyListeners();
      } else if (result.length == currentState.answer.toString().length) {
        if (currentScore > 0) {
          wrongAnswer();
        }
      }
    }
  }

  clearResult() {
    result = "";
    notifyListeners();
  }

  void backPress() {
    if (result.length > 0) {
      result = result.substring(0, result.length - 1);
      notifyListeners();
    }
  }
}
