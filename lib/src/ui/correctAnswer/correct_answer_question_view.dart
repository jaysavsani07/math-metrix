import 'package:flutter/material.dart';
import 'package:mathgame/src/data/models/correct_answer.dart';

class CorrectAnswerQuestionView extends StatelessWidget {
  final Question question;
  final Widget questionView;

  const CorrectAnswerQuestionView({
    Key? key,
    required this.question,
    required this.questionView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        question.firstOperand.isQuestionMark
            ? questionView
            : Text(
                question.firstOperand.value,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 30),
              ),
        SizedBox(width: 14),
        Text(
          question.firstOperator,
          style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 30),
        ),
        SizedBox(width: 14),
        question.secondOperand.isQuestionMark
            ? questionView
            : Text(
          question.secondOperand.value,
          style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 30),
        ),
        if (question.secondOperator != null)
          Row(
            children: [
              SizedBox(width: 14),
              Text(
                question.secondOperator!,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 30),
              ),
              SizedBox(width: 14),
              question.thirdOperand!.isQuestionMark
                  ? questionView
                  :
              Text(
                question.thirdOperand!.value,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 30),
              ),
            ],
          ),
        SizedBox(width: 6),
        Text(
          "=",
          style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 30),
        ),
        SizedBox(width: 6),
        Text(
          question.answer.toString(),
          style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 30),
        ),
      ],
    );
  }
}
