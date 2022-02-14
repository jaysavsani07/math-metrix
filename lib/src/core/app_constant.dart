import 'package:mathgame/src/core/time_constant.dart';

class KeyUtil {
  static const IS_DARK_MODE = "isDarkMode";

  static const String Dashboard = 'Dashboard';
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
