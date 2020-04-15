import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/quickCalculationProvider.dart';
import 'package:provider/provider.dart';

class QuickCalculationButton extends StatelessWidget {
  final int flex;
  final String text;

  QuickCalculationButton(this.text, this.flex);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuickCalculationProvider>(context);
    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: () {
          if (text == "Clear") {
            provider.clear();
          } else {
            provider.checkResult(text);
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
