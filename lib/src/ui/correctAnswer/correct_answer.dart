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
                            style: Theme.of(context).textTheme.headline,
                          ),
                        )),
                    Expanded(
                      flex: 5,
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 300,
                          width: 500,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      CorrectAnswerButton(
                                          correctAnswerProvider
                                              .currentState.firstAns,
                                          BorderRadius.only(
                                              topLeft: Radius.circular(40)
                                          )),
                                      CorrectAnswerButton(
                                          correctAnswerProvider.currentState.secondAns,
                                          BorderRadius.only(
                                              topRight: Radius.circular(40)
                                          ))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      CorrectAnswerButton(
                                          correctAnswerProvider
                                              .currentState.thirdAns,
                                          BorderRadius.only(
                                              bottomLeft: Radius.circular(40)
                                          )),
                                      CorrectAnswerButton(
                                          correctAnswerProvider.currentState.fourthAns,
                                          BorderRadius.only(
                                              bottomRight: Radius.circular(40)
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
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
