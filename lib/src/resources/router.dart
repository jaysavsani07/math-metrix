

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/ui/calculator/calculator.dart';
import 'package:mathgame/src/ui/correctAnswer/correct_answer.dart';
import 'package:mathgame/src/ui/dashboard.dart';
import 'package:mathgame/src/ui/home.dart';
import 'package:mathgame/src/ui/magicTriangle/magic_triangle.dart';
import 'package:mathgame/src/ui/mathGrid/math_grid.dart';
import 'package:mathgame/src/ui/mathPairs/mathPairs.dart';
import 'package:mathgame/src/ui/mentalArithmetic/mental_arithmetic.dart';
import 'package:mathgame/src/ui/picturePuzzle/picturePuzzle.dart';
import 'package:mathgame/src/ui/numberPyramid/number_pyramid.dart';
import 'package:mathgame/src/ui/quickCalculation/quickCalculation.dart';
import 'package:mathgame/src/ui/squareRoot/square_root.dart';
import 'package:mathgame/src/ui/whatsTheSign/whats_the_sign.dart';
import 'package:mathgame/src/utility/keyUtil.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case KeyUtil.Dashboard:
      return MaterialPageRoute(builder: (context) => DashBoardPage());
    case KeyUtil.Home:
      var puzzleType = settings.arguments as PuzzleType;
      return MaterialPageRoute(
          builder: (context) => MyHomePage(
                puzzleType: puzzleType,
                title: puzzleType == PuzzleType.MATH_PUZZLE
                    ? "Math Puzzle"
                    : (puzzleType == PuzzleType.MEMORY_PUZZLE
                        ? "Memory Puzzle"
                        : "Train Your Brain"),
              ));
    case KeyUtil.Calculator:
      return MaterialPageRoute(builder: (context) => Calculator());
    case KeyUtil.Sign:
      return MaterialPageRoute(builder: (context) => WhatsTheSign());
    case KeyUtil.CorrectAnswer:
      return MaterialPageRoute(builder: (context) => CorrectAnswer());
    case KeyUtil.QuickCalculation:
      return MaterialPageRoute(builder: (context) => QuickCalculation());
    case KeyUtil.MentalArithmetic:
      return MaterialPageRoute(builder: (context) => MentalArithmetic());
    case KeyUtil.SquareRoot:
      return MaterialPageRoute(builder: (context) => SquareRoot());
    case KeyUtil.MathematicalPairs:
      return MaterialPageRoute(builder: (context) => MathPairs());
    case KeyUtil.MagicTriangle:
      return MaterialPageRoute(builder: (context) => MagicTriangle());
    case KeyUtil.MathMachine:
      return MaterialPageRoute(builder: (context) => MathGrid());
    case KeyUtil.PicturePuzzle:
      return MaterialPageRoute(builder: (context) => PicturePuzzle());
    case KeyUtil.NumberPyramid:
      return MaterialPageRoute(builder: (context) => NumberPyramid());
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
