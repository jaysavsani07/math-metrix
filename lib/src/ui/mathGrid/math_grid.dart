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
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: Timer(GameCategoryType.MATH_MACHINE),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Consumer<MathGridProvider>(builder: (context, provider, child) {
                      return InkWell(
                        onTap: () {
                          provider.pauseTimer();
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: Center(
                            child: Icon(
                              provider.pause ? Icons.play_arrow : Icons.pause,
                              size: 40,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              mathGridProvider.currentState.currentAnswer
                                  .toString(),
                              style: TextStyle(fontSize: 40))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Center(
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
                  )
                ],
              ),
            );
          },
        )),
      ),
    );
  }
}
