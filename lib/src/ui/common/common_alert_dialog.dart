import 'package:flutter/material.dart';
import 'package:mathgame/src/core/color_scheme.dart';

class CommonAlertDialog extends AlertDialog {
  final Widget child;

  CommonAlertDialog({required this.child}) : super();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.dialogBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      content: child,
    );
  }
}
