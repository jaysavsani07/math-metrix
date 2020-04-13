import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/calculatorProvider.dart';
import 'package:mathgame/src/provider/signProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/ui/calculator/calculator_button.dart';
import 'package:mathgame/src/ui/timer.dart';
import 'package:mathgame/src/ui/whatsTheSign/sign_button.dart';
import 'package:provider/provider.dart';

class WhatsTheSign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignProvider>(
      create: (_) => SignProvider(),
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(50),
          constraints: BoxConstraints.expand(),
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Timer(GameCategoryType.SIGN),
                    ),
                  )),
              Consumer<SignProvider>(builder: (context, signProvider, child) {
                return Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              signProvider.currentState.firstDigit,
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                              heightFactor: 1,
                              child: Text(
                                signProvider.result,
                                style: TextStyle(fontSize: 35),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              signProvider.currentState.secondDigit,
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              "=",
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              signProvider.currentState.answer,
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                        ),
                      ],
                    ));
              }),
              Expanded(
                flex: 5,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          SignButton("+", 1),
                          SignButton("*", 1),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          SignButton("-", 1),
                          SignButton("/", 1),
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
