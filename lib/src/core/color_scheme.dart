import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  Color get baseColor =>
      brightness == Brightness.light ? Colors.white : Colors.black;

  Color get baseLightColor =>
      brightness == Brightness.light ? Colors.white60 : Colors.black54;

  Color get crossColor =>
      brightness == Brightness.light ? Colors.black : Colors.white;

  Color get crossLightColor =>
      brightness == Brightness.light ? Color(0xffcdcdcd) : Colors.white60;

  Color get dividerColor =>
      brightness == Brightness.light ? Color(0xFFeeeeee) : Color(0xFFeeeeee);

  Color get cardBgColor =>
      brightness == Brightness.light ? Color(0xffF5F5F5) : Color(0xff212121);

  Color get iconCardBgColor =>
      brightness == Brightness.light ? Color(0xffF5F5F5) : Colors.black;

  Color get toolbarExpandedColor =>
      brightness == Brightness.light ? Color(0xFFffffff) : Color(0xFF000000);

  Color get toolbarCollapsedColor =>
      brightness == Brightness.light ? Color(0xFFffffff) : Color(0xFF212121);

  Color get dialogBgColor =>
      brightness == Brightness.light ? Colors.white : Color(0xff212121);

  Color get infoDialogBgColor =>
      brightness == Brightness.light ? Color(0xFFf7f7f7) : Color(0xff212121);

  Color get dialogGifBgColor =>
      brightness == Brightness.light ? Colors.white : Color(0xff424242);

  Color get triangleLineColor =>
      brightness == Brightness.light ? Color(0xffeeeeee) : Color(0xff424242);
}
