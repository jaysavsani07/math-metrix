import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/calculatorProvider.dart';
import 'package:mathgame/src/ui/calculatorButton.dart';
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
              Expanded(flex: 1, child: SizedBox()),
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
                      child: Text(
                        "",
                        style: TextStyle(
                            fontSize: 45, fontWeight: FontWeight.w700),
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
                          CalculatorButton("1", 1),
                          CalculatorButton("4", 1),
                          CalculatorButton("7", 1),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          CalculatorButton("2", 1),
                          CalculatorButton("5", 1),
                          CalculatorButton("8", 1),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          CalculatorButton("3", 1),
                          CalculatorButton("6", 1),
                          CalculatorButton("9", 1),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          CalculatorButton("Clear", 1),
                          CalculatorButton("0", 1),
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
