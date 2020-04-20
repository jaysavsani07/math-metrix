import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:mathgame/src/models/scoreboard/Scoreboard.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/gameCategory.dart';

class DashboardViewModel extends ChangeNotifier {
  int _overallScore = 0;
  int _totalCoin = 0;
  List<GameCategory> _list;
  SharedPreferences _preferences;

  int get overallScore => _overallScore;

  int get totalCoin => _totalCoin;

  List<GameCategory> get list => _list;

  SharedPreferences get preferences => _preferences;

  Future<void> initialise() async {
    _preferences = await SharedPreferences.getInstance();
    _overallScore = getOverallScore();
    _totalCoin = getTotalCoin();
  }

  Future<void> getGameByPuzzleType(PuzzleType puzzleType) async {
    _list = List();

    switch (puzzleType) {
      case PuzzleType.MATH_PUZZLE:
        list.add(GameCategory(1, "Calculator", "calculator",
            GameCategoryType.CALCULATOR, getScoreboard("calculator")));
        list.add(GameCategory(2, "What's the sign?", "sign",
            GameCategoryType.SIGN, getScoreboard("sign")));
        list.add(GameCategory(5, "Correct answer", "correct_answer",
            GameCategoryType.CORRECT_ANSWER, getScoreboard("correct_answer")));
        list.add(GameCategory(
            8,
            "Quick calculation",
            "quick_calclation",
            GameCategoryType.QUICK_CALCULATION,
            getScoreboard("quick_calclation")));
        break;
      case PuzzleType.MEMORY_PUZZLE:
        list.add(GameCategory(
            7,
            "Mental arithmetic",
            "mental_arithmatic",
            GameCategoryType.MENTAL_ARITHMETIC,
            getScoreboard("mental_arithmatic")));
        list.add(GameCategory(3, "Square root", "square_root",
            GameCategoryType.SQUARE_ROOT, getScoreboard("square_root")));
        list.add(GameCategory(4, "Mathematical pairs", "math_pairs",
            GameCategoryType.MATH_PAIRS, getScoreboard("math_pairs")));
        break;
      case PuzzleType.BRAIN_PUZZLE:
        list.add(GameCategory(6, "Magic triangle", "magic_tringle",
            GameCategoryType.MAGIC_TRIANGLE, getScoreboard("magic_tringle")));
        list.add(GameCategory(9, "Math Machine Square", "math_machine",
            GameCategoryType.MATH_MACHINE, getScoreboard("math_machine")));
        break;
    }
  }

  Scoreboard getScoreboard(String gameCategoryType) {
    return Scoreboard.fromJson(
        json.decode(_preferences.getString(gameCategoryType) ?? "{}"));
  }

  void setScoreboard(String gameCategoryType, Scoreboard scoreboard) {
    _preferences.setString(gameCategoryType, json.encode(scoreboard.toJson()));
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
        }
        gameCategory.scoreboard.highestScore = newScore.toInt();
        setScoreboard(gameCategory.key, gameCategory.scoreboard);
      }
    });
  }

  int getOverallScore() {
    return _preferences.getInt("overall_score") ?? 0;
  }

  void setOverallScore(int highestScore, int newScore) {
    _overallScore = getOverallScore() - highestScore + newScore;
    _preferences.setInt("overall_score", _overallScore);
  }

  int getTotalCoin() {
    return _preferences.getInt("total_coin") ?? 0;
  }

  void setTotalCoin(int coin) {
    _totalCoin = getTotalCoin() + coin;
    _preferences.setInt("total_coin", _totalCoin);
  }
}
