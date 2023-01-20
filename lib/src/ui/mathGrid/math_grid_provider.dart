import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/data/models/math_grid.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/app/game_provider.dart';

class MathGridProvider extends GameProvider<MathGrid> {
  int answerIndex = 0;
  final DifficultyType difficultyType;

  MathGridProvider({
    required TickerProvider vsync,
    required this.difficultyType,
  }) : super(
          vsync: vsync,
          gameCategoryType: GameCategoryType.MATH_GRID,
          difficultyType: difficultyType,
        ) {
    startGame();
  }

  void checkResult(int index, MathGridCellModel gridModel) {
    if (timerStatus != TimerStatus.pause) {
      if (gridModel.isActive) {
        gridModel.isActive = false;
        notifyListeners();
      } else {
        gridModel.isActive = true;
        notifyListeners();
      }
      checkForCorrectAnswer();
    }
  }

  Future<void> checkForCorrectAnswer() async {
    int total = 0;
    var listOfIndex = currentState.listForSquare
        .where((result) => result.isActive == true)
        .toList();

    for (int i = 0; i < listOfIndex.length; i++) {
      total = total + listOfIndex[i].value;
    }

    if (currentState.currentAnswer == total) {
      for (int i = 0; i < listOfIndex.length; i++) {
        listOfIndex[i].isActive = false;
        listOfIndex[i].isRemoved = true;
      }
      answerIndex = answerIndex + 1;
      if (currentState.listForSquare
          .where((element) => !element.isRemoved)
          .isEmpty) {
        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired();
        answerIndex = 0;
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }
        notifyListeners();
      } else {
        currentState.currentAnswer = currentState.getNewAnswer();
      }
    }
  }

  clear() {
    notifyListeners();
  }
}
