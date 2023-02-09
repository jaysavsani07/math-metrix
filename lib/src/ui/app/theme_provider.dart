import 'package:flutter/material.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  DifficultyType difficultyType = DifficultyType.MEDIUM;

  final SharedPreferences sharedPreferences;

  ThemeProvider({required this.sharedPreferences}) {
    themeMode =
        ThemeMode.values[sharedPreferences.getInt(KeyUtil.IS_DARK_MODE) ?? 2];
    difficultyType =
        DifficultyType.values[sharedPreferences.getInt("difficulty") ?? 2];
  }

  void changeTheme() async {
    if (themeMode == ThemeMode.light)
      themeMode = ThemeMode.dark;
    else
      themeMode = ThemeMode.light;
    notifyListeners();
    await sharedPreferences.setInt(KeyUtil.IS_DARK_MODE, themeMode.index);
  }

  Future<void> changeDifficulty(DifficultyType difficultyType) async {
    this.difficultyType = difficultyType;
    notifyListeners();
    await sharedPreferences.setInt("difficulty", difficultyType.index);
  }
}
