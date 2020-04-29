import 'package:mathgame/src/models/gameInfoDialog.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/utility/scoreUtil.dart';

class InfoDialogDataProvider {
  // ignore: missing_return
  static GameInfoDialog getInfoDialogData(GameCategoryType gameCategoryType) {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return GameInfoDialog(
            title: "Calculator",
            image: "assets/calculator-intro.gif",
            dec: '''You need to solve given equation correctly.
                                        
${ScoreUtil.calculatorScore.toInt()} for correct answer
${ScoreUtil.calculatorScoreMinus.toInt()} for wrong answer''');
        break;
      case GameCategoryType.SIGN:
        return GameInfoDialog(
            title: "Guess the sign?",
            image: "assets/whats-the-sign-intro.gif",
            dec:
                '''You need to find correct sign that finishes the given equation.
                                        
${ScoreUtil.signScore.toInt()} for correct answer
${ScoreUtil.signScoreMinus.toInt()} for wrong answer''');
        break;
      case GameCategoryType.SQUARE_ROOT:
        return GameInfoDialog(
            title: "Square Root",
            image: "assets/sqroot-intro.gif",
            dec: '''square root the given number
                                        
${ScoreUtil.squareRootScore.toInt()} for correct answer
${ScoreUtil.squareRootScoreMinus.toInt()} for wrong answer''');
        break;
      case GameCategoryType.MATH_PAIRS:
        return GameInfoDialog(
            title: "Math Pairs",
            image: "assets/math-pair-intro.gif",
            dec:
                '''Each card contains either equation or an answer. Match the equation with correct answer.
                                        
${ScoreUtil.mathematicalPairsScore.toInt()} for correct answer
${ScoreUtil.mathematicalPairsScoreMinus.toInt()} for wrong answer''');
        break;
      case GameCategoryType.CORRECT_ANSWER:
        return GameInfoDialog(
            title: "Correct answer",
            image: "assets/correct-answer.gif",
            dec: '''Select the correct number to finish the equation.
                                        
${ScoreUtil.correctAnswerScore.toInt()} for correct answer
${ScoreUtil.correctAnswerScoreMinus.toInt()} for wrong answer''');
        break;
      case GameCategoryType.MAGIC_TRIANGLE:
        return GameInfoDialog(
            title: "Magic triangle",
            image: "assets/magic-triangle-intro.gif",
            dec:
                '''Sum of the each side of triangle should be equal to the given number. To place any number, select triangle circle and press any given number from panel.
                                        
${ScoreUtil.magicTriangleScore.toInt()} for correct answer
''');
        break;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return GameInfoDialog(
            title: "Mental Arithmetic",
            image: "assets/mental-arith-intro.gif",
            dec:
                '''Number with operator will be shown one by one. You need to remember the number with operator and write final answer(No precedency).
                                        
${ScoreUtil.mentalArithmeticScore.toInt()} for correct answer
${ScoreUtil.mentalArithmeticScoreMinus.toInt()} for wrong answer''');
        break;
      case GameCategoryType.QUICK_CALCULATION:
        return GameInfoDialog(
            title: "Quick calculation",
            image: "assets/quick-calculation-intro.gif",
            dec:
                '''Solve simple equation one by one. Faster you solve, more time will be given to solve next equation.
                                        
${ScoreUtil.quickCalculationScore.toInt()} for correct answer
${ScoreUtil.quickCalculationScoreMinus.toInt()} for wrong answer
''');
        break;
      case GameCategoryType.MATH_MACHINE:
        return GameInfoDialog(
            title: "Math Grid",
            image: "assets/math-machine-intro.gif",
            dec:
                '''Select number from math grid to reach answer shown above. You can select any number to reach above answer. 
                                        
${ScoreUtil.mathMachineScore.toInt()} for each correct equation
''');
        break;
    }
  }
}
