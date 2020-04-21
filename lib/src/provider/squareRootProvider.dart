import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/models/squareRoot/SquareRootQandS.dart';
import 'package:mathgame/src/resources/dialog_service.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/resources/navigation_service.dart';
import 'package:mathgame/src/resources/squareRoot/squareRootQandSDataProvider.dart';
import 'package:mathgame/src/utility/coinUtil.dart';
import 'package:mathgame/src/provider/dashboardViewModel.dart';
import 'package:mathgame/src/utility/scoreUtil.dart';
import 'package:mathgame/src/utility/timeUtil.dart';

class SquareRootProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();
  final DialogService _dialogService = GetIt.I<DialogService>();

  List<SquareRootQandS> _list;
  SquareRootQandS _currentState;
  String _result;
  int _index = 0;

  bool _timeOut;
  int _time;
  bool _pause = false;

  bool get timeOut => _timeOut;

  String get result => _result;

  int get time => _time;

  bool get pause => _pause;

  StreamSubscription timerSubscription;

  SquareRootQandS get currentState => _currentState;

  SquareRootProvider() {
    startGame();
  }

  void startGame() {
    _list = SquareRootQandSDataProvider.getSquareDataList(1);
    _currentState = _list[_index];
    _time = TimeUtil.squareRootTimeOut;
    _timeOut = false;
    _result = "";
    startTimer();
  }

  Future<void> checkResult(String answer) async {
    if (!timeOut) {
      _result = answer;
      notifyListeners();
      if (int.parse(_result) == _currentState.answer) {
        await Future.delayed(Duration(milliseconds: 300));
        if (_list.length - 1 == _index) {
          _list.addAll(
              SquareRootQandSDataProvider.getSquareDataList(_index ~/ 5 + 1));
        }
        _index = _index + 1;
        _currentState = _list[_index];
        _result = "";
        restartTimer();
        notifyListeners();
      }
    }
  }

  clear() {
    _result = "";
    notifyListeners();
  }

  void startTimer() {
    timerSubscription = Stream.periodic(
            Duration(seconds: 1), (x) => TimeUtil.squareRootTimeOut - x - 1)
        .take(TimeUtil.squareRootTimeOut)
        .listen((time) {
      _time = time;
      notifyListeners();
    }, onDone: () {
      this._timeOut = true;
      showDialog();
      notifyListeners();
    });
  }

  void restartTimer() {
    timerSubscription.cancel();
    startTimer();
  }

  void pauseTimer() {
    _pause = true;
    timerSubscription.pause();
    notifyListeners();
    showDialog();
  }

  Future showDialog() async {
    notifyListeners();
    var dialogResult = await _dialogService.showDialog(
        gameCategoryType: GameCategoryType.SQUARE_ROOT,
        score: _index * ScoreUtil.squareRootScore,
        coin: _index * CoinUtil.squareRootCoin,
        isPause: _pause);

    if (dialogResult.exit) {
      homeViewModel.updateScoreboard(GameCategoryType.SQUARE_ROOT,
          _index * ScoreUtil.squareRootScore, _index * CoinUtil.squareRootCoin);
      GetIt.I<NavigationService>().goBack();
    } else if (dialogResult.restart) {
      homeViewModel.updateScoreboard(GameCategoryType.SQUARE_ROOT,
          _index * ScoreUtil.squareRootScore, _index * CoinUtil.squareRootCoin);
      timerSubscription.cancel();
      _index = 0;
      startGame();
    } else if (dialogResult.play) {
      timerSubscription.resume();
      _pause = false;
      notifyListeners();
    }
    notifyListeners();
  }

  void dispose() {
    this.timerSubscription.cancel();
  }
}
