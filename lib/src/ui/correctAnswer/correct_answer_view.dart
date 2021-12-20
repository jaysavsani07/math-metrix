import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/correctAnswer/correct_answer_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/common/timer.dart';
import 'package:provider/provider.dart';

import 'correct_answer_button.dart';

class CorrectAnswerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CorrectAnswerProvider>(
      create: (_) => CorrectAnswerProvider(),
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          body: SafeArea(
            top: true,
            bottom: true,
            child: Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                constraints: BoxConstraints.expand(),
                child: Consumer<CorrectAnswerProvider>(
                  builder: (context, correctAnswerProvider, child) {
                    return Column(
                      children: <Widget>[
                        Expanded(
                            flex: 10,
                            child: SizedBox(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Timer(GameCategoryType.CORRECT_ANSWER),
                              ),
                            )),
                        Expanded(
                            flex: 20,
                            child: Center(
                              child: Visibility(
                                visible: !correctAnswerProvider.pause,
                                child: Text(
                                  correctAnswerProvider.currentState.question,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ),
                            )),
                        Expanded(
                          flex: 60,
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 300,
                              width: 500,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                                                  topLeft:
                                                      Radius.circular(40))),
                                          CorrectAnswerButton(
                                              correctAnswerProvider
                                                  .currentState.secondAns,
                                              BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(40)))
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
                                                  bottomLeft:
                                                      Radius.circular(40))),
                                          CorrectAnswerButton(
                                              correctAnswerProvider
                                                  .currentState.fourthAns,
                                              BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(40)))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 10,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: correctAnswerProvider.pause
                                        ? Icon(Icons.play_arrow)
                                        : Icon(Icons.pause),
                                    iconSize: 40,
                                    onPressed: () {
                                      correctAnswerProvider.pauseTimer();
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.info_outline),
                                    iconSize: 40,
                                    onPressed: () {
                                      correctAnswerProvider.showInfoDialog();
                                    },
                                  )
                                ],
                              ),
                            )),
                      ],
                    );
                  },
                )),
          ),
        ),
      ),
    );
  }
}
