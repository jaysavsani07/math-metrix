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

  Color get dividerColor =>
      brightness == Brightness.light ?
      Color(0xFFeeeeee) :
      Color(0xFFeeeeee);

  Color get iconBgColor =>
      brightness == Brightness.light ?
      Color(0xFFF5F5F5) :
      Color(0xFF000000);

  Color get dialogBgColor =>
      brightness == Brightness.light ? Color(0xffF7F7F7) : Color(0xff212121);

  Color get dialogGifBgColor =>
      brightness == Brightness.light ? Colors.white : Color(0xff424242);
}
