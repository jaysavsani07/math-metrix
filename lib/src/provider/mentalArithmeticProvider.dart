import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/models/mentalArithmetic/mentalArithmeticQandS.dart';
import 'package:mathgame/src/resources/dialog_service.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/resources/mentalArithmetic/mentalArithmeticQandSDataProvider.dart';
import 'package:mathgame/src/resources/navigation_service.dart';
import 'package:mathgame/src/utility/coinUtil.dart';
import 'package:mathgame/src/provider/dashboardViewModel.dart';
import 'package:mathgame/src/utility/scoreUtil.dart';
import 'package:mathgame/src/utility/timeUtil.dart';

class MentalArithmeticProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();
  final DialogService _dialogService = GetIt.I<DialogService>();

  List<MentalArithmeticQandS> _list;
  MentalArithmeticQandS _currentState;
  String _result;
  int _index = 0;

  bool _timeOut;
  int _time;
  bool _localTimeOut;
  bool _pause = false;
  int currentScore = 0;

  bool get timeOut => _timeOut;

  String get result => _result;

  int get time => _time;

  bool get pause => _pause;

  StreamSubscription timerSubscription;
  StreamSubscription localTimerSubscription;

  MentalArithmeticQandS get currentState => _currentState;

  MentalArithmeticProvider() {
    startGame();
  }

  void startGame() {
    _list = MentalArithmeticQandSDataProvider.getMentalArithmeticDataList();
    _index = 0;
    currentScore = 0;
    _currentState = _list[_index];
    _time = TimeUtil.mentalArithmeticTimeOut;
    _timeOut = false;
    _result = "";
    startTimer();
    startLocalTimer();
  }

  Future<void> checkResult(String answer) async {
    if (_localTimeOut &&
        _result.length <= _currentState.answer.toString().length) {
      if (!timeOut) {
        _result = _result + answer;
        notifyListeners();
        if (_result != "-" && int.parse(_result) == _currentState.answer) {
          await Future.delayed(Duration(milliseconds: 300));
          _index = _index + 1;
          currentScore =  currentScore+(ScoreUtil.mentalArithmeticScore ).toInt();
          _currentState = _list[_index];
          _result = "";
          restartLocalTimer();
          notifyListeners();
        }
      }
    }
  }

  clear() {
    if (_localTimeOut) {
      if (!timeOut) {
        _result = "";
        notifyListeners();
      }
    }
  }

  void startLocalTimer() {
    _localTimeOut = false;
    _result = "";
    localTimerSubscription = Stream.periodic(Duration(seconds: 1), (x) => x)
        .take(TimeUtil.mentalArithmeticLocalTimeOut)
        .listen((time) {
      _currentState.currentQuestion = _currentState.questionList[time];
      notifyListeners();
    }, onDone: () {
      this._localTimeOut = true;
      notifyListeners();
    });
  }

  void startTimer() {
    timerSubscription = Stream.periodic(Duration(seconds: 1),
            (x) => TimeUtil.mentalArithmeticTimeOut - x - 1)
        .take(TimeUtil.mentalArithmeticTimeOut)
        .listen((time) {
      _time = time;
      notifyListeners();
    }, onDone: () {
      this._timeOut = true;
      showDialog();
      notifyListeners();
    });
  }

  void restartLocalTimer() {
    localTimerSubscription.cancel();
    startLocalTimer();
  }

  void pauseTimer() {
    _pause = true;
    timerSubscription.pause();
    localTimerSubscription.pause();
    notifyListeners();
    showDialog();
  }

  Future showDialog() async {
    notifyListeners();
    var dialogResult = await _dialogService.showDialog(
        gameCategoryType: GameCategoryType.MENTAL_ARITHMETIC,
        score:  currentScore.toDouble(),
        coin: _index * CoinUtil.mentalArithmeticCoin,
        isPause: _pause);

    if (dialogResult.exit) {
      homeViewModel.updateScoreboard(
          GameCategoryType.MENTAL_ARITHMETIC,
          currentScore.toDouble(),
          _index * CoinUtil.mentalArithmeticCoin);
      GetIt.I<NavigationService>().goBack();
    } else if (dialogResult.restart) {
      homeViewModel.updateScoreboard(
          GameCategoryType.MENTAL_ARITHMETIC,
          currentScore.toDouble(),
          _index * CoinUtil.mentalArithmeticCoin);
      timerSubscription.cancel();
      localTimerSubscription.cancel();
      startGame();
    } else if (dialogResult.play) {
      timerSubscription.resume();
      localTimerSubscription.resume();
      _pause = false;
      notifyListeners();
    }
    notifyListeners();
  }

  void dispose() {
    this.timerSubscription.cancel();
    this.localTimerSubscription.cancel();
  }
}
