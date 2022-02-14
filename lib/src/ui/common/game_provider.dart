import 'package:get_it/get_it.dart';
import 'dart:async';

import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/data/repository/magic_triangle_repository.dart';
import 'package:mathgame/src/data/repository/math_grid_repository.dart';
import 'package:mathgame/src/data/repository/number_pyramid_repository.dart';
import 'package:mathgame/src/ui/common/time_provider.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_view_model.dart';
import 'package:mathgame/src/data/repository/calculator_repository.dart';
import 'package:mathgame/src/data/repository/correct_answer_repository.dart';
import 'package:mathgame/src/data/repository/math_pairs_repository.dart';
import 'package:mathgame/src/data/repository/mental_arithmetic_repository.dart';
import 'package:mathgame/src/data/repository/picture_puzzle_repository.dart';
import 'package:mathgame/src/data/repository/quick_calculation_repository.dart';
import 'package:mathgame/src/data/repository/square_root_repository.dart';
import 'package:mathgame/src/data/repository/sign_repository.dart';
import 'package:mathgame/src/core/coin_constant.dart';
import 'package:mathgame/src/core/score_constant.dart';

class GameProvider<T> extends TimeProvider {
  final GameCategoryType gameCategoryType;
  final _homeViewModel = GetIt.I<DashboardViewModel>();

  late List<T> _list;
  late int _index;
  late double currentScore;
  late T currentState;

  GameProvider({required this.gameCategoryType})
      : super(totalTime: KeyUtil.getTimeUtil(gameCategoryType));

  void startGame() async {
    _list = getList(1);
    _index = 0;
    currentScore = 0;
    currentState = _list[_index];
    if (_homeViewModel.isFirstTime(gameCategoryType)) {
      await Future.delayed(Duration(milliseconds: 100));
      showInfoDialog();
    } else {
      startTimer();
    }
  }

  void loadNewDataIfRequired() {
    if (_list.length - 1 == _index) {
      if (gameCategoryType == GameCategoryType.SQUARE_ROOT)
        _list.addAll(getList(_index ~/ 5 + 2));
      else
        _list.addAll(getList(_index ~/ 5 + 1));
    }
    _index = _index + 1;
    currentScore = currentScore + getScoreUtil();
    currentState = _list[_index];
  }

  void wrongAnswer() {
    if (currentScore > 0) {
      currentScore = currentScore + getScoreMinusUtil();
    } else if (currentScore == 0 &&
        (gameCategoryType == GameCategoryType.SQUARE_ROOT ||
            gameCategoryType == GameCategoryType.CORRECT_ANSWER ||
            gameCategoryType == GameCategoryType.SIGN)) {
      dialogType = DialogType.over;
      timerStatus = TimerStatus.pause;
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

  List<T> getList(int level) {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return CalculatorRepository.getCalculatorDataList(level);
      case GameCategoryType.SIGN:
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
      case GameCategoryType.MATH_MACHINE:
        return MathGridRepository.getMathGridData(level);
      case GameCategoryType.PICTURE_PUZZLE:
        return PicturePuzzleRepository.getPicturePuzzleDataList(level);
      case GameCategoryType.NUMBER_PYRAMID:
        return NumberPyramidRepository.getPyramidDataList(level);
    }
  }

  double getScoreUtil() {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return ScoreUtil.calculatorScore;
      case GameCategoryType.SIGN:
        return ScoreUtil.signScore;
      case GameCategoryType.SQUARE_ROOT:
        return ScoreUtil.squareRootScore;
      case GameCategoryType.MATH_PAIRS:
        return ScoreUtil.mathMachineScore;
      case GameCategoryType.CORRECT_ANSWER:
        return ScoreUtil.correctAnswerScore;
      case GameCategoryType.MAGIC_TRIANGLE:
        return ScoreUtil.magicTriangleScore;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return ScoreUtil.mentalArithmeticScore;
      case GameCategoryType.QUICK_CALCULATION:
        return ScoreUtil.quickCalculationScore;
      case GameCategoryType.MATH_MACHINE:
        return ScoreUtil.mathMachineScore;
      case GameCategoryType.PICTURE_PUZZLE:
        return ScoreUtil.picturePuzzleScore;
      case GameCategoryType.NUMBER_PYRAMID:
        return 0;
    }
  }

  double getScoreMinusUtil() {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return ScoreUtil.calculatorScoreMinus;
      case GameCategoryType.SIGN:
        return ScoreUtil.signScoreMinus;
      case GameCategoryType.SQUARE_ROOT:
        return ScoreUtil.squareRootScoreMinus;
      case GameCategoryType.MATH_PAIRS:
        return ScoreUtil.mathematicalPairsScoreMinus;
      case GameCategoryType.CORRECT_ANSWER:
        return ScoreUtil.correctAnswerScoreMinus;
      case GameCategoryType.MAGIC_TRIANGLE:
        return ScoreUtil.magicTriangleScore;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return ScoreUtil.mentalArithmeticScoreMinus;
      case GameCategoryType.QUICK_CALCULATION:
        return ScoreUtil.quickCalculationScoreMinus;
      case GameCategoryType.MATH_MACHINE:
        return ScoreUtil.mathMachineScore;
      case GameCategoryType.PICTURE_PUZZLE:
        return ScoreUtil.picturePuzzleScore;
      case GameCategoryType.NUMBER_PYRAMID:
        return 0;
    }
  }

  double getCoinUtil() {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return CoinUtil.calculatorCoin;
      case GameCategoryType.SIGN:
        return CoinUtil.signCoin;
      case GameCategoryType.SQUARE_ROOT:
        return CoinUtil.squareRootCoin;
      case GameCategoryType.MATH_PAIRS:
        return CoinUtil.mathematicalPairsCoin;
      case GameCategoryType.CORRECT_ANSWER:
        return CoinUtil.correctAnswerCoin;
      case GameCategoryType.MAGIC_TRIANGLE:
        return CoinUtil.magicTriangleCoin;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return CoinUtil.mentalArithmeticCoin;
      case GameCategoryType.QUICK_CALCULATION:
        return CoinUtil.quickCalculationCoin;
      case GameCategoryType.MATH_MACHINE:
        return CoinUtil.mathMachineCoin;
      case GameCategoryType.PICTURE_PUZZLE:
        return CoinUtil.picturePuzzleCoin;
      case GameCategoryType.NUMBER_PYRAMID:
        return 0;
    }
  }
}
