import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/correctAnswerProvider.dart';
import 'package:provider/provider.dart';

class CorrectAnswerButton extends StatelessWidget {
  final int flex;
  final String text;

  CorrectAnswerButton(this.text, this.flex);

  @override
  Widget build(BuildContext context) {
    final correctAnswerProvider = Provider.of<CorrectAnswerProvider>(context);
    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: () {
          correctAnswerProvider.checkResult(text);
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
