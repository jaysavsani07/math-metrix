import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/data/models/mental_arithmetic.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/app/game_provider.dart';

class MentalArithmeticProvider extends GameProvider<MentalArithmetic> {
  late String result;

  MentalArithmeticProvider({required TickerProvider vsync})
      : super(
            vsync: vsync,
            gameCategoryType: GameCategoryType.MENTAL_ARITHMETIC) {
    startGame();
  }

  Future<void> checkResult(String answer) async {
    if (timerStatus != TimerStatus.pause &&
        result.length < currentState.answer.toString().length &&
        ((result.length == 0 && answer == "-") || (answer != "-"))) {
      result = result + answer;
      notifyListeners();
      if (result != "-" && int.parse(result) == currentState.answer) {
        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired();
        notifyListeners();
      } else if (result.length == currentState.answer.toString().length) {
        if (currentScore > 0) {
          wrongAnswer();
        }
      }
    }
  }

  void backPress() {
    if (result.length > 0) {
      result = result.substring(0, result.length - 1);
      notifyListeners();
    }
  }

  void clearResult() {
    result = "";
    notifyListeners();
  }
}
