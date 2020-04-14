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
      child: Scaffold(
        body: Container(
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
                    flex: 2,
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
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          MentalArithmeticButton("1", 1),
                          MentalArithmeticButton("4", 1),
                          MentalArithmeticButton("7", 1),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          MentalArithmeticButton("2", 1),
                          MentalArithmeticButton("5", 1),
                          MentalArithmeticButton("8", 1),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          MentalArithmeticButton("3", 1),
                          MentalArithmeticButton("6", 1),
                          MentalArithmeticButton("9", 1),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          MentalArithmeticButton("-", 1),
                          MentalArithmeticButton("0", 1),
                          MentalArithmeticButton("CE", 1),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
