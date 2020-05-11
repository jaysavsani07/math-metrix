import 'dart:async';

import 'package:flutter/material.dart';

abstract class TimerViewModel {
  bool get timeOutNew;

  void startTimerNew();

  void pauseTimerNew();

  void resumeTimerNew();

  void cancelTimerNew();
}

abstract class TimerAccess {
  void timeOutNew();

  void timeUpdate(int time);
}

class TimerViewModelImpl extends TimerViewModel {
  int oneSec = 1;
  int totalTime;

  TimerAccess timerAccess;
  Stream<int> _timer;
  bool _timeOutNew;
  StreamSubscription _timeSubscription;

  TimerViewModelImpl({@required this.timerAccess, @required this.totalTime});

  Stream<int> timedCounter(int interval, int maxCount) {
    StreamController<int> controller;
    Timer timer;
    int counter = maxCount;

    void tick(_) {
      counter = counter - interval;
      controller.add(counter); // Ask stream to send counter values as event.
      if (counter == 0) {
        timer.cancel();
        controller.close(); // Ask stream to shut down and tell listeners.
      }
    }

    void startTimer() {
      timer = Timer.periodic(Duration(seconds: interval), tick);
    }

    void stopTimer() {
      if (timer != null) {
        timer.cancel();
        timer = null;
      }
    }

    controller = StreamController<int>(
        onListen: startTimer,
        onPause: stopTimer,
        onResume: startTimer,
        onCancel: stopTimer);

    return controller.stream;
  }

  void _onTimeChange(int newTime) {
//    print(newTime);
    timerAccess.timeUpdate(newTime);
  }

  void _handleTimerEnd() {
    timerAccess.timeOutNew();
    _timeOutNew = true;
    _timeSubscription = null;
  }

  @override
  void startTimerNew() {
    cancelTimerNew();
    _timer = timedCounter(oneSec, totalTime);
    _timeOutNew = false;
    _timeSubscription = _timer.listen(_onTimeChange);
    _timeSubscription.onDone(_handleTimerEnd);
  }

  @override
  void pauseTimerNew() {
    if (_timeSubscription != null) {
      _timeSubscription.pause();
    }
  }

  @override
  void resumeTimerNew() {
    if (_timeSubscription != null) {
      _timeSubscription.resume();
    }
  }

  @override
  void cancelTimerNew() {
    if (_timeSubscription != null) {
      _timeSubscription.cancel();
    }
  }

  @override
  bool get timeOutNew {
    return _timeOutNew;
  }
}
