import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/models/correctAnswer/correctAnswerQandS.dart';
import 'package:mathgame/src/resources/correctAnswer/correctAnswerQandSDataProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/utility/dashboardViewModel.dart';
import 'package:mathgame/src/utility/timeUtil.dart';

class CorrectAnswerProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();

  List<CorrectAnswerQandS> _list;
  CorrectAnswerQandS _currentState;
  String _result;
  int _index = 0;

  bool _timeOut;
  int _time;

  bool get timeOut => _timeOut;

  String get result => _result;

  int get time => _time;

  StreamSubscription timerSubscription;

  CorrectAnswerQandS get currentState => _currentState;

  CorrectAnswerProvider() {
    _list = CorrectAnswerQandSDataProvider.getCorrectAnswerDataList(1);
    _currentState = _list[_index];
    _time = TimeUtil.correctAnswerTimeOut;
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
          _list.addAll(CorrectAnswerQandSDataProvider.getCorrectAnswerDataList(
              _index ~/ 5 + 1));
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
            Duration(seconds: 1), (x) => TimeUtil.correctAnswerTimeOut - x - 1)
        .take(TimeUtil.correctAnswerTimeOut)
        .listen((time) {
      _time = time;
      notifyListeners();
    }, onDone: () {
      homeViewModel.updateScoreboard(GameCategoryType.CORRECT_ANSWER, _index);
      this._timeOut = true;
      notifyListeners();
    });
  }

  void restartTimer() {
    timerSubscription.cancel();
    startTimer();
  }

  void dispose() {
    this.timerSubscription.cancel();
  }
}
