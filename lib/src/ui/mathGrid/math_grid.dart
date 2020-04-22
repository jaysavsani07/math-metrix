import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/MathGridProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/ui/mathGrid/square_button.dart';
import 'package:mathgame/src/ui/timer.dart';
import 'package:provider/provider.dart';

class MathGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MathGridProvider>(
      create: (_) => MathGridProvider(),
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(body: Consumer<MathGridProvider>(
          builder: (context, mathGridProvider, child) {
            return SafeArea(
              top: true,
              bottom: true,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Timer(GameCategoryType.MATH_MACHINE),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              mathGridProvider.currentState.currentAnswer
                                  .toString(),
                              style: Theme.of(context).textTheme.display1)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 55,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 9),
                        itemCount:
                            mathGridProvider.currentState.listForSquare.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SquareButton(
                              mathGridProvider
                                  .currentState.listForSquare[index].value,
                              mathGridProvider.currentState.listForSquare[index]);
                        }),
                  ),
                  Expanded(
                    flex: 10,
                    child: Consumer<MathGridProvider>(builder: (context, provider, child) {
                      return Container(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: provider.pause
                                    ? Icon(Icons.play_arrow)
                                    : Icon(Icons.pause),
                                iconSize: 40,
                                onPressed: () {
                                  provider.pauseTimer();
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        )),
      ),
    );
  }
}
