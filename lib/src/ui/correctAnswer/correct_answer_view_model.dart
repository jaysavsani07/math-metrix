import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/data/models/correct_answer.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/common/game_provider.dart';

class CorrectAnswerProvider extends GameProvider<CorrectAnswer> {
  late String _result;

  String get result => _result;

  CorrectAnswerProvider({required TickerProvider vsync})
      : super(vsync: vsync, gameCategoryType: GameCategoryType.CORRECT_ANSWER) {
    _result = "";
    startGame();
  }

  Future<void> checkResult(String answer) async {
    if (timerStatus != TimerStatus.pause) {
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
      } else {
        wrongAnswer();
        _result = "";
      }
    }
  }
}
