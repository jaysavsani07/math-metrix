import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/MagicTriangleProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/ui/calculator/triangle_button.dart';
import 'package:mathgame/src/ui/calculator/triangle_input_button.dart';
import 'package:mathgame/src/ui/magicTriangle/TrianglePainter.dart';
import 'package:mathgame/src/ui/timer.dart';
import 'package:provider/provider.dart';

class MagicTriangle extends StatelessWidget {
  final double padding = 20;
  final double radius = 40;
  double triangleHeight;

  @override
  Widget build(BuildContext context) {
    triangleHeight = (MediaQuery.of(context).size.width) * 0.8660254;
    return ChangeNotifierProvider<MagicTriangleProvider>(
      create: (_) => MagicTriangleProvider(),
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(body: Consumer<MagicTriangleProvider>(
          builder: (context, magicTriangleProvider, child) {
            return SafeArea(
              top: true,
              bottom: true,
              child: Column(children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.all(20),
                      child: Timer(GameCategoryType.MAGIC_TRIANGLE)),
                ),
                /*Consumer<MagicTriangleProvider>(
                    builder: (context, provider, child) {
                  return InkWell(
                    onTap: () {
                      provider.pauseTimer();
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: Center(
                        child: Icon(
                          provider.pause ? Icons.play_arrow : Icons.pause,
                          size: 40,
                        ),
                      ),
                    ),
                  );
                })*/
                Expanded(
                  flex: 1,
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            magicTriangleProvider.currentState.answer
                                .toString(),
                            style: Theme.of(context).textTheme.display2)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Container(
                              child: Row(
                            children: <Widget>[
                              CustomPaint(
                                painter: TrianglePainter(
                                    Theme.of(context).primaryColor),
                                size: Size((MediaQuery.of(context).size.width),
                                    triangleHeight),
                              )
                            ],
                          )),
                        ),
                        Positioned(
                          top: padding,
                          left: MediaQuery.of(context).size.width / 2 - radius,
                          child: TriangleInputButton(
                              magicTriangleProvider.currentState.listTriangle[0],
                              0),
                          height: (radius * 2),
                          width: (radius * 2),
                        ), // first
                        Positioned(
                          top: triangleHeight / 2 - (padding * 2),
                          left: (MediaQuery.of(context).size.width / 4) -
                              padding / 2,
                          child: TriangleInputButton(
                              magicTriangleProvider.currentState.listTriangle[1],
                              1),
                          height: (radius * 2),
                          width: (radius * 2),
                        ), // second one
                        Positioned(
                          top: triangleHeight / 2 - (padding * 2),
                          left: (MediaQuery.of(context).size.width / 4 -
                                      (radius / 2)) *
                                  3 -
                              padding / 2,
                          child: TriangleInputButton(
                              magicTriangleProvider.currentState.listTriangle[2],
                              2),
                          height: (radius * 2),
                          width: (radius * 2),
                        ), // third
                        Positioned(
                          top: triangleHeight - padding - radius * 2,
                          left: padding,
                          child: TriangleInputButton(
                              magicTriangleProvider.currentState.listTriangle[3],
                              3),
                          height: (radius * 2),
                          width: (radius * 2),
                        ), // fourth
                        Positioned(
                          top: triangleHeight - (radius * 3) + padding,
                          left: MediaQuery.of(context).size.width / 2 - radius,
                          child: TriangleInputButton(
                              magicTriangleProvider.currentState.listTriangle[4],
                              4),
                          height: (radius * 2),
                          width: (radius * 2),
                        ), // fifth
                        Positioned(
                          top: triangleHeight - ((radius * 2 + padding)),
                          right: padding,
                          child: TriangleInputButton(
                              magicTriangleProvider.currentState.listTriangle[5],
                              5),
                          height: (radius * 2),
                          width: (radius * 2),
                        ), // last one
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              TriangleButton(
                                  magicTriangleProvider
                                      .currentState.listGrid[0],
                                  0),
                              TriangleButton(
                                  magicTriangleProvider
                                      .currentState.listGrid[1],
                                  1),
                              TriangleButton(
                                  magicTriangleProvider
                                      .currentState.listGrid[2],
                                  2),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TriangleButton(
                                  magicTriangleProvider
                                      .currentState.listGrid[3],
                                  3),
                              TriangleButton(
                                  magicTriangleProvider
                                      .currentState.listGrid[4],
                                  4),
                              TriangleButton(
                                  magicTriangleProvider
                                      .currentState.listGrid[5],
                                  5),
                            ],
                          )
                        ],
                      ),
                    )),
              ]),
            );
          },
        )),
      ),
    );
  }
}
