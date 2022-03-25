import 'package:flutter/material.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/ui/common/common_tab_animation_view.dart';

class CommonBackButton extends StatelessWidget {
  final Function onTab;
  final double height;

  const CommonBackButton({
    Key? key,
    required this.onTab,
    this.height = 112,
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
              child: Icon(
                Icons.backspace,
                color: Theme.of(context).colorScheme.crossColor,
              )),
        ),
      ),
    );
  }
}
