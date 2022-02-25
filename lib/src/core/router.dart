import 'package:flutter/material.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/calculator/calculator_view.dart';
import 'package:mathgame/src/ui/correctAnswer/correct_answer_view.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_view.dart';
import 'package:mathgame/src/ui/home/home_view.dart';
import 'package:mathgame/src/ui/magicTriangle/magic_triangle_view.dart';
import 'package:mathgame/src/ui/mathGrid/math_grid_view.dart';
import 'package:mathgame/src/ui/mathPairs/math_pairs_view.dart';
import 'package:mathgame/src/ui/mentalArithmetic/mental_arithmetic_view.dart';
import 'package:mathgame/src/ui/picturePuzzle/picture_puzzle_view.dart';
import 'package:mathgame/src/ui/numberPyramid/number_pyramid_view.dart';
import 'package:mathgame/src/ui/quickCalculation/quick_calculation_view.dart';
import 'package:mathgame/src/ui/squareRoot/square_root_view.dart';
import 'package:mathgame/src/ui/whatsTheSign/sign_view.dart';
import 'package:tuple/tuple.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case KeyUtil.Dashboard:
      return MaterialPageRoute(builder: (context) => DashboardView());
    case KeyUtil.Home:
      var tuple4 = settings.arguments
          as Tuple4<PuzzleType, String, double, Tuple2<Color, Color>>;
      return MaterialPageRoute(
          builder: (context) => HomeView(
                puzzleType: tuple4.item1,
                colorTuple: tuple4.item4,
                opacity: tuple4.item3,
                title: tuple4.item2,
              ));
    case KeyUtil.Calculator:
      var tuple2 = settings.arguments as Tuple2<Color, Color>;
      return MaterialPageRoute(
          builder: (context) => CalculatorView(colorTuple: tuple2));
    case KeyUtil.Sign:
      var tuple2 = settings.arguments as Tuple2<Color, Color>;
      return MaterialPageRoute(
          builder: (context) => SignView(colorTuple: tuple2));
    case KeyUtil.CorrectAnswer:
      var tuple2 = settings.arguments as Tuple2<Color, Color>;
      return MaterialPageRoute(
          builder: (context) => CorrectAnswerView(colorTuple: tuple2));
    case KeyUtil.QuickCalculation:
      var tuple2 = settings.arguments as Tuple2<Color, Color>;
      return MaterialPageRoute(
          builder: (context) => QuickCalculationView(colorTuple: tuple2));
    case KeyUtil.MentalArithmetic:
      var tuple2 = settings.arguments as Tuple2<Color, Color>;
      return MaterialPageRoute(
          builder: (context) => MentalArithmeticView(colorTuple: tuple2));
    case KeyUtil.SquareRoot:
      var tuple2 = settings.arguments as Tuple2<Color, Color>;
      return MaterialPageRoute(
          builder: (context) => SquareRootView(colorTuple: tuple2));
    case KeyUtil.MathematicalPairs:
      var tuple2 = settings.arguments as Tuple2<Color, Color>;
      return MaterialPageRoute(
          builder: (context) => MathPairsView(colorTuple: tuple2));
    case KeyUtil.MagicTriangle:
      var tuple2 = settings.arguments as Tuple2<Color, Color>;
      return MaterialPageRoute(
          builder: (context) => MagicTriangleView(colorTuple: tuple2));
    case KeyUtil.MathMachine:
      var tuple2 = settings.arguments as Tuple2<Color, Color>;
      return MaterialPageRoute(
          builder: (context) => MathGridView(colorTuple: tuple2));
    case KeyUtil.PicturePuzzle:
      var tuple2 = settings.arguments as Tuple2<Color, Color>;
      return MaterialPageRoute(
          builder: (context) => PicturePuzzleView(colorTuple: tuple2));
    case KeyUtil.NumberPyramid:
      var tuple2 = settings.arguments as Tuple2<Color, Color>;
      return MaterialPageRoute(
          builder: (context) => NumberPyramidView(colorTuple: tuple2));
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
