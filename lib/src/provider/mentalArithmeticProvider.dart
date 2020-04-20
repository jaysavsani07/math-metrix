import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/models/mentalArithmetic/mentalArithmeticQandS.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/resources/mentalArithmetic/mentalArithmeticQandSDataProvider.dart';
import 'package:mathgame/src/utility/dashboardViewModel.dart';
import 'package:mathgame/src/utility/scoreUtil.dart';
import 'package:mathgame/src/utility/timeUtil.dart';

class MentalArithmeticProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();

  List<MentalArithmeticQandS> _list;
  MentalArithmeticQandS _currentState;
  String _result;
  int _index = 0;

  bool _timeOut;
  int _time;
  bool _localTimeOut;

  bool get timeOut => _timeOut;

  String get result => _result;

  int get time => _time;

  StreamSubscription timerSubscription;
  StreamSubscription localTimerSubscription;

  MentalArithmeticQandS get currentState => _currentState;

  MentalArithmeticProvider() {
    _list = MentalArithmeticQandSDataProvider.getMentalArithmeticDataList();
    _currentState = _list[_index];
    _time = TimeUtil.mentalArithmeticTimeOut;
    _timeOut = false;
    _result = "";
    startTimer();
    startLocalTimer();
  }

  Future<void> checkResult(String answer) async {
    if (_localTimeOut) {
      if (!timeOut) {
        _result = _result + answer;
        notifyListeners();
        if (_result != "-" && int.parse(_result) == _currentState.answer) {
          await Future.delayed(Duration(milliseconds: 300));
          _index = _index + 1;
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
      homeViewModel.updateScoreboard(GameCategoryType.MENTAL_ARITHMETIC,
          _index * ScoreUtil.mentalArithmeticScore);
      this._timeOut = true;
      notifyListeners();
    });
  }

  void restartLocalTimer() {
    localTimerSubscription.cancel();
    startLocalTimer();
  }

  void dispose() {
    this.timerSubscription.cancel();
    this.localTimerSubscription.cancel();
  }
}
