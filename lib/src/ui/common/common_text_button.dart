import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/common/common_tab_animation_view.dart';
import 'package:tuple/tuple.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  final Function onTab;
  final Tuple2<Color, Color> colorTuple;

  CommonTextButton({
    required this.text,
    required this.onTab,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    return CommonTabAnimationView(
      onTab: onTab,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            gradient: LinearGradient(
              colors: [colorTuple.item1, colorTuple.item2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
