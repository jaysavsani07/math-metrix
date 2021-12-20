import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/calculator/calculator_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/calculator/calculator_button.dart';
import 'package:mathgame/src/ui/common/timer.dart';
import 'package:provider/provider.dart';

class CalculatorView extends StatefulWidget {
  @override
  _CalculatorViewState createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      print("hello hahu...");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalculatorProvider>(
      create: (_) => CalculatorProvider(),
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
                  Expanded(flex: 10, child: Timer(GameCategoryType.CALCULATOR)),
                  Expanded(
                      flex: 10,
                      child: Center(
                        child: Consumer<CalculatorProvider>(
                            builder: (context, calculatorProvider, child) {
                          return Visibility(
                            visible: !calculatorProvider.pause,
                            child: Text(
                              calculatorProvider.currentState.question,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          );
                        }),
                      )),
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
                          child: Consumer<CalculatorProvider>(
                            builder: (context, calculatorProvider, child) {
                              return Text(
                                calculatorProvider.result,
                                style: Theme.of(context).textTheme.headline1,
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
                  Expanded(
                      flex: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Consumer<CalculatorProvider>(
                              builder: (context, calculatorProvider, child) {
                            return IconButton(
                              icon: calculatorProvider.pause
                                  ? Icon(Icons.play_arrow)
                                  : Icon(Icons.pause),
                              iconSize: 40,
                              onPressed: () {
                                calculatorProvider.pauseGame();
                              },
                            );
                          }),
                          Consumer<CalculatorProvider>(
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
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
