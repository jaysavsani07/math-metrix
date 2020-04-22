import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/models/calculator/calculatorQandS.dart';
import 'package:mathgame/src/resources/calculator/calculatorQandSDataProvider.dart';
import 'package:mathgame/src/resources/dialog_service.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/resources/navigation_service.dart';
import 'package:mathgame/src/utility/coinUtil.dart';
import 'package:mathgame/src/utility/scoreUtil.dart';
import 'package:mathgame/src/utility/timeUtil.dart';

import 'dashboardViewModel.dart';

class CalculatorProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();
  final DialogService _dialogService = GetIt.I<DialogService>();

  List<CalculatorQandS> _list;
  CalculatorQandS _currentState;
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

  CalculatorQandS get currentState => _currentState;

  CalculatorProvider() {
    startGame();
  }

  void startGame() {
    _list = CalculatorQandSDataProvider.getCalculatorDataList(1);
    _currentState = _list[_index];
    _time = TimeUtil.calculatorTimeOut;
    _timeOut = false;
    _result = "";
    startTimer();
  }

  Future<void> checkResult(String answer) async {
    if (_result.length < 2 && !timeOut) {
      _result = _result + answer;
      notifyListeners();
      if (int.parse(_result) == _currentState.answer) {
        currentScore =
            currentScore + (ScoreUtil.calculatorScore * _time).toInt();
        await Future.delayed(Duration(milliseconds: 300));
        if (_list.length - 1 == _index) {
          _list.addAll(CalculatorQandSDataProvider.getCalculatorDataList(
              _index ~/ 5 + 1));
        }
        _index = _index + 1;
        _result = "";
        _time = TimeUtil.calculatorTimeOut;
        _currentState = _list[_index];
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
            Duration(seconds: 1), (x) => TimeUtil.calculatorTimeOut - x - 1)
        .take(TimeUtil.calculatorTimeOut)
        .listen((time) {
      _time = time;
      print("$time ${time / 5}  ");
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
        gameCategoryType: GameCategoryType.CALCULATOR,
        score: _index * ScoreUtil.calculatorScore,
        coin: _index * CoinUtil.calculatorCoin,
        isPause: _pause);

    if (dialogResult.exit) {
      homeViewModel.updateScoreboard(GameCategoryType.CALCULATOR,
          _index * ScoreUtil.calculatorScore, _index * CoinUtil.calculatorCoin);
      GetIt.I<NavigationService>().goBack();
    } else if (dialogResult.restart) {
      homeViewModel.updateScoreboard(GameCategoryType.CALCULATOR,
          _index * ScoreUtil.calculatorScore, _index * CoinUtil.calculatorCoin);
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
