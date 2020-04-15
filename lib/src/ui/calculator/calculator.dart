import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/calculatorProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/ui/calculator/calculator_button.dart';
import 'package:mathgame/src/ui/timer.dart';
import 'package:provider/provider.dart';

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalculatorProvider>(
      create: (_) => CalculatorProvider(),
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
                      child: Timer(GameCategoryType.CALCULATOR),
                    ),
                  )),
              Consumer<CalculatorProvider>(
                  builder: (context, calculatorProvider, child) {
                return Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        calculatorProvider.currentState.question,
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
                      child: Consumer<CalculatorProvider>(
                        builder: (context, calculatorProvider, child) {
                          return calculatorProvider.timeOut
                              ? RaisedButton(
                                  child: Text("Over"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              : Text(
                                  calculatorProvider.result,
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
                                CalculatorButton(
                                    "7",
                                    BorderRadius.only(
                                        topLeft: Radius.circular(40))),
                                CalculatorButton(
                                    "8", BorderRadius.all(Radius.zero)),
                                CalculatorButton(
                                    "9",
                                    BorderRadius.only(
                                        topRight: Radius.circular(40)))
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                CalculatorButton(
                                    "4", BorderRadius.all(Radius.zero)),
                                CalculatorButton(
                                    "5", BorderRadius.all(Radius.zero)),
                                CalculatorButton(
                                    "6", BorderRadius.all(Radius.zero))
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                CalculatorButton(
                                    "1", BorderRadius.all(Radius.zero)),
                                CalculatorButton(
                                    "2", BorderRadius.all(Radius.zero)),
                                CalculatorButton(
                                    "3", BorderRadius.all(Radius.zero))
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                CalculatorButton(
                                    "0",
                                    BorderRadius.only(
                                        bottomLeft: Radius.circular(40))),
                                CalculatorButton(
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
              Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
