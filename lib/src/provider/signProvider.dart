import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/models/whatsTheSign/SignQandS.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/utility/timeUtil.dart';

import 'gameViewModel.dart';

class SignProvider with ChangeNotifier implements GameAccess<SignQandS> {
  GameViewModelImp gameViewModel;

  String _result;

  String get result => _result;

  int _time;

  int get time => _time;

  bool _pause = false;

  bool get pause => _pause;

  SignQandS _currentState;

  SignQandS get currentState => _currentState;

  double _currentScore = 0;

  double get currentScore => _currentScore;
  bool _timeOut;

  SignProvider() {
    gameViewModel = GameViewModelImp<SignQandS>(
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
  void onCurrentStateUpdate(SignQandS currentState) {
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
