import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:mathgame/src/models/scoreboard/Scoreboard.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/gameCategory.dart';

class HomeViewModel extends ChangeNotifier {
  List<GameCategory> _list;
  SharedPreferences _preferences;

  List<GameCategory> get list => _list;

  SharedPreferences get preferences => _preferences;

  Future<void> initialise() async {
    _list = List();
    _preferences = await SharedPreferences.getInstance();
    list.add(GameCategory(1, "Calculator", "calculator",
        GameCategoryType.CALCULATOR, getScoreboard("calculator")));
    list.add(GameCategory(2, "What's the sign?", "sign", GameCategoryType.SIGN,
        getScoreboard("sign")));
    list.add(GameCategory(3, "Square root", "square_root",
        GameCategoryType.SQUARE_ROOT, getScoreboard("square_root")));
    list.add(GameCategory(4, "Mathematical pairs", "math_pairs",
        GameCategoryType.MATH_PAIRS, getScoreboard("math_pairs")));
    list.add(GameCategory(5, "Correct answer", "correct_answer",
        GameCategoryType.CORRECT_ANSWER, getScoreboard("correct_answer")));
    list.add(GameCategory(6, "Magic triangle", "magic_tringle",
        GameCategoryType.MAGIC_TRIANGLE, getScoreboard("magic_tringle")));
    list.add(GameCategory(
        7,
        "Mental arithmetic",
        "mental_arithmatic",
        GameCategoryType.MENTAL_ARITHMETIC,
        getScoreboard("mental_arithmatic")));
    list.add(GameCategory(8, "Quick calculation", "quick_calclation",
        GameCategoryType.QUICK_CALCULATION, getScoreboard("quick_calclation")));
    list.add(GameCategory(9, "Math Machine Square", "math_machine",
        GameCategoryType.MATH_MACHINE, getScoreboard("math_machine")));
    notifyListeners();
  }

  Scoreboard getScoreboard(String gameCategoryType) {
    return Scoreboard.fromJson(
        json.decode(_preferences.getString(gameCategoryType) ?? "{}"));
  }

  void setScoreboard(String gameCategoryType, Scoreboard scoreboard) {
    _preferences.setString(gameCategoryType, json.encode(scoreboard.toJson()));
  }

  void updateScoreboard(GameCategoryType gameCategoryType, int newScore) {
    list.forEach((gameCategory) {
      if (gameCategory.gameCategoryType == gameCategoryType) {
        if (gameCategory.scoreboard.highestScore < newScore) {
          gameCategory.scoreboard.highestScore = newScore;
          setScoreboard(gameCategory.key, gameCategory.scoreboard);
        }
      }
    });
    notifyListeners();
  }
}
