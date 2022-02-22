import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/data/models/square_root.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/common/game_provider.dart';

class SquareRootProvider extends GameProvider<SquareRoot> {
  late String _result;

  String get result => _result;

  SquareRootProvider({required TickerProvider vsync})
      : super(vsync: vsync, gameCategoryType: GameCategoryType.SQUARE_ROOT) {
    _result = "";
    startGame();
  }

  Future<void> checkResult(String answer) async {
    if (_result.length < currentState.answer.toString().length &&
        timerStatus != TimerStatus.pause) {
      _result = answer;
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
}
