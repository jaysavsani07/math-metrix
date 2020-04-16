import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/signProvider.dart';
import 'package:provider/provider.dart';

class SignButton extends StatelessWidget {
  final String text;
  final BorderRadius borderRadius;

  SignButton(this.text, this.borderRadius);

  @override
  Widget build(BuildContext context) {
    final signProvider = Provider.of<SignProvider>(context);
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          signProvider.checkResult(text);
        },
        borderRadius: getRadius(text),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: borderRadius,
            border: Border.all(color: Theme.of(context).dividerColor, width: 1),
          ),
          margin: EdgeInsets.all(1),
          constraints: BoxConstraints.expand(),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius getRadius(String text) {
    if (text == "+")
      return BorderRadius.only(topLeft: Radius.circular(40));
    else if (text == "-")
      return BorderRadius.only(topRight: Radius.circular(40));
    else if (text == "*")
      return BorderRadius.only(bottomLeft: Radius.circular(40));
    else if (text == "/")
      return BorderRadius.only(bottomRight: Radius.circular(40));
    else
      return BorderRadius.all(Radius.zero);
  }
}
