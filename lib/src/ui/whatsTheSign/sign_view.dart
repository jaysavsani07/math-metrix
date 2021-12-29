import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/whatsTheSign/sign_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/common/timer.dart';
import 'package:mathgame/src/ui/whatsTheSign/sign_button.dart';
import 'package:provider/provider.dart';

class SignView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignProvider>(
      create: (_) => SignProvider(),
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          body: SafeArea(
            top: true,
            bottom: true,
            child:
                Consumer<SignProvider>(builder: (context, signProvider, child) {
              return Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                constraints: BoxConstraints.expand(),
                child: Column(
                  children: <Widget>[
                    Expanded(flex: 10, child: Timer(GameCategoryType.SIGN)),
                    Expanded(
                        flex: 20,
                        child: Visibility(
                          visible: !signProvider.pause,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  signProvider.currentState.firstDigit,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 1),
                                ),
                                child: Container(
                                  width: 40,
                                  child: Center(
                                    heightFactor: 1,
                                    child: Text(
                                      signProvider.result,
                                      style: Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  signProvider.currentState.secondDigit,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                              Center(
                                child: Text(
                                  " = ",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                              Center(
                                child: Text(
                                  signProvider.currentState.answer,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 60,
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 300,
                          width: 500,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      SignButton(
                                          "+",
                                          BorderRadius.only(
                                              topLeft: Radius.circular(40))),
                                      SignButton(
                                          "-",
                                          BorderRadius.only(
                                              topRight: Radius.circular(40)))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      SignButton(
                                          "*",
                                          BorderRadius.only(
                                              bottomLeft: Radius.circular(40))),
                                      SignButton(
                                          "/",
                                          BorderRadius.only(
                                              bottomRight: Radius.circular(40)))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 10,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: signProvider.pause
                                    ? Icon(Icons.play_arrow)
                                    : Icon(Icons.pause),
                                iconSize: 40,
                                onPressed: () {
                                  signProvider.pauseGame();
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.info_outline),
                                iconSize: 40,
                                onPressed: () {
                                  signProvider.showInfoDialog();
                                },
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
