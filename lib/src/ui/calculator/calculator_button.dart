import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/calculatorProvider.dart';
import 'package:provider/provider.dart';

class CalculatorButton extends StatelessWidget {
  final BorderRadius borderRadius;
  final String text;

  CalculatorButton(this.text, this.borderRadius);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context, listen: false);
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          if (text == "CLEAR") {
            provider.clear();
          } else {
            provider.checkResult(text);
          }
        },
        borderRadius: borderRadius,
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
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius getRadius(String text) {
    if (text == "7")
      return BorderRadius.only(topLeft: Radius.circular(40));
    else if (text == "9")
      return BorderRadius.only(topRight: Radius.circular(40));
    else if (text == "0")
      return BorderRadius.only(bottomLeft: Radius.circular(40));
    else if (text == "CLEAR")
      return BorderRadius.only(bottomRight: Radius.circular(40));
    else
      return BorderRadius.all(Radius.zero);
  }
}
