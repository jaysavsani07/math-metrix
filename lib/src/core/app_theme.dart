import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    ThemeData base = ThemeData.light();

    return base.copyWith(
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      textTheme: base.textTheme.copyWith(
        caption: base.textTheme.caption!.copyWith(
          color: Color(0xff757575),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    ThemeData base = ThemeData.dark();

    return base.copyWith(
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      cardColor: Colors.black,
      textTheme: base.textTheme.copyWith(
        caption: base.textTheme.caption!.copyWith(
          color: Color(0xff616161),
        ),
      ),
    );
  }
}
