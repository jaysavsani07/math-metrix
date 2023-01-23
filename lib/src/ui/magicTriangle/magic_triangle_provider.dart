import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/data/models/magic_triangle.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/app/game_provider.dart';

class MagicTriangleProvider extends GameProvider<MagicTriangle> {
  int selectedTriangleIndex = 0;
  final DifficultyType difficultyType;

  MagicTriangleProvider({
    required TickerProvider vsync,
    required this.difficultyType,
  }) : super(
          vsync: vsync,
          gameCategoryType: GameCategoryType.MAGIC_TRIANGLE,
          difficultyType: difficultyType,
        ) {
    startGame();
  }

  void inputTriangleSelection(int index, MagicTriangleInput input) {
    if (timerStatus != TimerStatus.pause) {
      if (input.value.isEmpty) {
        for (int i = 0; i < currentState.listTriangle.length; i++) {
          currentState.listTriangle[i].isActive = false;
        }
        selectedTriangleIndex = index;
        currentState.listTriangle[index].isActive = true;
        notifyListeners();
      } else {
        int listGridIndex = currentState.listGrid.indexWhere(
            (val) => val.value == input.value && val.isVisible == false);
        currentState.listTriangle[index].isActive = false;
        currentState.listTriangle[index].value = "";
        currentState.availableDigit = currentState.availableDigit + 1;
        currentState.listGrid[listGridIndex].isVisible = true;
        notifyListeners();
      }
    }
  }

  Future<void> checkResult(int index, MagicTriangleGrid digit) async {
    if (timerStatus != TimerStatus.pause) {
      int activeTriangleIndex =
          currentState.listTriangle.indexWhere((val) => val.isActive == true);
      if (activeTriangleIndex == -1) {
        return;
      }
      if (currentState.listTriangle[activeTriangleIndex].value.isNotEmpty) {
        return;
      }
      currentState.listTriangle[selectedTriangleIndex].value = digit.value;
      currentState.listGrid[index].isVisible = false;
      currentState.availableDigit = currentState.availableDigit - 1;

      if (currentState.availableDigit == 0) {
        // check if total of triangle is as per given answer
        if (currentState.checkTotal()) {
          await Future.delayed(Duration(milliseconds: 300));
          loadNewDataIfRequired();
          selectedTriangleIndex = 0;

          if (timerStatus != TimerStatus.pause) {
            restartTimer();
          }
          notifyListeners();
        }
      }
      notifyListeners();
    }
  }
}
