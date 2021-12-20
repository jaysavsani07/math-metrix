import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/data/models/picture_puzzle.dart';
import 'package:mathgame/src/ui/common/timer_view_model.dart';
import 'package:mathgame/src/data/repository/calculator_repository.dart';
import 'package:mathgame/src/data/repository/correct_answer_repository.dart';
import 'package:mathgame/src/service/dialog_service.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/data/repository/math_pairs_repository.dart';
import 'package:mathgame/src/data/repository/mental_arithmetic_repository.dart';
import 'package:mathgame/src/service/navigation_service.dart';
import 'package:mathgame/src/data/repository/picture_puzzle_repository.dart';
import 'package:mathgame/src/data/repository/quick_calculation_repository.dart';
import 'package:mathgame/src/data/repository/square_root_repository.dart';
import 'package:mathgame/src/data/repository/sign_repository.dart';
import 'package:mathgame/src/core/coin_constant.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/score_constant.dart';
import 'package:mathgame/src/core/time_constant.dart';

import '../dashboard/dashboard_view_model.dart';

abstract class GameViewModel {
  void showGameOverDialog();

  void showPauseGameDialog();

  void showInfoDialog();

  void startGame();

  void restartGame();

  void pauseGame();

  void resumeGame();

  void exitGame();

  void loadNewDataIfRequired();

  void wrongAnswer();
}

abstract class GameAccess<T> {
  void onGameTimeOut();

  void onGameTimeUpdate(int time);

  void onScoreUpdate(double time);

  void onCurrentStateUpdate(T currentState);

  void startGame1();

  void onResumeGame();
}

class GameViewModelImp<T> extends GameViewModel implements TimerAccess {
  GameAccess gameAccess;
  GameCategoryType gameCategoryType;
  final _dialogService = GetIt.I<DialogService>();
  final _homeViewModel = GetIt.I<DashboardViewModel>();
  TimerViewModelImpl timerViewModel;

  List<T> _list;
  int _index;
  double _currentScore;
  T currentState;

  GameViewModelImp(
      {@required this.gameAccess, @required this.gameCategoryType}) {
    timerViewModel =
        TimerViewModelImpl(timerAccess: this, totalTime: getTimeUtil());
  }

  @override
  void timeOut() {
    showGameOverDialog();
    gameAccess.onGameTimeOut();
  }

  @override
  void timeUpdate(int time) {
    gameAccess.onGameTimeUpdate(time);
  }

  @override
  void startGame() async {
    _list = getList(1);
    _index = 0;
    _currentScore = 0;
    currentState = _list[_index];
    gameAccess.onCurrentStateUpdate(currentState);
    timerViewModel.startTimer();
    if (_homeViewModel.isFirstTime(gameCategoryType)) {
      await Future.delayed(Duration(milliseconds: 500));
      pauseGame();
      showInfoDialog();
    }
  }

  @override
  void loadNewDataIfRequired() {
    if (_list.length - 1 == _index) {
      print(_index ~/ 5 + 2);
      if (gameCategoryType == GameCategoryType.SQUARE_ROOT)
        _list.addAll(getList(_index ~/ 5 + 2));
      else
        _list.addAll(getList(_index ~/ 5 + 1));
    }
    _index = _index + 1;
    _currentScore = _currentScore + getScoreUtil();
    gameAccess.onScoreUpdate(_currentScore);
    currentState = _list[_index];
    gameAccess.onCurrentStateUpdate(currentState);
  }

  @override
  void wrongAnswer() {
    if (_currentScore > 0) {
      _currentScore = _currentScore + getScoreMinusUtil();
      gameAccess.onScoreUpdate(_currentScore);
    } else if (_currentScore == 0 &&
        (gameCategoryType == GameCategoryType.SQUARE_ROOT ||
            gameCategoryType == GameCategoryType.CORRECT_ANSWER ||
            gameCategoryType == GameCategoryType.SIGN)) {
      pauseGame();
      showGameOverDialog();
    }
  }

  @override
  void restartGame() {
    timerViewModel.startTimer();
  }

