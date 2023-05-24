import 'package:flutter/material.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/ui/common/common_tab_animation_view.dart';

class CommonClearButton extends StatelessWidget {
  final Function onTab;
  final double height;
  final String text;
  final double fontSize;

  const CommonClearButton({
    Key? key,
    required this.onTab,
    required this.text,
    this.height = 112,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonTabAnimationView(
      onTab: onTab,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        color: Theme.of(context).colorScheme.cardBgColor,
        elevation: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.cardBgColor,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: fontSize,
                    color: Theme.of(context).colorScheme.crossColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
