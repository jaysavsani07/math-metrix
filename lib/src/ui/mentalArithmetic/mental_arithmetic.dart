import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/mentalArithmeticProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/ui/calculator/calculator_button.dart';
import 'package:mathgame/src/ui/timer.dart';
import 'package:provider/provider.dart';

import 'mental_arithmetic_button.dart';

class MentalArithmetic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MentalArithmeticProvider>(
      create: (_) => MentalArithmeticProvider(),
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          body: SafeArea(
            bottom: true,
            top: true,
            child: Container(
              margin: EdgeInsets.all(20),
              constraints: BoxConstraints.expand(),
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Timer(GameCategoryType.MENTAL_ARITHMETIC),
                        ),
                      )),
                  Consumer<MentalArithmeticProvider>(
                      builder: (context, provider, child) {
                    return Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            provider.currentState.currentQuestion,
                            style: TextStyle(fontSize: 35),
                          ),
                        ));
                  }),
                  Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Colors.grey),
                        ),
                        margin: EdgeInsets.fromLTRB(5, 10, 5, 20),
                        constraints: BoxConstraints.expand(),
                        child: Center(
                          child: Consumer<MentalArithmeticProvider>(
                            builder: (context, provider, child) {
                              return provider.timeOut
                                  ? RaisedButton(
                                      child: Text("Over"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  : Text(
                                      provider.result,
                                      style: TextStyle(
                                          fontSize: 45,
                                          fontWeight: FontWeight.w700),
                                    );
                            },
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 5,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 600,
                        width: 400,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    MentalArithmeticButton(
                                        "7",
                                        BorderRadius.only(
                                            topLeft: Radius.circular(40))),
                                    MentalArithmeticButton(
                                        "8", BorderRadius.all(Radius.zero)),
                                    MentalArithmeticButton(
                                        "9",
                                        BorderRadius.only(
                                            topRight: Radius.circular(40)))
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    MentalArithmeticButton(
                                        "4", BorderRadius.all(Radius.zero)),
                                    MentalArithmeticButton(
                                        "5", BorderRadius.all(Radius.zero)),
                                    MentalArithmeticButton(
                                        "6", BorderRadius.all(Radius.zero))
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    MentalArithmeticButton(
                                        "1", BorderRadius.all(Radius.zero)),
                                    MentalArithmeticButton(
                                        "2", BorderRadius.all(Radius.zero)),
                                    MentalArithmeticButton(
                                        "3", BorderRadius.all(Radius.zero))
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    MentalArithmeticButton(
                                        "0",
                                        BorderRadius.only(
                                            bottomLeft: Radius.circular(40))),
                                    MentalArithmeticButton(
                                        "-",
                                        BorderRadius.only(
                                            bottomLeft: Radius.zero)),
                                    MentalArithmeticButton(
                                        "CLEAR",
                                        BorderRadius.only(
                                            bottomRight: Radius.circular(40)))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Consumer<MentalArithmeticProvider>(
                          builder: (context, provider, child) {
                        return InkWell(
                          onTap: () {
                            provider.pauseTimer();
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            child: Center(
                              child: Icon(
                                provider.pause
                                    ? Icons.play_arrow
                                    : Icons.pause,
                                size: 40,
                              ),
                            ),
                          ),
                        );
                      })),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
