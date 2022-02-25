import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mathgame/src/core/color_scheme.dart';

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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: Theme.of(context).colorScheme.cardBgColor,
      elevation: 8,
      child: InkWell(
        onTap: () {
          onTab();
        },
        borderRadius: BorderRadius.circular(24),
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
