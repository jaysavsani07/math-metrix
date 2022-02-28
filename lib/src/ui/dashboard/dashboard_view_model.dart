import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:mathgame/src/core/app_assets.dart';
import 'package:mathgame/src/data/models/score_board.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/game_category.dart';

class DashboardViewModel extends ChangeNotifier {
  int _overallScore = 0;
  int _totalCoin = 0;
  late List<GameCategory> _list;
  final SharedPreferences preferences;

  int get overallScore => _overallScore;

  int get totalCoin => _totalCoin;

  List<GameCategory> get list => _list;

  DashboardViewModel({required this.preferences}) {
    _overallScore = getOverallScore();
    _totalCoin = getTotalCoin();
  }

  List<GameCategory> getGameByPuzzleType(PuzzleType puzzleType) {
    _list = <GameCategory>[];
    switch (puzzleType) {
      case PuzzleType.MATH_PUZZLE:
        list.add(GameCategory(
          1,
          "Calculator",
          "calculator",
          GameCategoryType.CALCULATOR,
          KeyUtil.Calculator,
          getScoreboard("calculator"),
          AppAssets.icCalculator,
        ));
        list.add(GameCategory(
          2,
          "Guess the sign?",
          "sign",
          GameCategoryType.SIGN,
          KeyUtil.Sign,
          getScoreboard("sign"),
          AppAssets.icGuessTheSign
        ));
        list.add(GameCategory(
          5,
          "Correct answer",
          "correct_answer",
          GameCategoryType.CORRECT_ANSWER,
          KeyUtil.CorrectAnswer,
          getScoreboard("correct_answer"),
          AppAssets.icCorrectAnswer,
        ));
        list.add(GameCategory(
          8,
          "Quick calculation",
          "quick_calclation",
          GameCategoryType.QUICK_CALCULATION,
          KeyUtil.QuickCalculation,
          getScoreboard("quick_calclation"),
          AppAssets.icQuickCalculation,
        )); list.add(GameCategory(
          5,
          "Correct answer",
          "correct_answer",
          GameCategoryType.CORRECT_ANSWER,
          KeyUtil.CorrectAnswer,
          getScoreboard("correct_answer"),
          AppAssets.icCorrectAnswer,
        ));
        list.add(GameCategory(
          8,
          "Quick calculation",
          "quick_calclation",
          GameCategoryType.QUICK_CALCULATION,
          KeyUtil.QuickCalculation,
          getScoreboard("quick_calclation"),
          AppAssets.icQuickCalculation,
        ));
        break;
      case PuzzleType.MEMORY_PUZZLE:
        list.add(GameCategory(
          7,
          "Mental arithmetic",
          "mental_arithmatic",
          GameCategoryType.MENTAL_ARITHMETIC,
          KeyUtil.MentalArithmetic,
          getScoreboard("mental_arithmatic"),
          AppAssets.icMentalArithmetic,
        ));
        list.add(GameCategory(
          3,
          "Square root",
          "square_root",
          GameCategoryType.SQUARE_ROOT,
          KeyUtil.SquareRoot,
          getScoreboard("square_root"),
          AppAssets.icSquareRoot,
        ));
        list.add(GameCategory(
          9,
          "Math Grid",
          "math_machine",
          GameCategoryType.MATH_MACHINE,
          KeyUtil.MathMachine,
          getScoreboard("math_machine"),
          AppAssets.icMathGrid,
        ));
        list.add(GameCategory(
          4,
          "Mathematical pairs",
          "math_pairs",
          GameCategoryType.MATH_PAIRS,
          KeyUtil.MathematicalPairs,
          getScoreboard("math_pairs"),
          AppAssets.icMathematicalPairs,
        ));
        break;
      case PuzzleType.BRAIN_PUZZLE:
        list.add(GameCategory(
          6,
          "Magic triangle",
          "magic_tringle",
          GameCategoryType.MAGIC_TRIANGLE,
          KeyUtil.MagicTriangle,
          getScoreboard("magic_tringle"),
          AppAssets.icMagicTriangle,
        ));
        list.add(GameCategory(
          10,
          "Picture Puzzle",
          "picture_puzzle",
          GameCategoryType.PICTURE_PUZZLE,
          KeyUtil.PicturePuzzle,
          getScoreboard("picture_puzzle"),
          AppAssets.icPicturePuzzle,
        ));
        list.add(GameCategory(
          11,
          "Number Pyramid",
          "number_pyramid",
          GameCategoryType.NUMBER_PYRAMID,
          KeyUtil.NumberPyramid,
          getScoreboard("number_pyramid"),
          AppAssets.icNumbePyramid,
        ));
        break;
    }
    return _list;
  }

  ScoreBoard getScoreboard(String gameCategoryType) {
    return ScoreBoard.fromJson(
        json.decode(preferences.getString(gameCategoryType) ?? "{}"));
  }

  void setScoreboard(String gameCategoryType, ScoreBoard scoreboard) {
    preferences.setString(gameCategoryType, json.encode(scoreboard.toJson()));
  }

  void updateScoreboard(
      GameCategoryType gameCategoryType, double newScore, double coin) {
    list.forEach((gameCategory) {
      if (gameCategory.gameCategoryType == gameCategoryType) {
        gameCategory.scoreboard.coin =
            gameCategory.scoreboard.coin + coin.toInt();
        setTotalCoin(coin.toInt());
        if (gameCategory.scoreboard.highestScore < newScore.toInt()) {
          setOverallScore(
              gameCategory.scoreboard.highestScore, newScore.toInt());
          gameCategory.scoreboard.highestScore = newScore.toInt();
        }
        setScoreboard(gameCategory.key, gameCategory.scoreboard);
      }
    });
    notifyListeners();
  }

  int getOverallScore() {
    return preferences.getInt("overall_score") ?? 0;
  }

  void setOverallScore(int highestScore, int newScore) {
    _overallScore = getOverallScore() - highestScore + newScore;
    preferences.setInt("overall_score", _overallScore);
  }

  int getTotalCoin() {
    return preferences.getInt("total_coin") ?? 0;
  }

  void setTotalCoin(int coin) {
    _totalCoin = getTotalCoin() + coin;
    preferences.setInt("total_coin", _totalCoin);
  }

  bool isFirstTime(GameCategoryType gameCategoryType) {
    return list
        .where((GameCategory gameCategory) =>
            gameCategory.gameCategoryType == gameCategoryType)
        .first
        .scoreboard
        .firstTime;
  }

  void setFirstTime(GameCategoryType gameCategoryType) {
    list.forEach((gameCategory) {
      if (gameCategory.gameCategoryType == gameCategoryType) {
        gameCategory.scoreboard.firstTime = false;
        setScoreboard(gameCategory.key, gameCategory.scoreboard);
      }
    });
  }
}
