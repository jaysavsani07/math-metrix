import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/numberPyramidProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/ui/timer.dart';
import 'package:mathgame/src/utility/sizeConfig.dart';
import 'package:provider/provider.dart';

import 'number_pyramid_box.dart';
import 'number_pyramid_button.dart';

class NumberPyramid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider<NumberPyramidProvider>(
      create: (_) => NumberPyramidProvider(),
      child: Scaffold(
          body: SafeArea(
        top: true,
        bottom: true,
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          constraints: BoxConstraints.expand(),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 10,
                child: Timer(GameCategoryType.NUMBER_PYRAMID),
                /*child: Timer(GameCategoryType.NUMBER_PYRAMID)*/
              ),
              Expanded(
                flex: 40,
                child: Consumer<NumberPyramidProvider>(
                    builder: (context, numberPyramidProvider, child) {
                  return Visibility(
                    visible: !numberPyramidProvider.pause,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            PyramidNumberBox("",
                                numberPyramidProvider.currentState.list[27]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            PyramidNumberBox("",
                                numberPyramidProvider.currentState.list[26]),
                            PyramidNumberBox(
                                "", numberPyramidProvider.currentState.list[25])
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            PyramidNumberBox("",
                                numberPyramidProvider.currentState.list[24]),
                            PyramidNumberBox("",
                                numberPyramidProvider.currentState.list[23]),
                            PyramidNumberBox("",
                                numberPyramidProvider.currentState.list[22]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            PyramidNumberBox("",
                                numberPyramidProvider.currentState.list[21]),
                            PyramidNumberBox("",
                                numberPyramidProvider.currentState.list[20]),
                            PyramidNumberBox("",
                                numberPyramidProvider.currentState.list[19]),
                            PyramidNumberBox("",
                                numberPyramidProvider.currentState.list[18]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            PyramidNumberBox("",
                                numberPyramidProvider.currentState.list[17]),
                            PyramidNumberBox("",
                                numberPyramidProvider.currentState.list[16]),
                            PyramidNumberBox("",
                                numberPyramidProvider.currentState.list[15]),
                            PyramidNumberBox("",
                                numberPyramidProvider.currentState.list[14]),
                            PyramidNumberBox("",
                                numberPyramidProvider.currentState.list[13]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            PyramidNumberBox("",
                                numberPyramidProvider.currentState.list[12]),
                            PyramidNumberBox("",
                                numberPyramidProvider.currentState.list[11]),
                            PyramidNumberBox("",
                                numberPyramidProvider.currentState.list[10]),
                            PyramidNumberBox(
                                "", numberPyramidProvider.currentState.list[9]),
                            PyramidNumberBox(
                                "", numberPyramidProvider.currentState.list[8]),
                            PyramidNumberBox(
                                "", numberPyramidProvider.currentState.list[7]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            PyramidNumberBox(
                                "", numberPyramidProvider.currentState.list[6]),
                            PyramidNumberBox(
                                "", numberPyramidProvider.currentState.list[5]),
                            PyramidNumberBox(
                                "", numberPyramidProvider.currentState.list[4]),
                            PyramidNumberBox(
                                "", numberPyramidProvider.currentState.list[3]),
                            PyramidNumberBox(
                                "", numberPyramidProvider.currentState.list[2]),
                            PyramidNumberBox(
                                "", numberPyramidProvider.currentState.list[1]),
                            PyramidNumberBox(
                                "", numberPyramidProvider.currentState.list[0]),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
              Expanded(
                flex: 40,
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 300,
                    width: 300,
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
                                PyramidNumberButton(
                                    "7",
                                    BorderRadius.only(
                                        topLeft: Radius.circular(40))),
                                PyramidNumberButton(
                                    "8", BorderRadius.all(Radius.zero)),
                                PyramidNumberButton(
                                    "9",
                                    BorderRadius.only(
                                        topRight: Radius.circular(40)))
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                PyramidNumberButton(
                                    "4", BorderRadius.all(Radius.zero)),
                                PyramidNumberButton(
                                    "5", BorderRadius.all(Radius.zero)),
                                PyramidNumberButton(
                                    "6", BorderRadius.all(Radius.zero))
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                PyramidNumberButton(
                                    "1", BorderRadius.all(Radius.zero)),
                                PyramidNumberButton(
                                    "2", BorderRadius.all(Radius.zero)),
                                PyramidNumberButton(
                                    "3", BorderRadius.all(Radius.zero))
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                PyramidNumberButton(
                                    "DONE",
                                    BorderRadius.only(
                                        bottomLeft: Radius.circular(40))),
                                PyramidNumberButton(
                                    "0", BorderRadius.all(Radius.zero)),
                                PyramidNumberButton(
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
                      Consumer<NumberPyramidProvider>(
                          builder: (context, numberPyramidProvider, child) {
                        return IconButton(
                          icon: numberPyramidProvider.pause
                              ? Icon(Icons.play_arrow)
                              : Icon(Icons.pause),
                          iconSize: 40,
                          onPressed: () {
                            numberPyramidProvider.pauseTimer();
                          },
                        );
                      }),
                      Consumer<NumberPyramidProvider>(
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
      )),
    );
  }
}
