import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/mentalArithmeticProvider.dart';
import 'package:provider/provider.dart';

class MentalArithmeticButton extends StatelessWidget {
  final int flex;
  final String text;

  MentalArithmeticButton(this.text, this.flex);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MentalArithmeticProvider>(context);
    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: () {
          if (text == "CE") {
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
