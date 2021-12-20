import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/mentalArithmetic/mental_arithmetic_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/common/timer.dart';
import 'package:provider/provider.dart';

import 'mental_arithmetic_button.dart';

class MentalArithmeticView extends StatelessWidget {
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
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              constraints: BoxConstraints.expand(),
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 10,
                      child: Timer(GameCategoryType.MENTAL_ARITHMETIC)),
                  Consumer<MentalArithmeticProvider>(
                      builder: (context, provider, child) {
                    return Expanded(
                        flex: 10,
                        child: Center(
                          child: Text(
                            provider.currentState.currentQuestion,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ));
                  }),
                  Expanded(
                      flex: 15,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border:
                              Border.all(color: Theme.of(context).accentColor),
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
                    flex: 55,
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
                      flex: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Consumer<MentalArithmeticProvider>(
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
                          Consumer<MentalArithmeticProvider>(
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
