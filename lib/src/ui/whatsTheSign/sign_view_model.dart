import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/data/models/sign.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/common/game_provider.dart';

class SignProvider extends GameProvider<Sign> {
  late String _result;

  String get result => _result;

  SignProvider({required TickerProvider vsync})
      : super(vsync: vsync, gameCategoryType: GameCategoryType.SIGN) {
    _result = "";
    startGame();
  }

  void checkResult(String answer) async {
    if (timerStatus != TimerStatus.pause) {
      _result = answer;
      notifyListeners();
      if (_result == currentState.sign) {
        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired();
        _result = "";
        if (timerStatus != TimerStatus.pause) {
          startTimer();
        }
        notifyListeners();
      } else {
        wrongAnswer();
      }
    }
  }
}
