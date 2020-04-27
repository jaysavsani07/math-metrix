import 'package:mathgame/src/models/gameInfoDialog.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';

class InfoDialogDataProvider {
  // ignore: missing_return
  static GameInfoDialog getInfoDialogData(GameCategoryType gameCategoryType) {
    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return GameInfoDialog(
            title: "Calculator",
            image: "assets/magic-triangle-intro.gif",
            dec: '''You need to solve given equation correctly
                                        
+1 for correct answer
-1 for wrong answer''');
        break;
      case GameCategoryType.SIGN:
        return GameInfoDialog(
            title: "What's the sign?",
            image: "assets/magic-triangle-intro.gif",
            dec: '''You need to solve given equation correctly
                                        
+1 for correct answer
-1 for wrong answer''');
        break;
      case GameCategoryType.SQUARE_ROOT:
        return GameInfoDialog(
            title: "Square root",
            image: "assets/magic-triangle-intro.gif",
            dec: '''You need to solve given equation correctly
                                        
+1 for correct answer
-1 for wrong answer''');
        break;
      case GameCategoryType.MATH_PAIRS:
        return GameInfoDialog(
            title: "Mathematical pairs",
            image: "assets/magic-triangle-intro.gif",
            dec: '''You need to solve given equation correctly
                                        
+1 for correct answer
-1 for wrong answer''');
        break;
      case GameCategoryType.CORRECT_ANSWER:
        return GameInfoDialog(
            title: "Correct answer",
            image: "assets/magic-triangle-intro.gif",
            dec: '''You need to solve given equation correctly
                                        
+1 for correct answer
-1 for wrong answer''');
        break;
      case GameCategoryType.MAGIC_TRIANGLE:
        return GameInfoDialog(
            title: "Magic triangle",
            image: "assets/magic-triangle-intro.gif",
            dec: '''You need to solve given equation correctly
                                        
+1 for correct answer
-1 for wrong answer''');
        break;
      case GameCategoryType.MENTAL_ARITHMETIC:
        return GameInfoDialog(
            title: "Mental arithmetic",
            image: "assets/magic-triangle-intro.gif",
            dec: '''You need to solve given equation correctly
                                        
+1 for correct answer
-1 for wrong answer''');
        break;
      case GameCategoryType.QUICK_CALCULATION:
        return GameInfoDialog(
            title: "Quick calculation",
            image: "assets/magic-triangle-intro.gif",
            dec: '''You need to solve given equation correctly
                                        
+1 for correct answer
-1 for wrong answer''');
        break;
      case GameCategoryType.MATH_MACHINE:
        return GameInfoDialog(
            title: "Math Machine Square",
            image: "assets/magic-triangle-intro.gif",
            dec: '''You need to solve given equation correctly
                                        
+1 for correct answer
-1 for wrong answer''');
        break;
    }
  }
}
