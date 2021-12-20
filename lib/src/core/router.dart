

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/calculator/calculator_view.dart';
import 'package:mathgame/src/ui/correctAnswer/correct_answer_view.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_view.dart';
import 'package:mathgame/src/ui/home.dart';
import 'package:mathgame/src/ui/magicTriangle/magic_triangle_view.dart';
import 'package:mathgame/src/ui/mathGrid/math_grid_view.dart';
import 'package:mathgame/src/ui/mathPairs/math_pairs_view.dart';
import 'package:mathgame/src/ui/mentalArithmetic/mental_arithmetic_view.dart';
import 'package:mathgame/src/ui/picturePuzzle/picture_puzzle_view.dart';
import 'package:mathgame/src/ui/numberPyramid/number_pyramid_view.dart';
import 'package:mathgame/src/ui/quickCalculation/quick_calculation_view.dart';
import 'package:mathgame/src/ui/squareRoot/square_root_view.dart';
import 'package:mathgame/src/ui/whatsTheSign/sign_view.dart';
import 'package:mathgame/src/core/app_constant.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case KeyUtil.Dashboard:
      return MaterialPageRoute(builder: (context) => DashboardView());
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
      return MaterialPageRoute(builder: (context) => CalculatorView());
    case KeyUtil.Sign:
      return MaterialPageRoute(builder: (context) => SignView());
    case KeyUtil.CorrectAnswer:
      return MaterialPageRoute(builder: (context) => CorrectAnswerView());
    case KeyUtil.QuickCalculation:
      return MaterialPageRoute(builder: (context) => QuickCalculationView());
    case KeyUtil.MentalArithmetic:
      return MaterialPageRoute(builder: (context) => MentalArithmeticView());
    case KeyUtil.SquareRoot:
      return MaterialPageRoute(builder: (context) => SquareRootView());
    case KeyUtil.MathematicalPairs:
      return MaterialPageRoute(builder: (context) => MathPairsView());
    case KeyUtil.MagicTriangle:
      return MaterialPageRoute(builder: (context) => MagicTriangleView());
    case KeyUtil.MathMachine:
      return MaterialPageRoute(builder: (context) => MathGridView());
    case KeyUtil.PicturePuzzle:
      return MaterialPageRoute(builder: (context) => PicturePuzzleView());
    case KeyUtil.NumberPyramid:
      return MaterialPageRoute(builder: (context) => NumberPyramidView());
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
