import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/data/models/math_pairs.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/common/game_provider.dart';
import 'package:mathgame/src/core/score_constant.dart';

class MathPairsProvider extends GameProvider<MathPairs> {
  int first = -1;
  int second = -1;
  bool lock = false;

  MathPairsProvider({required TickerProvider vsync})
      : super(vsync: vsync, gameCategoryType: GameCategoryType.MATH_PAIRS) {
    startGame();
  }

  Future<void> checkResult(Pair mathPair, int index) async {
    if (timerStatus != TimerStatus.pause && !lock) {
      lock = true;
      if (!currentState.list[index].isActive) {
        currentState.list[index].isActive = true;
        notifyListeners();
        await Future.delayed(Duration(milliseconds: 300));
        if (first != -1) {
          if (currentState.list[first].uid == currentState.list[index].uid) {
            currentState.list[first].isVisible = false;
            currentState.list[index].isVisible = false;
            currentState.availableItem = currentState.availableItem - 2;
            first = -1;
            oldScore = currentScore;
            currentScore = currentScore + ScoreUtil.mathematicalPairsScore;
            notifyListeners();
            if (currentState.availableItem == 0) {
              await Future.delayed(Duration(milliseconds: 300));
              loadNewDataIfRequired();
              if (timerStatus != TimerStatus.pause) {
                restartTimer();
              }
              notifyListeners();
            }
          } else {
            wrongAnswer();
            currentState.list[first].isActive = false;
            currentState.list[index].isActive = false;
            first = -1;
            notifyListeners();
          }
        } else {
          first = index;
        }
        lock = false;
      } else {
        first = -1;
        currentState.list[index].isActive = false;
        notifyListeners();
        lock = false;
      }
    }
  }
}
