import 'package:flutter/material.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/common/complex_timer.dart';

// class TimeProvider with ChangeNotifier {
//   final int totalTime;
//   TimerStatus timerStatus = TimerStatus.restart;
//   DialogType dialogType = DialogType.non;
//
//   late ComplexTimer complexTimer;
//
//   TimeProvider({required this.totalTime}) {
//     complexTimer = ComplexTimer(Duration(seconds: totalTime));
//     complexTimer.onTimeout = _handleTimerEnd;
//   }
//
//   void _handleTimerEnd(ComplexTimer complexTimer) {
//     dialogType = DialogType.over;
//     timerStatus = TimerStatus.pause;
//     notifyListeners();
//   }
//
//   Future<void> startTimer() async {
//     timerStatus = TimerStatus.restart;
//     notifyListeners();
//     await Future.delayed(Duration(milliseconds: 300));
//     timerStatus = TimerStatus.play;
//     dialogType = DialogType.non;
//     notifyListeners();
//     complexTimer.restart();
//   }
//
//   void pauseTimer() {
//     complexTimer.pause();
//     timerStatus = TimerStatus.pause;
//     notifyListeners();
//   }
//
//   void resumeTimer() {
//     complexTimer.resume();
//     timerStatus = TimerStatus.play;
//     notifyListeners();
//   }
// }

class TimeProvider with ChangeNotifier {
  TimeProvider({
    required TickerProvider vsync,
    required this.totalTime,
  }) {
    _animationController = AnimationController(
      vsync: vsync,
      value: 1.0,
      duration: Duration(seconds: totalTime),
    )
      ..addStatusListener((status) {
        dialogType = DialogType.over;
        timerStatus = TimerStatus.pause;
        notifyListeners();
      })
     ;
  }

  final int totalTime;

  DialogType dialogType = DialogType.non;
  TimerStatus timerStatus = TimerStatus.restart;

  late final AnimationController _animationController;

  Animation<double> get animation => _animationController;

  void startTimer() {
    _animationController.reverse();
    timerStatus = TimerStatus.play;
    dialogType = DialogType.non;
  }

  void pauseTimer() {
    _animationController.stop();
    timerStatus = TimerStatus.pause;
  }

  void resumeTimer() {
    _animationController.reverse();
    timerStatus = TimerStatus.play;
  }

  void reset() {
    _animationController.value = 1.0;
  }

  void restartTimer() {
    _animationController.reverse(from: 1.0);
    timerStatus = TimerStatus.play;
    dialogType = DialogType.non;
  }

  void increase() {
    _animationController.value = _animationController.value + 0.05;
    _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
