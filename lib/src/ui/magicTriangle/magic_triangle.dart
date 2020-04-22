import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/MagicTriangleProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_button.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_input_button.dart';
import 'package:mathgame/src/ui/magicTriangle/TrianglePainter.dart';
import 'package:mathgame/src/ui/timer.dart';
import 'package:mathgame/src/utility/sizeConfig.dart';
import 'package:provider/provider.dart';

class MagicTriangle extends StatelessWidget {
  final double padding = 20;
  final double radius = 40;
  double triangleHeight;

  @override
  Widget build(BuildContext context) {
    var sizeConfig = SizeConfig().init(context);
    print("device width factor ${SizeConfig.heightWidthFactor}");
    triangleHeight = (MediaQuery.of(context).size.width) * 0.8660254;
    print("triangle height ${SizeConfig.screenHeight}");
    return ChangeNotifierProvider<MagicTriangleProvider>(
      create: (_) => MagicTriangleProvider(),
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(body: Consumer<MagicTriangleProvider>(
          builder: (context, magicTriangleProvider, child) {
            return SafeArea(
              top: true,
              bottom: true,
              child: Container(
                height: SizeConfig.screenHeight,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(children: <Widget>[
                  Container(
                      height: (SizeConfig.screenHeight * 0.08),
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Timer(GameCategoryType.MAGIC_TRIANGLE)),
                  Container(
                    height: (SizeConfig.screenHeight * 0.06),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            magicTriangleProvider.currentState.answer
                                .toString(),
                            style: Theme.of(context).textTheme.display1)
                      ],
                    ),
                  ),
                  Container(
                    height: (SizeConfig.screenHeight * 0.50),
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                CustomPaint(
                                  painter: TrianglePainter(
                                      Theme.of(context).primaryColor),
                                  size: Size(
                                      (MediaQuery.of(context).size.width),
                                      triangleHeight),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            top: padding,
                            left:
                                MediaQuery.of(context).size.width / 2 - radius,
                            child: TriangleInputButton(
                                magicTriangleProvider
                                    .currentState.listTriangle[0],
                                0),
                            height: (radius * 2),
                            width: (radius * 2),
                          ), // first
                          Positioned(
                            top: triangleHeight / 2 - (padding * 2),
                            left: (MediaQuery.of(context).size.width / 4) -
                                padding / 2,
                            child: TriangleInputButton(
                                magicTriangleProvider
                                    .currentState.listTriangle[1],
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
                                magicTriangleProvider
                                    .currentState.listTriangle[2],
                                2),
                            height: (radius * 2),
                            width: (radius * 2),
                          ), // third
                          Positioned(
                            top: triangleHeight - padding - radius * 2,
                            left: padding,
                            child: TriangleInputButton(
                                magicTriangleProvider
                                    .currentState.listTriangle[3],
                                3),
                            height: (radius * 2),
                            width: (radius * 2),
                          ), // fourth
                          Positioned(
                            top: triangleHeight - (radius * 3) + padding,
                            left:
                                MediaQuery.of(context).size.width / 2 - radius,
                            child: TriangleInputButton(
                                magicTriangleProvider
                                    .currentState.listTriangle[4],
                                4),
                            height: (radius * 2),
                            width: (radius * 2),
                          ), // fifth
                          Positioned(
                            top: triangleHeight - ((radius * 2 + padding)),
                            right: padding,
                            child: TriangleInputButton(
                                magicTriangleProvider
                                    .currentState.listTriangle[5],
                                5),
                            height: (radius * 2),
                            width: (radius * 2),
                          ), // last one
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: (SizeConfig.screenHeight * 0.22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            TriangleButton(
                                magicTriangleProvider.currentState.listGrid[0],
                                0),
                            TriangleButton(
                                magicTriangleProvider.currentState.listGrid[1],
                                1),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            TriangleButton(
                                magicTriangleProvider.currentState.listGrid[2],
                                2),
                            TriangleButton(
                                magicTriangleProvider.currentState.listGrid[3],
                                3),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            TriangleButton(
                                magicTriangleProvider.currentState.listGrid[4],
                                4),
                            TriangleButton(
                                magicTriangleProvider.currentState.listGrid[5],
                                5),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: (SizeConfig.screenHeight * 0.07),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Consumer<MagicTriangleProvider>(
                            builder: (context, provider, child) {
                          return IconButton(
                            icon: provider.pause
                                ? Icon(Icons.play_arrow)
                                : Icon(Icons.pause),
                            iconSize: 30,
                            onPressed: () {
                              provider.pauseTimer();
                            },
                          );
                        })
                      ],
                    ),
                  )
                ]),
              ),
            );
          },
        )),
      ),
    );
  }
}
