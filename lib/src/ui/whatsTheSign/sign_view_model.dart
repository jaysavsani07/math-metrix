import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/data/models/sign.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/time_constant.dart';

import '../common/game_view_model.dart';

class SignProvider with ChangeNotifier implements GameAccess<Sign> {
  late   GameViewModelImp gameViewModel;

  late  String _result;

  String get result => _result;

  late   int _time;

  int get time => _time;

  bool _pause = false;

  bool get pause => _pause;

  late   Sign _currentState;

  Sign get currentState => _currentState;

  double _currentScore = 0;

  double get currentScore => _currentScore;
  late   bool _timeOut;

  SignProvider() {
    gameViewModel = GameViewModelImp<Sign>(
        gameAccess: this, gameCategoryType: GameCategoryType.SIGN);
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

  void checkResult(String answer) async {
    if (!_timeOut) {
      _result = answer;
      notifyListeners();
      if (_result == _currentState.sign) {
        await Future.delayed(Duration(milliseconds: 300));
        gameViewModel.loadNewDataIfRequired();
        _time = TimeUtil.signTimeOut;
        _result = "";
        if (!_timeOut) {
          gameViewModel.restartGame();
        }
      } else {
        gameViewModel.wrongAnswer();
      }
    }
  }

  clear() {
    _result = "";
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
  void onCurrentStateUpdate(Sign currentState) {
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

  void dispose() {
    super.dispose();
    gameViewModel.exitGame();
  }
}
