import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:tuple/tuple.dart';

class Dashboard {
  final String title;
  final String subtitle;
  final String icon;
  final String outlineIcon;
  final PuzzleType puzzleType;
  final double opacity;
  final Tuple2<Color, Color> colorTuple;
  Color fillIconColor;
  Color outlineIconColor;

  Dashboard({
    required this.puzzleType,
    required this.colorTuple,
    required this.opacity,
    required this.icon,
    required this.outlineIcon,
    required this.subtitle,
    required this.title,
    required this.fillIconColor,
    required this.outlineIconColor,
  });
}
