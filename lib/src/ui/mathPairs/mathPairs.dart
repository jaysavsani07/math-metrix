import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/mathPairsProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/ui/mathPairs/math_pairs_button.dart';
import 'package:mathgame/src/ui/timer.dart';
import 'package:provider/provider.dart';

class MathPairs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MathPairsProvider>(
      create: (_) => MathPairsProvider(),
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          body: SafeArea(
            top: true,
            bottom: true,
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              constraints: BoxConstraints.expand(),
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 10,
                      child: SizedBox(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Timer(GameCategoryType.MATH_PAIRS),
                        ),
                      )),
                  Expanded(
                    flex: 10,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 60,
                    child: Consumer<MathPairsProvider>(
                        builder: (context, mathPairsProvider, child) {
                      return Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                MathPairsButton(
                                    mathPairsProvider.currentState.list[0],
                                    1,
                                    0),
                                MathPairsButton(
                                    mathPairsProvider.currentState.list[1],
                                    1,
                                    1),
                                MathPairsButton(
                                    mathPairsProvider.currentState.list[2],
                                    1,
                                    2),
                                MathPairsButton(
                                    mathPairsProvider.currentState.list[3],
                                    1,
                                    3),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                MathPairsButton(
                                    mathPairsProvider.currentState.list[4],
                                    1,
                                    4),
                                MathPairsButton(
                                    mathPairsProvider.currentState.list[5],
                                    1,
                                    5),
                                MathPairsButton(
                                    mathPairsProvider.currentState.list[6],
                                    1,
                                    6),
                                MathPairsButton(
                                    mathPairsProvider.currentState.list[7],
                                    1,
                                    7),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                MathPairsButton(
                                    mathPairsProvider.currentState.list[8],
                                    1,
                                    8),
                                MathPairsButton(
                                    mathPairsProvider.currentState.list[9],
                                    1,
                                    9),
                                MathPairsButton(
                                    mathPairsProvider.currentState.list[10],
                                    1,
                                    10),
                                MathPairsButton(
                                    mathPairsProvider.currentState.list[11],
                                    1,
                                    11),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(),
                  ),
                  Expanded(
                      flex: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Consumer<MathPairsProvider>(
                              builder: (context, provider, child) {
                            return IconButton(
                              icon: provider.pause
                                  ? Icon(Icons.play_arrow)
                                  : Icon(Icons.pause),
                              iconSize: 40,
                              onPressed: () {
                                provider.pauseTimer();
                              },
                            );
                          }),
                          Consumer<MathPairsProvider>(
                              builder: (context, provider, child) {
                            return IconButton(
                              icon: Icon(Icons.info_outline),
                              iconSize: 40,
                              onPressed: () {
                                provider.showInfoDialog();
                              },
                            );
                          })
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
