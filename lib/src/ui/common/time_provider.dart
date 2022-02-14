import 'package:flutter/material.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/common/complex_timer.dart';

class TimeProvider with ChangeNotifier {
  final int totalTime;
  TimerStatus timerStatus = TimerStatus.restart;
  DialogType dialogType = DialogType.non;

  late ComplexTimer complexTimer;

  TimeProvider({required this.totalTime}) {
    complexTimer = ComplexTimer(Duration(seconds: totalTime));
    complexTimer.onTimeout = _handleTimerEnd;
  }

  void _handleTimerEnd(ComplexTimer complexTimer) {
    dialogType = DialogType.over;
    timerStatus = TimerStatus.pause;
    notifyListeners();
  }

  Future<void> startTimer() async {
    timerStatus = TimerStatus.restart;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 300));
    timerStatus = TimerStatus.play;
    dialogType = DialogType.non;
    notifyListeners();
    complexTimer.restart();
  }

  void pauseTimer() {
    complexTimer.pause();
    timerStatus = TimerStatus.pause;
    notifyListeners();
  }

  void resumeTimer() {
    complexTimer.resume();
    timerStatus = TimerStatus.play;
    notifyListeners();
  }
}
