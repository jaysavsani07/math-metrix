import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/signProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
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
                              style: Theme.of(context).textTheme.headline,
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
                                  BorderRadius.all(Radius.circular(3)),
                              border: Border.all(color: Theme.of(context).primaryColor, width: 2),
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
                              style: Theme.of(context).textTheme.headline,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              "=",
                              style: Theme.of(context).textTheme.headline,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              signProvider.currentState.answer,
                              style: Theme.of(context).textTheme.headline,
                            ),
                          ),
                        ),
                      ],
                    ));
              }),
              Expanded(
                flex: 5,
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 300,
                    width: 500,
                    child: Container(
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
                                SignButton("+", BorderRadius.only(
                                    topLeft: Radius.circular(40)
                                )),
                                SignButton("-", BorderRadius.only(
                                    topRight: Radius.circular(40)
                                ))
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                SignButton("*", BorderRadius.only(
                                    bottomLeft: Radius.circular(40)
                                )),
                                SignButton("/", BorderRadius.only(
                                    bottomRight: Radius.circular(40)
                                ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(flex: 1, child:Consumer<SignProvider>(
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
    );
  }
}
