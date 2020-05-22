import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/picturePuzzleProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/ui/picturePuzzle/picture_puzzle_shape_button.dart';
import 'package:mathgame/src/ui/picturePuzzle/picture_puzzle_answer_button.dart';
import 'package:mathgame/src/ui/timer.dart';
import 'package:provider/provider.dart';

class PicturePuzzle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PicturePuzzleProvider>(
      create: (_) => PicturePuzzleProvider(),
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
                  Expanded(
                      flex: 10,
                      child: SizedBox(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Timer(GameCategoryType.PICTURE_PUZZLE),
                        ),
                      )),
                  Expanded(
                    flex: 40,
                    child: Consumer<PicturePuzzleProvider>(
                        builder: (context, provider, child) {
                      return Visibility(
                        visible: !provider.pause,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: provider.currentState.list.map((list) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: list.shapeList.map((subList) {
                                  return PicturePuzzleShapeButton(subList);
                                }).toList(),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }),
                  ),
                  Expanded(
                    flex: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: Theme.of(context).accentColor),
                            ),
                            margin: EdgeInsets.fromLTRB(50, 5, 50, 10),
                            constraints: BoxConstraints.expand(),
                            child: Center(
                              child: Consumer<PicturePuzzleProvider>(
                                builder: (context, provider, child) {
                                  return Text(
                                    provider.result,
                                    style: Theme.of(context).textTheme.display1,
                                  );
                                },
                              ),
                            ),
                          )),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                PicturePuzzleAnswerButton(
                                    "5",
                                    BorderRadius.only(
                                        topLeft: Radius.circular(40))),
                                PicturePuzzleAnswerButton(
                                    "6", BorderRadius.all(Radius.zero)),
                                PicturePuzzleAnswerButton(
                                    "7", BorderRadius.all(Radius.zero)),
                                PicturePuzzleAnswerButton(
                                    "8", BorderRadius.all(Radius.zero)),
                                PicturePuzzleAnswerButton(
                                    "9",
                                    BorderRadius.only(
                                        topRight: Radius.circular(40)))
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                PicturePuzzleAnswerButton(
                                    "0", BorderRadius.all(Radius.zero)),
                                PicturePuzzleAnswerButton(
                                    "1", BorderRadius.all(Radius.zero)),
                                PicturePuzzleAnswerButton(
                                    "2", BorderRadius.all(Radius.zero)),
                                PicturePuzzleAnswerButton(
                                    "3", BorderRadius.all(Radius.zero)),
                                PicturePuzzleAnswerButton(
                                    "4", BorderRadius.all(Radius.zero)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                PicturePuzzleAnswerButton(
                                    "CLEAR",
                                    BorderRadius.only(
                                        bottomLeft: Radius.circular(40),
                                        bottomRight: Radius.circular(40))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Consumer<PicturePuzzleProvider>(
                              builder: (context, provider, child) {
                            return IconButton(
                              icon: provider.pause
                                  ? Icon(Icons.play_arrow)
                                  : Icon(Icons.pause),
                              iconSize: 40,
                              onPressed: () {
                                provider.pauseGame();
                              },
                            );
                          }),
                          Consumer<PicturePuzzleProvider>(
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
