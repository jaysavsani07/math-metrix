import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mathgame/src/provider/MagicTriangleProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_button.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_input_button.dart';
import 'package:mathgame/src/ui/magicTriangle/TrianglePainter.dart';
import 'package:mathgame/src/ui/timer.dart';
import 'package:provider/provider.dart';

class MagicTriangle extends StatelessWidget {
  double padding = 20;
  double radius = 40;
  double triangleHeight;
  Size size;
  int flex;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: false);
    triangleHeight = ScreenUtil().setWidth(360) * 0.8660254;
    size = MediaQuery.of(context).size;
    radius = ScreenUtil().setWidth(360 / 10);
    padding = ScreenUtil().setWidth(360 / 20);

    return ChangeNotifierProvider<MagicTriangleProvider>(
      create: (_) => MagicTriangleProvider(),
      child: WillPopScope(
        onWillPop: () => Future.value(true),
        child: Scaffold(body: Consumer<MagicTriangleProvider>(
          builder: (context, magicTriangleProvider, child) {
            return SafeArea(
              top: false,
              bottom: false,
              child: Column(children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(360),
                  height: ScreenUtil().setHeight(112),
                  child: Column(
                    children: <Widget>[
                      Container(child: Timer(GameCategoryType.MAGIC_TRIANGLE)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              magicTriangleProvider.pauseTimer();
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              child: Center(
                                child: Icon(
                                  magicTriangleProvider.pause
                                      ? Icons.play_arrow
                                      : Icons.pause,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          Text(
                              magicTriangleProvider.currentState.answer
                                  .toString(),
                              style: Theme.of(context).textTheme.display2)
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(360),
                  height: ScreenUtil().setHeight(360),
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: CustomPaint(
                            painter: TrianglePainter(
                                Theme.of(context).primaryColor,
                                radius,
                                padding),
                            size: Size((MediaQuery.of(context).size.width),
                                triangleHeight),
                          ),
                        ),
                        Positioned(
                          top: padding,
                          left: MediaQuery.of(context).size.width / 2 - radius,
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
                          left: MediaQuery.of(context).size.width / 2 - radius,
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
                  width: ScreenUtil().setWidth(360),
                  height: ScreenUtil().setHeight(168),
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Row(
                          children: <Widget>[
                            TriangleButton(
                                magicTriangleProvider.currentState.listGrid[0],
                                0,
                                radius),
                            TriangleButton(
                                magicTriangleProvider.currentState.listGrid[1],
                                1,
                                radius),
                            TriangleButton(
                                magicTriangleProvider.currentState.listGrid[2],
                                2,
                                radius),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TriangleButton(
                                magicTriangleProvider.currentState.listGrid[3],
                                3,
                                radius),
                            TriangleButton(
                                magicTriangleProvider.currentState.listGrid[4],
                                4,
                                radius),
                            TriangleButton(
                                magicTriangleProvider.currentState.listGrid[5],
                                5,
                                radius),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            );
          },
        )),
      ),
    );
  }
}
