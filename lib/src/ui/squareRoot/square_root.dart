import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/signProvider.dart';
import 'package:mathgame/src/provider/squareRootProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/ui/squareRoot/square_root_button.dart';
import 'package:mathgame/src/ui/timer.dart';
import 'package:mathgame/src/ui/whatsTheSign/sign_button.dart';
import 'package:provider/provider.dart';

class SquareRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SquareRootProvider>(
      create: (_) => SquareRootProvider(),
      child: Scaffold(
        body: Container(
            margin: EdgeInsets.all(50),
            constraints: BoxConstraints.expand(),
            child: Consumer<SquareRootProvider>(
              builder: (context, squareRootProvider, child) {
                return Column(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Timer(GameCategoryType.SQUARE_ROOT),
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            squareRootProvider.currentState.question,
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
                                SquareRootButton(
                                    squareRootProvider.currentState.firstAns,
                                    1),
                                SquareRootButton(
                                    squareRootProvider.currentState.secondAns,
                                    1),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                SquareRootButton(
                                    squareRootProvider.currentState.thirdAns,
                                    1),
                                SquareRootButton(
                                    squareRootProvider.currentState.fourthAns,
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
