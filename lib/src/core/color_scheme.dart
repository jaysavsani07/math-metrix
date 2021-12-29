import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  Color get baseColor =>
      brightness == Brightness.light ? Colors.white : Colors.black;
  //
  Color get baseLightColor => brightness == Brightness.light
      ? Colors.white60
      : Colors.black54;
  //
  Color get crossColor =>
      brightness == Brightness.light ? Colors.black : Colors.white;
  //
  Color get crossLightColor => brightness == Brightness.light
      ? Colors.black54
      : Colors.white60;

  Color get paiChartColor =>
      brightness == Brightness.light ?
      Color(0xFFBDCDE0) :
      Color(0xFF292D32);

  Color get paiChartShadowLightColor =>
      brightness == Brightness.light ? Colors.black : Colors.white;

  Color get paiChartShadowDarkColor =>
      brightness == Brightness.light ? Colors.white : Colors.black;
}
