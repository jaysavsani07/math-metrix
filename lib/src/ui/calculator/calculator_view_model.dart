import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/data/models/calculator.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/time_constant.dart';

import '../common/game_view_model.dart';

class CalculatorProvider1 with ChangeNotifier implements GameAccess<Calculator> {
  late GameViewModelImp gameViewModel;

  late String _result;

  String get result => _result;

  late int _time;

  int get time => _time;

  bool _pause = false;

  bool get pause => _pause;

  late Calculator _currentState;

  Calculator get currentState => _currentState;

  double _currentScore = 0;

  double get currentScore => _currentScore;
  late bool _timeOut;

  CalculatorProvider1() {
    gameViewModel = GameViewModelImp<Calculator>(
        gameAccess: this, gameCategoryType: GameCategoryType.CALCULATOR);
    startGame1();
  }

  @override
  void startGame1() {
    _time = TimeUtil.calculatorTimeOut;
    _timeOut = false;
    _result = "";
    _currentScore = 0;
    gameViewModel.startGame();
  }

  void checkGameResult(String answer) async {
    if (_result.length < currentState.answer.toString().length && !_timeOut) {
      _result = _result + answer;
      notifyListeners();
      if (int.parse(_result) == currentState.answer) {
        await Future.delayed(Duration(milliseconds: 300));
        gameViewModel.loadNewDataIfRequired();
        _result = "";
        _time = TimeUtil.calculatorTimeOut;
        if (!_timeOut) {
          gameViewModel.restartGame();
        }
        notifyListeners();
      } else if (_result.length == currentState.answer.toString().length) {
        gameViewModel.wrongAnswer();
      }
    }
  }

  void clearGameInput() {
    _result = "";
    notifyListeners();
  }

  @override
  void onGameTimeOut() {
    this._timeOut = true;
  }

  @override
  void onGameTimeUpdate(int time) {
    _time = time;
    notifyListeners();
  }

  @override
  void onCurrentStateUpdate(Calculator currentState) {
    _currentState = currentState;
    notifyListeners();
  }

  @override
  void onScoreUpdate(double time) {
    _currentScore = time;
    notifyListeners();
  }

  @override
  void onResumeGame() {
    _pause = false;
    notifyListeners();
  }

  void pauseGame() {
    _pause = true;
    gameViewModel.pauseGame();
    notifyListeners();
    gameViewModel.showPauseGameDialog();
  }

  void showInfoDialog() {
    _pause = true;
    gameViewModel.pauseGame();
    gameViewModel.showInfoDialog();
  }

  void dispose() {
    super.dispose();
    gameViewModel.exitGame();
  }
}
