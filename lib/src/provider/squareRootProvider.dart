import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/models/squareRoot/SquareRootQandS.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/utility/timeUtil.dart';

import 'gameViewModel.dart';

class SquareRootProvider
    with ChangeNotifier
    implements GameAccess<SquareRootQandS> {
  GameViewModelImp gameViewModel;

  String _result;

  String get result => _result;

  int _time;

  int get time => _time;

  bool _pause = false;

  bool get pause => _pause;

  SquareRootQandS _currentState;

  SquareRootQandS get currentState => _currentState;

  double _currentScore = 0;

  double get currentScore => _currentScore;
  bool _timeOut;

  SquareRootProvider() {
    gameViewModel = GameViewModelImp<SquareRootQandS>(
        gameAccess: this, gameCategoryType: GameCategoryType.SQUARE_ROOT);
    startGame1();
  }

  @override
  void startGame1() {
    _time = TimeUtil.squareRootTimeOut;
    _timeOut = false;
    _result = "";
    _currentScore = 0;
    gameViewModel.startGame();
  }

  Future<void> checkResult(String answer) async {
    if (_result.length < currentState.answer.toString().length && !_timeOut) {
      _result = answer;
      notifyListeners();
      if (int.parse(_result) == currentState.answer) {
        await Future.delayed(Duration(milliseconds: 300));
/*<<<<<<< HEAD
        if (_list.length - 1 == _index) {
          _list.addAll(
              SquareRootQandSDataProvider.getSquareDataList(_index ~/ 5 + 2));
          print("_index $_index");
        }
        _index = _index + 1;
        currentScore = currentScore + ScoreUtil.squareRootScore;
        _currentState = _list[_index];
=======*/
        gameViewModel.loadNewDataIfRequired();
        _result = "";
        _time = TimeUtil.squareRootTimeOut;
        if (!_timeOut) {
          gameViewModel.restartGame();
        }
        notifyListeners();
      } else if (_result.length == currentState.answer.toString().length) {
        gameViewModel.wrongAnswer();
        _result = "";
      }
    }
  }

  clear() {
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
  void onCurrentStateUpdate(SquareRootQandS currentState) {
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

  void pauseTimer() {
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
