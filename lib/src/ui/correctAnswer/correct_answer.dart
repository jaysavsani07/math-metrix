import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/correctAnswerProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/ui/timer.dart';
import 'package:provider/provider.dart';

import 'correct_answer_button.dart';

class CorrectAnswer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CorrectAnswerProvider>(
      create: (_) => CorrectAnswerProvider(),
      child: Scaffold(
        body: Container(
            margin: EdgeInsets.all(50),
            constraints: BoxConstraints.expand(),
            child: Consumer<CorrectAnswerProvider>(
              builder: (context, correctAnswerProvider, child) {
                return Column(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Timer(GameCategoryType.CORRECT_ANSWER),
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            correctAnswerProvider.currentState.question,
                            style: TextStyle(fontSize: 35),
                          ),
                        )),
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                CorrectAnswerButton(
                                    correctAnswerProvider.currentState.firstAns,
                                    1),
                                CorrectAnswerButton(
                                    correctAnswerProvider
                                        .currentState.secondAns,
                                    1),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                CorrectAnswerButton(
                                    correctAnswerProvider.currentState.thirdAns,
                                    1),
                                CorrectAnswerButton(
                                    correctAnswerProvider
                                        .currentState.fourthAns,
                                    1),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(flex: 1, child: SizedBox()),
                  ],
                );
              },
            )),
      ),
    );
  }
}
