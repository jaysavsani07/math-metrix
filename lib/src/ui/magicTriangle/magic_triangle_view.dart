import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/magicTriangle/magic_triangle_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_3x3.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_4x4.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_input_3x3.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_input_4x4.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_painter.dart';
import 'package:mathgame/src/ui/common/timer.dart';
import 'package:mathgame/src/core/size_config.dart';
import 'package:provider/provider.dart';

class MagicTriangleView extends StatelessWidget {
  final double padding = 20;
  final double radius = 30;
  late double triangleHeight;

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
              child: Container(
                height: SizeConfig.screenHeight,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(children: <Widget>[
                  Container(
                      height: (SizeConfig.safeBlockVertical * 0.08),
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Timer(GameCategoryType.MAGIC_TRIANGLE)),
                  Container(
                    height: (SizeConfig.safeBlockVertical * 0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            magicTriangleProvider.currentState.answer
                                .toString(),
                            style: Theme.of(context).textTheme.headline2)
                      ],
                    ),
                  ),
                  Container(
                    height: (SizeConfig.safeBlockVertical * 0.50),
                    child: Center(
                      child: Container(
                        height: triangleHeight,
                        width: MediaQuery.of(context).size.width,
                        child: Visibility(
                          visible: !magicTriangleProvider.pause,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    CustomPaint(
                                      painter: TrianglePainter(
                                          Theme.of(context).primaryColor,
                                          radius,
                                          padding),
                                      size: Size(
                                          (MediaQuery.of(context).size.width),
                                          triangleHeight),
                                    )
                                  ],
                                ),
                              ),
                              magicTriangleProvider.currentState.is3x3
                                  ? Triangle3x3(radius, padding, triangleHeight)
                                  : Triangle4x4(radius, padding, triangleHeight)
                              // last one
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: (SizeConfig.safeBlockVertical * 0.22),
                    child: magicTriangleProvider.currentState.is3x3
                        ? TriangleInput3x3()
                        : TriangleInput4x4(),
                  ),
                  Container(
                    height: (SizeConfig.safeBlockVertical * 0.08),
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        }),
                        Consumer<MagicTriangleProvider>(
                            builder: (context, provider, child) {
                          return IconButton(
                            icon: Icon(Icons.info_outline),
                            iconSize: 30,
                            onPressed: () {
                              provider.showInfoDialog();
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
