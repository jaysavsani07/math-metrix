import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'dart:async';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/data/repository/magic_triangle_repository.dart';
import 'package:mathgame/src/data/repository/math_grid_repository.dart';
import 'package:mathgame/src/data/repository/number_pyramid_repository.dart';
import 'package:mathgame/src/ui/app/time_provider.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_provider.dart';
import 'package:mathgame/src/data/repository/calculator_repository.dart';
import 'package:mathgame/src/data/repository/correct_answer_repository.dart';
import 'package:mathgame/src/data/repository/math_pairs_repository.dart';
import 'package:mathgame/src/data/repository/mental_arithmetic_repository.dart';
import 'package:mathgame/src/data/repository/picture_puzzle_repository.dart';
import 'package:mathgame/src/data/repository/quick_calculation_repository.dart';
import 'package:mathgame/src/data/repository/square_root_repository.dart';
import 'package:mathgame/src/data/repository/sign_repository.dart';

class GameProvider<T> extends TimeProvider {
  final GameCategoryType gameCategoryType;
  final DifficultyType difficultyType;
  final _homeViewModel = GetIt.I<DashboardProvider>();

  late List<T> list;
  late int index;
  late double currentScore;
  late double oldScore;
  late T currentState;
  late String result;

  GameProvider({
    required TickerProvider vsync,
    required this.gameCategoryType,
    required this.difficultyType,
  }) : super(
          vsync: vsync,
          totalTime: KeyUtil.getTimeUtil(
            gameCategoryType,
            difficultyType,
          ),
        );

  void startGame() async {
    result = "";
    list = getList(1);
    index = 0;
    currentScore = 0;
    oldScore = 0;
    currentState = list[index];
    if (_homeViewModel.isFirstTime(gameCategoryType)) {
      await Future.delayed(Duration(milliseconds: 100));
      showInfoDialog();
    } else {
      restartTimer();
      notifyListeners();
    }
  }

  void loadNewDataIfRequired() {
    if (gameCategoryType == GameCategoryType.QUICK_CALCULATION &&
        list.length - 2 == index) {
      list.addAll(getList(index ~/ 5 + 1));
    } else if (list.length - 1 == index) {
      if (gameCategoryType == GameCategoryType.SQUARE_ROOT)
        list.addAll(getList(index ~/ 5 + 2));
      else
        list.addAll(getList(index ~/ 5 + 1));
    }
    result = "";
    index = index + 1;
    oldScore = currentScore;
    currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);
    currentState = list[index];
  }

  void wrongAnswer() {
    if (currentScore > 0) {
      oldScore = currentScore;
      currentScore = currentScore + KeyUtil.getScoreMinusUtil(gameCategoryType);
      notifyListeners();
    } else if (currentScore == 0 &&
        (gameCategoryType == GameCategoryType.SQUARE_ROOT ||
            gameCategoryType == GameCategoryType.CORRECT_ANSWER ||
            gameCategoryType == GameCategoryType.GUESS_SIGN)) {
      dialogType = DialogType.over;
      pauseTimer();
      notifyListeners();
    }
  }

  void pauseResumeGame() {
    if (timerStatus == TimerStatus.play) {
      pauseTimer();
      dialogType = DialogType.pause;
      notifyListeners();
    } else {
      resumeTimer();
      dialogType = DialogType.non;
      notifyListeners();
    }
  }

  void showInfoDialog() {
    pauseTimer();
    dialogType = DialogType.info;
    notifyListeners();
  }

  void showExitDialog() {
    pauseTimer();
    dialogType = DialogType.exit;
    notifyListeners();
  }

  void updateScore() {
    _homeViewModel.updateScoreboard(gameCategoryType, currentScore);
  }

  void gotItFromInfoDialog() {
    if (_homeViewModel.isFirstTime(gameCategoryType)) {
      _homeViewModel.setFirstTime(gameCategoryType);
      if (gameCategoryType == GameCategoryType.MENTAL_ARITHMETIC) {
        startGame();
      }
      restartTimer();
    } else {
      pauseResumeGame();
    }
  }

  List<T> getList(int level) {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return CalculatorRepository.getCalculatorDataList(level);
      case GameCategoryType.GUESS_SIGN:
        return SignRepository.getSignDataList(level);
      case GameCategoryType.SQUARE_ROOT:
        return SquareRootRepository.getSquareDataList(level);
      case GameCategoryType.MATH_PAIRS:
        return MathPairsRepository.getMathPairsDataList(level);
      case GameCategoryType.CORRECT_ANSWER:
        return CorrectAnswerRepository.getCorrectAnswerDataList(level);
      case GameCategoryType.MAGIC_TRIANGLE:
        return MagicTriangleRepository.getTriangleDataProviderList();
      case GameCategoryType.MENTAL_ARITHMETIC:
        return MentalArithmeticRepository.getMentalArithmeticDataList(level);
      case GameCategoryType.QUICK_CALCULATION:
        return QuickCalculationRepository.getQuickCalculationDataList(level, 5);
      case GameCategoryType.MATH_GRID:
        return MathGridRepository.getMathGridData(level);
      case GameCategoryType.PICTURE_PUZZLE:
        return PicturePuzzleRepository.getPicturePuzzleDataList(level);
      case GameCategoryType.NUMBER_PYRAMID:
        return NumberPyramidRepository.getPyramidDataList(level);
    }
  }
}
