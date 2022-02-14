import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/data/models/correct_answer.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/time_constant.dart';
import 'package:mathgame/src/ui/common/game_provider.dart';

import '../common/game_view_model.dart';

class CorrectAnswerProvider extends GameProvider<CorrectAnswer> {
  late String _result;

  String get result => _result;

  CorrectAnswerProvider()
      : super(gameCategoryType: GameCategoryType.CORRECT_ANSWER) {
    _result = "";
    startGame();
  }

  // @override
  // void startGame1() {
  //   _time = TimeUtil.calculatorTimeOut;
  //   _timeOut = false;
  //   _result = "";
  //   _currentScore = 0;
  //   gameViewModel.startGame();
  // }

  Future<void> checkResult(String answer) async {
    if (timerStatus != TimerStatus.pause) {
      _result = answer;
      notifyListeners();
      if (int.parse(_result) == currentState.answer) {
        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired();
        _result = "";
        if (timerStatus != TimerStatus.pause) {
          startTimer();
        }
        notifyListeners();
      } else {
        wrongAnswer();
        _result = "";
      }
    }
  }

// clear() {
//   _result = "";
//   notifyListeners();
// }

// void showInfoDialog() {
//   _pause = true;
//   gameViewModel.pauseGame();
//   gameViewModel.showInfoDialog();
// }

// void pauseTimer() {
//   _pause = true;
//   gameViewModel.pauseGame();
//   notifyListeners();
//   gameViewModel.showPauseGameDialog();
// }

// @override
// void onGameTimeOut() {
//   this._timeOut = true;
// }
//
// @override
// void onGameTimeUpdate(int time) {
//   _time = time;
//   notifyListeners();
// }
//
// @override
// void onCurrentStateUpdate(CorrectAnswer currentState) {
//   _currentState = currentState;
//   notifyListeners();
// }
//
// @override
// void onScoreUpdate(double time) {
//   _currentScore = time;
//   notifyListeners();
// }
//
// @override
// void onResumeGame() {
//   _pause = false;
//   notifyListeners();
// }
//
// void dispose() {
//   super.dispose();
//   gameViewModel.exitGame();
// }
}
