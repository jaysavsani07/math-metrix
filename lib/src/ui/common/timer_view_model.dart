import 'dart:async';
import 'package:flutter/material.dart';

abstract class TimerViewModel {
  void startTimer();

  void pauseTimer();

  void resumeTimer();

  void cancelTimer();
}

abstract class TimerAccess {
  void timeOut();

  void timeUpdate(int time);
}

class TimerViewModelImpl extends TimerViewModel {
  int oneSec = 200;
  int totalTime;

  TimerAccess timerAccess;
  late Stream<int> _timer;
  StreamSubscription? _timeSubscription;

  TimerViewModelImpl({required this.timerAccess, required this.totalTime});

  Stream<int> timedCounter(int interval, int maxCount) {
    late StreamController<int> controller;
    Timer? timer;
    int counter = maxCount*5;

    void tick(_) {
      counter = counter - 1;
      controller.add(counter); // Ask stream to send counter values as event.
      if (counter == 0.0) {
        timer!.cancel();
        controller.close(); // Ask stream to shut down and tell listeners.
      }
    }

    void startTimer() {
      timer = Timer.periodic(Duration(milliseconds:  interval), tick);
    }

    void stopTimer() {
      if (timer != null) {
        timer!.cancel();
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
    timerAccess.timeUpdate(newTime);
  }

  void _handleTimerEnd() {
    timerAccess.timeOut();
    _timeSubscription = null;
  }

  @override
  void startTimer() {
    cancelTimer();
    _timer = timedCounter(oneSec, totalTime);
    _timeSubscription = _timer.listen(_onTimeChange);
    _timeSubscription!.onDone(_handleTimerEnd);
  }

  @override
  void pauseTimer() {
    if (_timeSubscription != null) {
      _timeSubscription!.pause();
    }
  }

  @override
  void resumeTimer() {
    if (_timeSubscription != null) {
      _timeSubscription!.resume();
    }
  }

  @override
  void cancelTimer() {
    if (_timeSubscription != null) {
      _timeSubscription!.cancel();
    }
  }
}
