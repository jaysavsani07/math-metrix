import 'package:flutter/material.dart';
import 'package:mathgame/src/core/color_scheme.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  final Function onTab;

  CommonTextButton({
    required this.text,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTab();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 8,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            gradient: LinearGradient(
              colors: [Color(0xff4895EF), Color(0xff3f37c9)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: 24, color: Theme.of(context).colorScheme.baseColor),
          ),
        ),
      ),
    );
  }
}
