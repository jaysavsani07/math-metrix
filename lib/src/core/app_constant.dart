import 'package:flutter/material.dart';
import 'package:mathgame/src/core/time_constant.dart';
import 'package:mathgame/src/data/models/dashboard.dart';
import 'package:tuple/tuple.dart';

import 'app_assets.dart';

class KeyUtil {
  static const IS_DARK_MODE = "isDarkMode";

  static const String dashboard = 'Dashboard';
  static const String Home = 'Home';

  static const String Calculator = 'Calculator';
  static const String Sign = 'Sign';
  static const String CorrectAnswer = 'CorrectSnswer';
  static const String QuickCalculation = 'QuickCalculation';
  static const String MentalArithmetic = 'MentalArithmetic';
  static const String SquareRoot = 'SquareRoot';
  static const String MathematicalPairs = 'MathematicalPairs';
  static const String MagicTriangle = 'MagicTriangle';
  static const String PicturePuzzle = 'PicturePuzzle';
  static const String MathMachine = 'MathMachine';
  static const String NumberPyramid = "NumberPyramid";

  static const String GameOverDialog = "GameOverDialog";
  static const String InfoDialog = "InfoDialog";

  static List<Dashboard> dashboardItems = [
    Dashboard(
      puzzleType: PuzzleType.MATH_PUZZLE,
      colorTuple: Tuple2(Color(0xff4895EF), Color(0xff3f37c9)),
      opacity: 0.07,
      icon: AppAssets.icMathPuzzle,
      outlineIcon: AppAssets.icMathPuzzleOutline,
      subtitle: "Each game with simple calculation with different approach.",
      title: "Math Puzzle",
    ),
    Dashboard(
      puzzleType: PuzzleType.MEMORY_PUZZLE,
      colorTuple: Tuple2(Color(0xff9f2beb), Color(0xff560bad)),
      opacity: 0.07,
      icon: AppAssets.icMemoryPuzzle,
      outlineIcon: AppAssets.icMemoryPuzzleOutline,
      subtitle: "Memorise numbers & signs before applying calculation to them.",
      title: "Memory Puzzle",
    ),
    Dashboard(
      puzzleType: PuzzleType.BRAIN_PUZZLE,
      colorTuple: Tuple2(Color(0xfff72585), Color(0xffb5179e)),
      opacity: 0.12,
      icon: AppAssets.icTrainBrain,
      outlineIcon: AppAssets.icTrainBrainOutline,
      subtitle:
          "Enhance logical thinking, concentration and core cognitive skills.",
      title: "Train Your Brain",
    ),
  ];

  static int getTimeUtil(GameCategoryType gameCategoryType) {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return TimeUtil.calculatorTimeOut;
      case GameCategoryType.SIGN:
        return TimeUtil.signTimeOut;
      case GameCategoryType.SQUARE_ROOT:
        return TimeUtil.squareRootTimeOut;
      case GameCategoryType.MATH_PAIRS:
        return TimeUtil.mathematicalPairsTimeOut;
      case GameCategoryType.CORRECT_ANSWER:
        return TimeUtil.correctAnswerTimeOut;
      case GameCategoryType.MAGIC_TRIANGLE:
        return TimeUtil.magicTriangleTimeOut;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return TimeUtil.mentalArithmeticTimeOut;
      case GameCategoryType.QUICK_CALCULATION:
        return TimeUtil.quickCalculationTimeOut;
      case GameCategoryType.MATH_MACHINE:
        return TimeUtil.mathMachineTimeOut;
      case GameCategoryType.PICTURE_PUZZLE:
        return TimeUtil.picturePuzzleTimeOut;
      case GameCategoryType.NUMBER_PYRAMID:
        return TimeUtil.numPyramidTimeOut;
    }
  }
}

enum GameCategoryType {
  CALCULATOR,
  SIGN,
  SQUARE_ROOT,
  MATH_PAIRS,
  CORRECT_ANSWER,
  MAGIC_TRIANGLE,
  MENTAL_ARITHMETIC,
  QUICK_CALCULATION,
  MATH_MACHINE,
  PICTURE_PUZZLE,
  NUMBER_PYRAMID
}
enum PuzzleType { MATH_PUZZLE, MEMORY_PUZZLE, BRAIN_PUZZLE }

enum TimerStatus {
  restart,
  play,
  pause,
}

enum DialogType {
  non,
  info,
  over,
  pause,
  exit,
}
