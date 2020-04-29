import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/mentalArithmeticProvider.dart';
import 'package:provider/provider.dart';

class MentalArithmeticButton extends StatelessWidget {
  final BorderRadius borderRadius;
  final String text;

  MentalArithmeticButton(this.text, this.borderRadius);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MentalArithmeticProvider>(context);
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
}