  @override
  void pauseGame() {
    timerViewModel.pauseTimer();
  }

  @override
  void resumeGame() {
    timerViewModel.resumeTimer();
  }

  @override
  void exitGame() {
    timerViewModel.cancelTimer();
  }

  @override
  void showGameOverDialog() async {
    var dialogResult = await _dialogService.showDialog(
        type: KeyUtil.GameOverDialog,
        gameCategoryType: gameCategoryType,
        score: _currentScore,
        coin: _index * getCoinUtil(),
        isPause: false);

    if (dialogResult.exit) {
      _homeViewModel.updateScoreboard(
          gameCategoryType, _currentScore, _index * getCoinUtil());
      GetIt.I<NavigationService>().goBack();
    } else if (dialogResult.restart) {
      _homeViewModel.updateScoreboard(
          gameCategoryType, _currentScore, _index * getCoinUtil());
      gameAccess.startGame1();
    }
  }

  @override
  void showPauseGameDialog() async {
    var dialogResult = await _dialogService.showDialog(
        type: KeyUtil.GameOverDialog,
        gameCategoryType: gameCategoryType,
        score: _currentScore,
        coin: _index * getCoinUtil(),
        isPause: true);

    if (dialogResult.exit) {
      _homeViewModel.updateScoreboard(
          gameCategoryType, _currentScore, _index * getCoinUtil());
      GetIt.I<NavigationService>().goBack();
    } else if (dialogResult.play) {
      resumeGame();
      gameAccess.onResumeGame();
    }
  }

  @override
  void showInfoDialog() async {
    var dialogResult = await _dialogService.showDialog(
        type: KeyUtil.InfoDialog,
        gameCategoryType: gameCategoryType,
        score: 0,
        coin: 0,
        isPause: true);

    if (dialogResult.exit) {
      _homeViewModel.setFirstTime(gameCategoryType);
      resumeGame();
      gameAccess.onResumeGame();
    }
  }

