import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/calculatorProvider.dart';
import 'package:provider/provider.dart';

class CalculatorButton extends StatelessWidget {
  final int flex;
  final String text;

  CalculatorButton(this.text, this.flex);

  @override
  Widget build(BuildContext context) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context);
    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: () {
          if (text == "Clear") {
            calculatorProvider.clear();
          } else {
            calculatorProvider.checkResult(text);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.grey),
          ),
          margin: EdgeInsets.all(5),
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
    ;
  }
}
