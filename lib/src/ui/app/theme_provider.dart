import 'package:flutter/material.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  String appVersion = "";
  final SharedPreferences sharedPreferences;

  ThemeProvider({required this.sharedPreferences}) {
    themeMode =
        ThemeMode.values[sharedPreferences.getInt(KeyUtil.IS_DARK_MODE) ?? 2];

    PackageInfo.fromPlatform().then((value) {
      appVersion = value.version;
    });
  }

  void changeTheme() async {
    print(themeMode);
    if (themeMode == ThemeMode.light)
      themeMode = ThemeMode.dark;
    else
      themeMode = ThemeMode.light;
    print(themeMode);
    notifyListeners();
    await sharedPreferences.setInt(KeyUtil.IS_DARK_MODE, themeMode.index);
  }
}
