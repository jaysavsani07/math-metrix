import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      backgroundColor: Color(0xFFaa0000),
      brightness: Brightness.light,
      primaryColor: Colors.deepPurple,
      primaryColorDark: Colors.deepPurple[700],
      primaryColorLight: Colors.deepPurple[300],
      /*primaryColorDark: Color(0x673ab7),
              primaryColorLight: Color(0x8561c5),*/
      primarySwatch: Colors.yellow,
      accentColor: Colors.deepOrange[300],
      // scaffoldBackgroundColor: Color(0xFF121212),
      dialogBackgroundColor: Colors.blueGrey[900],
      splashColor: Colors.grey,
      highlightColor: Colors.white60,
      dividerColor: Colors.grey[900],
      applyElevationOverlayColor: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      backgroundColor: Color(0xFFaa0000),
      brightness: Brightness.dark,
      primaryColor: Colors.deepPurple,
      primaryColorDark: Colors.deepPurple[700],
      primaryColorLight: Colors.deepPurple[300],
      /*primaryColorDark: Color(0x673ab7),
              primaryColorLight: Color(0x8561c5),*/
      primarySwatch: Colors.yellow,
      accentColor: Colors.deepOrange[300],
      scaffoldBackgroundColor: Color(0xFF121212),
      dialogBackgroundColor: Colors.blueGrey[900],
      splashColor: Colors.grey,
      highlightColor: Colors.white60,
      dividerColor: Colors.grey[900],
      applyElevationOverlayColor: true,
    );
  }
}
