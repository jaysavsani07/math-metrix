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
                                        
${ScoreUtil.calculatorScore} for correct answer
${ScoreUtil.calculatorScoreMinus} for wrong answer''');
        break;
      case GameCategoryType.SIGN:
        return GameInfoDialog(
            title: "Guess the sign?",
            image: "assets/whats-the-sign-intro.gif",
            dec:
                '''You need to find correct sign that finishes the given equation.
                                        
${ScoreUtil.signScore} for correct answer
${ScoreUtil.signScoreMinus} for wrong answer''');
        break;
      case GameCategoryType.SQUARE_ROOT:
        return GameInfoDialog(
            title: "Square Root",
            image: "assets/sqroot-intro.gif",
            dec: '''square root the given number
                                        
${ScoreUtil.squareRootScore} for correct answer
${ScoreUtil.squareRootScoreMinus} for wrong answer''');
        break;
      case GameCategoryType.MATH_PAIRS:
        return GameInfoDialog(
            title: "Math Pairs",
            image: "assets/math-pair-intro.gif",
            dec:
                '''Each card contains either equation or an answer. Match the equation with correct answer.
                                        
${ScoreUtil.mathematicalPairsScore.toInt()} for correct answer
${ScoreUtil.mathematicalPairsScoreMinus} for wrong answer''');
        break;
      case GameCategoryType.CORRECT_ANSWER:
        return GameInfoDialog(
            title: "Correct answer",
            image: "assets/correct-answer.gif",
            dec: '''Select the correct number to finish the equation.
                                        
${ScoreUtil.correctAnswerScore} for correct answer
${ScoreUtil.correctAnswerScoreMinus} for wrong answer''');
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
                                        
${ScoreUtil.quickCalculationScore} for correct answer
${ScoreUtil.quickCalculationScoreMinus} for wrong answer
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
      case GameCategoryType.PICTURE_PUZZLE:
        return GameInfoDialog(
            title: "Picture Puzzle",
            image: "assets/picture-puzzle-intro.gif",
            dec:
                '''Each shape represents a number. Find the number of each shape from given equation and solve the last equation. 
                                        
${ScoreUtil.picturePuzzleScore.toInt()} for each correct equation
''');
      case GameCategoryType.NUMBER_PYRAMID:
        // TODO: Handle this case.
      return GameInfoDialog(
        title: "Number Pyramid",
        image: "assets/num-pyramid.gif",
        dec: '''
sum of consecutive cell should be placed on top cell. You need to fill all cell correctly to solve Number pyramid.

${ScoreUtil.numberPyramidScore.toInt()} for each correct equation
        '''
      );
        break;
    }
  }
}