  List<T> getList(int level) {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return CalculatorRepository.getCalculatorDataList(level);
        break;
      case GameCategoryType.SIGN:
        return SignRepository.getSignDataList(level);
        break;
      case GameCategoryType.SQUARE_ROOT:
        return SquareRootRepository.getSquareDataList(level);
        break;
      case GameCategoryType.MATH_PAIRS:
        return MathPairsRepository.getMathPairsDataList(level);
        break;
      case GameCategoryType.CORRECT_ANSWER:
        return CorrectAnswerRepository.getCorrectAnswerDataList(level);
        break;
      case GameCategoryType.MAGIC_TRIANGLE:
//        return MagicTriangleDataProvider.getMagicTriangleInput();
        break;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return MentalArithmeticRepository.getMentalArithmeticDataList(
            level);
        break;
      case GameCategoryType.QUICK_CALCULATION:
        return QuickCalculationRepository.getQuickCalculationDataList(
            level, 5);
        break;
      case GameCategoryType.MATH_MACHINE:
//        return MathGridDataProvider.generateRandomAnswer();
        break;
      case GameCategoryType.PICTURE_PUZZLE:
        return PicturePuzzleRepository.getPicturePuzzleDataList(level);
      case GameCategoryType.NUMBER_PYRAMID:
        // TODO: Handle this case.
        break;
    }
  }

  double getScoreUtil() {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return ScoreUtil.calculatorScore;
        break;
      case GameCategoryType.SIGN:
        return ScoreUtil.signScore;
        break;
      case GameCategoryType.SQUARE_ROOT:
        return ScoreUtil.squareRootScore;
        break;
      case GameCategoryType.MATH_PAIRS:
        return ScoreUtil.mathMachineScore;
        break;
      case GameCategoryType.CORRECT_ANSWER:
        return ScoreUtil.correctAnswerScore;
        break;
      case GameCategoryType.MAGIC_TRIANGLE:
        return ScoreUtil.magicTriangleScore;
        break;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return ScoreUtil.mentalArithmeticScore;
        break;
      case GameCategoryType.QUICK_CALCULATION:
        return ScoreUtil.quickCalculationScore;
        break;
      case GameCategoryType.MATH_MACHINE:
        return ScoreUtil.mathMachineScore;
        break;
      case GameCategoryType.PICTURE_PUZZLE:
        return ScoreUtil.picturePuzzleScore;
      case GameCategoryType.NUMBER_PYRAMID:
        // TODO: Handle this case.
        break;
    }
  }

  double getScoreMinusUtil() {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return ScoreUtil.calculatorScoreMinus;
        break;
      case GameCategoryType.SIGN:
        return ScoreUtil.signScoreMinus;
        break;
      case GameCategoryType.SQUARE_ROOT:
        return ScoreUtil.squareRootScoreMinus;
        break;
      case GameCategoryType.MATH_PAIRS:
        return ScoreUtil.mathematicalPairsScoreMinus;
        break;
      case GameCategoryType.CORRECT_ANSWER:
        return ScoreUtil.correctAnswerScoreMinus;
        break;
      case GameCategoryType.MAGIC_TRIANGLE:
        return ScoreUtil.magicTriangleScore;
        break;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return ScoreUtil.mentalArithmeticScoreMinus;
        break;
      case GameCategoryType.QUICK_CALCULATION:
        return ScoreUtil.quickCalculationScoreMinus;
        break;
      case GameCategoryType.MATH_MACHINE:
        return ScoreUtil.mathMachineScore;
        break;
      case GameCategoryType.PICTURE_PUZZLE:
        return ScoreUtil.picturePuzzleScore;
      case GameCategoryType.NUMBER_PYRAMID:
        // TODO: Handle this case.
        break;
    }
  }

  double getCoinUtil() {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return CoinUtil.calculatorCoin;
        break;
      case GameCategoryType.SIGN:
        return CoinUtil.signCoin;
        break;
      case GameCategoryType.SQUARE_ROOT:
        return CoinUtil.squareRootCoin;
        break;
      case GameCategoryType.MATH_PAIRS:
        return CoinUtil.mathematicalPairsCoin;
        break;
      case GameCategoryType.CORRECT_ANSWER:
        return CoinUtil.correctAnswerCoin;
        break;
      case GameCategoryType.MAGIC_TRIANGLE:
        return CoinUtil.magicTriangleCoin;
        break;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return CoinUtil.mentalArithmeticCoin;
        break;
      case GameCategoryType.QUICK_CALCULATION:
        return CoinUtil.quickCalculationCoin;
        break;
      case GameCategoryType.MATH_MACHINE:
        return CoinUtil.mathMachineCoin;
        break;
      case GameCategoryType.PICTURE_PUZZLE:
        return CoinUtil.picturePuzzleCoin;
      case GameCategoryType.NUMBER_PYRAMID:
        // TODO: Handle this case.
        break;
    }
  }

  int getTimeUtil() {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return TimeUtil.calculatorTimeOut;
        break;
      case GameCategoryType.SIGN:
        return TimeUtil.signTimeOut;
        break;
      case GameCategoryType.SQUARE_ROOT:
        return TimeUtil.squareRootTimeOut;
        break;
      case GameCategoryType.MATH_PAIRS:
        return TimeUtil.mathematicalPairsTimeOut;
        break;
      case GameCategoryType.CORRECT_ANSWER:
        return TimeUtil.correctAnswerTimeOut;
        break;
      case GameCategoryType.MAGIC_TRIANGLE:
        return TimeUtil.magicTriangleTimeOut;
        break;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return TimeUtil.mentalArithmeticTimeOut;
        break;
      case GameCategoryType.QUICK_CALCULATION:
        return TimeUtil.quickCalculationTimeOut;
        break;
      case GameCategoryType.MATH_MACHINE:
        return TimeUtil.mathMachineTimeOut;
        break;
      case GameCategoryType.PICTURE_PUZZLE:
        return TimeUtil.picturePuzzleTimeOut;
      case GameCategoryType.NUMBER_PYRAMID:
        // TODO: Handle this case.
        break;
    }
  }
}
