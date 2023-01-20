import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/data/models/square_root.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/app/game_provider.dart';

class SquareRootProvider extends GameProvider<SquareRoot> {
  final DifficultyType difficultyType;

  SquareRootProvider({
    required TickerProvider vsync,
    required this.difficultyType,
  }) : super(vsync: vsync, gameCategoryType: GameCategoryType.SQUARE_ROOT,
          difficultyType: difficultyType,
        ) {
    startGame();
  }

  Future<void> checkResult(String answer) async {
    if (int.parse(answer) == currentState.answer &&
        timerStatus != TimerStatus.pause) {
      await Future.delayed(Duration(milliseconds: 300));
      loadNewDataIfRequired();
      if (timerStatus != TimerStatus.pause) {
        restartTimer();
      }
      notifyListeners();
    } else {
      wrongAnswer();
    }
  }
}
