import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/data/models/game_info_dialog.dart';
import 'package:mathgame/src/core/score_constant.dart';

class DialogInfoUtil {
  // ignore: missing_return
  static GameInfoDialog getInfoDialogData(GameCategoryType gameCategoryType) {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return GameInfoDialog(
          title: "Calculator",
          image: "assets/gif/calculator-intro.gif",
          dec: "You need to solve given equation correctly.",
          correctAnswerScore: ScoreUtil.calculatorScore,
          wrongAnswerScore: ScoreUtil.calculatorScoreMinus,
        );
      case GameCategoryType.SIGN:
        return GameInfoDialog(
          title: "Guess the sign?",
          image: "assets/gif/whats-the-sign-intro.gif",
          dec:
              "You need to find correct sign that finishes the given equation.",
          correctAnswerScore: ScoreUtil.signScore,
          wrongAnswerScore: ScoreUtil.signScoreMinus,
        );
      case GameCategoryType.SQUARE_ROOT:
        return GameInfoDialog(
          title: "Square Root",
          image: "assets/gif/sqroot-intro.gif",
          dec: "square root the given number.",
          correctAnswerScore: ScoreUtil.squareRootScore,
          wrongAnswerScore: ScoreUtil.squareRootScoreMinus,
        );
      case GameCategoryType.MATH_PAIRS:
        return GameInfoDialog(
          title: "Math Pairs",
          image: "assets/gif/math-pair-intro.gif",
          dec:
              "Each card contains either equation or an answer. Match the equation with correct answer.",
          correctAnswerScore: ScoreUtil.mathematicalPairsScore,
          wrongAnswerScore: ScoreUtil.mathematicalPairsScoreMinus,
        );
      case GameCategoryType.CORRECT_ANSWER:
        return GameInfoDialog(
          title: "Correct answer",
          image: "assets/gif/correct-answer.gif",
          dec: "Select the correct number to finish the equation.",
          correctAnswerScore: ScoreUtil.correctAnswerScore,
          wrongAnswerScore: ScoreUtil.correctAnswerScoreMinus,
        );
      case GameCategoryType.MAGIC_TRIANGLE:
        return GameInfoDialog(
          title: "Magic triangle",
          image: "assets/gif/magic-triangle-intro.gif",
          dec:
              "Sum of the each side of triangle should be equal to the given number. To place any number, select triangle circle and press any given number from panel.",
          correctAnswerScore: ScoreUtil.magicTriangleScore,
          wrongAnswerScore: ScoreUtil.magicTriangleScore,
        );
      case GameCategoryType.MENTAL_ARITHMETIC:
        return GameInfoDialog(
          title: "Mental Arithmetic",
          image: "assets/gif/mental-arith-intro.gif",
          dec:
              "Number with operator will be shown one by one. You need to remember the number with operator and write final answer(No precedency).",
          correctAnswerScore: ScoreUtil.mentalArithmeticScore,
          wrongAnswerScore: ScoreUtil.mentalArithmeticScoreMinus,
        );
      case GameCategoryType.QUICK_CALCULATION:
        return GameInfoDialog(
          title: "Quick calculation",
          image: "assets/gif/quick-calculation-intro.gif",
          dec:
              "Solve simple equation one by one. Faster you solve, more time will be given to solve next equation.",
          correctAnswerScore: ScoreUtil.quickCalculationScore,
          wrongAnswerScore: ScoreUtil.quickCalculationScoreMinus,
        );
      case GameCategoryType.MATH_MACHINE:
        return GameInfoDialog(
          title: "Math Grid",
          image: "assets/gif/math-machine-intro.gif",
          dec:
              "Select number from math grid to reach answer shown above. You can select any number to reach above answer.",
          correctAnswerScore: ScoreUtil.mathMachineScore,
          wrongAnswerScore: ScoreUtil.mathMachineScore,
        );
      case GameCategoryType.PICTURE_PUZZLE:
        return GameInfoDialog(
          title: "Picture Puzzle",
          image: "assets/gif/picture-puzzle-intro.gif",
          dec:
              "Each shape represents a number. Find the number of each shape from given equation and solve the last equation.",
          correctAnswerScore: ScoreUtil.picturePuzzleScore,
          wrongAnswerScore: ScoreUtil.picturePuzzleScore,
        );
      case GameCategoryType.NUMBER_PYRAMID:
        return GameInfoDialog(
          title: "Number Pyramid",
          image: "assets/gif/num-pyramid.gif",
          dec:
              "sum of consecutive cell should be placed on top cell. You need to fill all cell correctly to solve Number pyramid.",
          correctAnswerScore: ScoreUtil.numberPyramidScore,
          wrongAnswerScore: ScoreUtil.numberPyramidScore,
        );
    }
  }
}
