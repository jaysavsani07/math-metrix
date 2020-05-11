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
import 'package:mathgame/src/utility/keyUtil.dart';
import 'package:mathgame/src/utility/scoreUtil.dart';
import 'package:mathgame/src/utility/timeUtil.dart';

class SquareRootProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();
  final DialogService _dialogService = GetIt.I<DialogService>();

  List<SquareRootQandS> _list;
  SquareRootQandS _currentState;
  String _result;
  int _index = 0;
  int currentScore = 0;

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
    _index = 0;
    currentScore = 0;
    _currentState = _list[_index];
    _time = TimeUtil.squareRootTimeOut;
    _timeOut = false;
    _result = "";
    startTimer();
    if (homeViewModel.isFirstTime(GameCategoryType.SQUARE_ROOT)) {
      showInfoDialogWithDelay();
    }
  }

  Future<void> checkResult(String answer) async {
    if (!timeOut) {
      _result = answer;
      notifyListeners();
      if (int.parse(_result) == _currentState.answer) {
        await Future.delayed(Duration(milliseconds: 300));
        if (_list.length - 1 == _index) {
          _list.addAll(
              SquareRootQandSDataProvider.getSquareDataList(_index ~/ 5 + 2));
          print("_index $_index");
        }
        _index = _index + 1;
        currentScore = currentScore + (ScoreUtil.squareRootScore).toInt();
        _currentState = _list[_index];
        _result = "";
        restartTimer();
        notifyListeners();
      } else {
        if (currentScore > 0) {
          currentScore =
              currentScore + (ScoreUtil.squareRootScoreMinus).toInt();
        }
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
        type: KeyUtil.GameOverDialog,
        gameCategoryType: GameCategoryType.SQUARE_ROOT,
        score: currentScore.toDouble(),
        coin: _index * CoinUtil.squareRootCoin,
        isPause: _pause);

    if (dialogResult.exit) {
      homeViewModel.updateScoreboard(GameCategoryType.SQUARE_ROOT,
          currentScore.toDouble(), _index * CoinUtil.squareRootCoin);
      GetIt.I<NavigationService>().goBack();
    } else if (dialogResult.restart) {
      homeViewModel.updateScoreboard(GameCategoryType.SQUARE_ROOT,
          currentScore.toDouble(), _index * CoinUtil.squareRootCoin);
      timerSubscription.cancel();
      startGame();
    } else if (dialogResult.play) {
      timerSubscription.resume();
      _pause = false;
      notifyListeners();
    }
    notifyListeners();
  }

  Future showInfoDialogWithDelay() async {
    await Future.delayed(Duration(milliseconds: 500));
    showInfoDialog();
  }

  Future showInfoDialog() async {
    _pause = true;
    timerSubscription.pause();
    notifyListeners();
    var dialogResult = await _dialogService.showDialog(
        type: KeyUtil.InfoDialog,
        gameCategoryType: GameCategoryType.SQUARE_ROOT,
        score: 0,
        coin: 0,
        isPause: false);

    if (dialogResult.exit) {
      homeViewModel.setFirstTime(GameCategoryType.SQUARE_ROOT);
      timerSubscription.resume();
      _pause = false;
      notifyListeners();
    }
  }

  void dispose() {
    this.timerSubscription.cancel();
  }
}
