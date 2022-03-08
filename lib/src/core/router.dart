import 'package:flutter/material.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/data/models/dashboard.dart';
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

var appRoutes = {
  KeyUtil.dashboard: (context) => DashboardView(),
  KeyUtil.Home: (context) => HomeView(
      dashboard: ModalRoute.of(context)?.settings.arguments as Dashboard),
  KeyUtil.Calculator: (context) => CalculatorView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<Color, Color>),
  KeyUtil.Sign: (context) => SignView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<Color, Color>),
  KeyUtil.CorrectAnswer: (context) => CorrectAnswerView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<Color, Color>),
  KeyUtil.QuickCalculation: (context) => QuickCalculationView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<Color, Color>),
  KeyUtil.MentalArithmetic: (context) => MentalArithmeticView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<Color, Color>),
  KeyUtil.SquareRoot: (context) => SquareRootView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<Color, Color>),
  KeyUtil.MathematicalPairs: (context) => MathPairsView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<Color, Color>),
  KeyUtil.MagicTriangle: (context) => MagicTriangleView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<Color, Color>),
  KeyUtil.MathMachine: (context) => MathGridView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<Color, Color>),
  KeyUtil.PicturePuzzle: (context) => PicturePuzzleView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<Color, Color>),
  KeyUtil.NumberPyramid: (context) => NumberPyramidView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<Color, Color>),
};
