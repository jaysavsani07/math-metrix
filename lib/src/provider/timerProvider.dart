import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mathgame/src/utility/timeUtil.dart';

class TimerViewModel with ChangeNotifier {
  bool _timeOut;
  int _time;

  bool get timeOut => _timeOut;

  int get time => _time;

  Stream<int> timer;

  TimerViewModel() {
    _timeOut = false;
    startTimer();
  }

  void startTimer() {
    timer = Stream.periodic(
            Duration(seconds: 1), (x) => TimeUtil.calculatorTimeOut - x - 1)
        .take(TimeUtil.calculatorTimeOut)
        .map((time) {
      _time = time;
      notifyListeners();
      return time;
    });
  }

  void restartTimer() {
    startTimer();
  }
}
