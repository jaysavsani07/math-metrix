import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/correctAnswerProvider.dart';
import 'package:provider/provider.dart';

class CorrectAnswerButton extends StatelessWidget {
  final String text;
  final BorderRadius borderRadius;

  CorrectAnswerButton(this.text, this.borderRadius);

  @override
  Widget build(BuildContext context) {
    final correctAnswerProvider = Provider.of<CorrectAnswerProvider>(context);
    return Expanded(
      flex: 1,
      child: InkWell(
        highlightColor: Theme.of(context).highlightColor,
        splashColor: Theme.of(context).splashColor,
        onTap: () {
          correctAnswerProvider.checkResult(text);
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
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),
    );
    ;
  }
}
