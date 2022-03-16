import 'package:flutter/material.dart';
import 'package:mathgame/src/data/models/dashboard.dart';
import 'package:tuple/tuple.dart';
import 'app_assets.dart';

enum GameCategoryType {
  CALCULATOR,
  GUESS_SIGN,
  SQUARE_ROOT,
  MATH_PAIRS,
  CORRECT_ANSWER,
  MAGIC_TRIANGLE,
  MENTAL_ARITHMETIC,
  QUICK_CALCULATION,
  MATH_GRID,
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

class KeyUtil {
  static const IS_DARK_MODE = "isDarkMode";

  static const String splash = 'Splash';
  static const String dashboard = 'Dashboard';
  static const String home = 'Home';

  static const String calculator = 'Calculator';
  static const String guessSign = 'GuessSign';
  static const String correctAnswer = 'CorrectAnswer';
  static const String quickCalculation = 'QuickCalculation';
  static const String mentalArithmetic = 'MentalArithmetic';
  static const String squareRoot = 'SquareRoot';
  static const String mathPairs = 'MathPairs';
  static const String magicTriangle = 'MagicTriangle';
  static const String picturePuzzle = 'PicturePuzzle';
  static const String mathGrid = 'MathGrid';
  static const String numberPyramid = "NumberPyramid";

  static List<Dashboard> dashboardItems = [
    Dashboard(
      puzzleType: PuzzleType.MATH_PUZZLE,
      colorTuple: Tuple2(Color(0xff4895EF), Color(0xff3f37c9)),
      opacity: 0.07,
      icon: AppAssets.icMathPuzzle,
      outlineIcon: AppAssets.icMathPuzzleOutline,
      subtitle: "Each game with simple calculation with different approach.",
      title: "Math Puzzle",
      fillIconColor: Color(0xff4895ef),
      outlineIconColor: Color(0xff436add),
    ),
    Dashboard(
      puzzleType: PuzzleType.MEMORY_PUZZLE,
      colorTuple: Tuple2(Color(0xff9f2beb), Color(0xff560bad)),
      opacity: 0.07,
      icon: AppAssets.icMemoryPuzzle,
      outlineIcon: AppAssets.icMemoryPuzzleOutline,
      subtitle: "Memorise numbers & signs before applying calculation to them.",
      title: "Memory Puzzle",
      fillIconColor: Color(0xff9f2beb),
      outlineIconColor: Color(0xff560BAD),
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
      fillIconColor: Color(0xfff72585),
      outlineIconColor: Color(0xffB5179E),
    ),
  ];

  static int getTimeUtil(GameCategoryType gameCategoryType) {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return calculatorTimeOut;
      case GameCategoryType.GUESS_SIGN:
        return guessSignTimeOut;
      case GameCategoryType.SQUARE_ROOT:
        return squareRootTimeOut;
      case GameCategoryType.MATH_PAIRS:
        return mathematicalPairsTimeOut;
      case GameCategoryType.CORRECT_ANSWER:
        return correctAnswerTimeOut;
      case GameCategoryType.MAGIC_TRIANGLE:
        return magicTriangleTimeOut;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return mentalArithmeticTimeOut;
      case GameCategoryType.QUICK_CALCULATION:
        return quickCalculationTimeOut;
      case GameCategoryType.MATH_GRID:
        return mathGridTimeOut;
      case GameCategoryType.PICTURE_PUZZLE:
        return picturePuzzleTimeOut;
      case GameCategoryType.NUMBER_PYRAMID:
        return numPyramidTimeOut;
    }
  }

