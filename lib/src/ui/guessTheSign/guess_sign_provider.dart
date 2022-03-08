import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/data/models/sign.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/app/game_provider.dart';

class GuessSignProvider extends GameProvider<Sign> {

  GuessSignProvider({required TickerProvider vsync})
      : super(vsync: vsync, gameCategoryType: GameCategoryType.GUESS_SIGN) {
    startGame();
  }

  void checkResult(String answer) async {
    if (timerStatus != TimerStatus.pause) {
      result = answer;
      notifyListeners();
      if (result == currentState.sign) {
        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired();
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }
        notifyListeners();
      } else {
        wrongAnswer();
      }
    }
  }
}
