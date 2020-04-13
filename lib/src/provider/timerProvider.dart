import 'dart:async';

import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  bool _timeOut;
  int _time;

  bool get timeOut => _timeOut;

  int get time => _time;

  StreamSubscription timerSubscription;

  TimerProvider() {
    _timeOut = false;
    startTimer();
  }

  void startTimer() {
    timerSubscription =
        Stream.periodic(Duration(seconds: 1), (x) => 6 - x - 1).listen((time) {
      _time = time;
      print(time);
      notifyListeners();
    }, onDone: () {
      this._timeOut = true;
      notifyListeners();
    });
  }

  void restartTimer() {
    startTimer();
  }

  void dispose() {
    this.timerSubscription.cancel();
  }
}