  static double getScoreUtil(GameCategoryType gameCategoryType) {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return calculatorScore;
      case GameCategoryType.GUESS_SIGN:
        return guessSignScore;
      case GameCategoryType.SQUARE_ROOT:
        return squareRootScore;
      case GameCategoryType.MATH_PAIRS:
        return mathGridScore;
      case GameCategoryType.CORRECT_ANSWER:
        return correctAnswerScore;
      case GameCategoryType.MAGIC_TRIANGLE:
        return magicTriangleScore;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return mentalArithmeticScore;
      case GameCategoryType.QUICK_CALCULATION:
        return quickCalculationScore;
      case GameCategoryType.MATH_GRID:
        return mathGridScore;
      case GameCategoryType.PICTURE_PUZZLE:
        return picturePuzzleScore;
      case GameCategoryType.NUMBER_PYRAMID:
        return numberPyramidScore;
    }
  }

  static double getScoreMinusUtil(GameCategoryType gameCategoryType) {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return calculatorScoreMinus;
      case GameCategoryType.GUESS_SIGN:
        return guessSignScoreMinus;
      case GameCategoryType.SQUARE_ROOT:
        return squareRootScoreMinus;
      case GameCategoryType.MATH_PAIRS:
        return mathematicalPairsScoreMinus;
      case GameCategoryType.CORRECT_ANSWER:
        return correctAnswerScoreMinus;
      case GameCategoryType.MAGIC_TRIANGLE:
        return magicTriangleScoreMinus;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return mentalArithmeticScoreMinus;
      case GameCategoryType.QUICK_CALCULATION:
        return quickCalculationScoreMinus;
      case GameCategoryType.MATH_GRID:
        return mathGridScoreMinus;
      case GameCategoryType.PICTURE_PUZZLE:
        return picturePuzzleScoreMinus;
      case GameCategoryType.NUMBER_PYRAMID:
        return numberPyramidScoreMinus;
    }
  }

  static double getCoinUtil(GameCategoryType gameCategoryType) {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return calculatorCoin;
      case GameCategoryType.GUESS_SIGN:
        return guessSignCoin;
      case GameCategoryType.SQUARE_ROOT:
        return squareRootCoin;
      case GameCategoryType.MATH_PAIRS:
        return mathematicalPairsCoin;
      case GameCategoryType.CORRECT_ANSWER:
        return correctAnswerCoin;
      case GameCategoryType.MAGIC_TRIANGLE:
        return magicTriangleCoin;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return mentalArithmeticCoin;
      case GameCategoryType.QUICK_CALCULATION:
        return quickCalculationCoin;
      case GameCategoryType.MATH_GRID:
        return mathGridCoin;
      case GameCategoryType.PICTURE_PUZZLE:
        return picturePuzzleCoin;
      case GameCategoryType.NUMBER_PYRAMID:
        return numberPyramidCoin;
    }
  }

  //Game TimeOut Constant
  static int calculatorTimeOut = 5;
  static int guessSignTimeOut = 5;
  static int correctAnswerTimeOut = 5;
  static int quickCalculationTimeOut = 20;
  static int quickCalculationPlusTime = 1;

  static int mentalArithmeticTimeOut = 60;
  static int mentalArithmeticLocalTimeOut = 4;
  static int squareRootTimeOut = 5;
  static int mathGridTimeOut = 120;
  static int mathematicalPairsTimeOut = 60;

  static int magicTriangleTimeOut = 60;
  static int picturePuzzleTimeOut = 90;
  static int numPyramidTimeOut = 120;

  //Game Score Constant
  static double calculatorScore = 1;
  static double calculatorScoreMinus = -1;

  static double guessSignScore = 1;
  static double guessSignScoreMinus = -1;

  static double correctAnswerScore = 1;
  static double correctAnswerScoreMinus = -1;

  static double quickCalculationScore = 1;
  static double quickCalculationScoreMinus = -1;

  static double mentalArithmeticScore = 2;
  static double mentalArithmeticScoreMinus = -1;

  static double squareRootScore = 1;
  static double squareRootScoreMinus = -1;

  static double mathematicalPairsScore = 1;
  static double mathematicalPairsScoreMinus = -1;

  static double mathGridScore = 5;
  static double mathGridScoreMinus = 0;

  static double magicTriangleScore = 5;
  static double magicTriangleScoreMinus = 0;

  static double picturePuzzleScore = 2;
  static double picturePuzzleScoreMinus = -1;

  static double numberPyramidScore = 5;
  static double numberPyramidScoreMinus = 0;

  //Game Coin Constant
  static double calculatorCoin = 0.5;
  static double guessSignCoin = 0.5;
  static double correctAnswerCoin = 0.5;
  static double quickCalculationCoin = 0.5;

  static double mentalArithmeticCoin = 1;
  static double squareRootCoin = 0.5;
  static double mathGridCoin = 3;
  static double mathematicalPairsCoin = 1;

  static double magicTriangleCoin = 3;
  static double picturePuzzleCoin = 1;
  static double numberPyramidCoin = 3;
}
