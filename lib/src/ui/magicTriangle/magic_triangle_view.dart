import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/magicTriangle/magic_triangle_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_3x3.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_4x4.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_input_3x3.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_input_4x4.dart';
import 'package:mathgame/src/ui/magicTriangle/triangle_painter.dart';
import 'package:provider/provider.dart';
import 'package:vsync_provider/vsync_provider.dart';

class MagicTriangleView extends StatelessWidget {
  final double padding = 0;
  final double radius = 30;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<MagicTriangleProvider>(
            create: (context) =>
                MagicTriangleProvider(vsync: VsyncProvider.of(context)))
      ],
      child: SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          appBar: CommonAppBar<MagicTriangleProvider>(),
          body: DialogListener<MagicTriangleProvider>(
            gameCategoryType: GameCategoryType.MAGIC_TRIANGLE,
            child: Container(
              margin: EdgeInsets.all(24),
              constraints: BoxConstraints.expand(),
              child: Column(
                children: <Widget>[
                  CommonInfoTextView<MagicTriangleProvider>(
                      gameCategoryType: GameCategoryType.MAGIC_TRIANGLE),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Selector<MagicTriangleProvider, int>(
                          selector: (p0, p1) => p1.currentState.answer,
                          builder: (context, answer, child) {
                            return Text(
                              answer.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(fontSize: 30),
                            );
                          }),
                    ],
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          CustomPaint(
                            painter: TrianglePainter(
                              color: Colors.white,
                              radius: radius,
                              padding: padding,
                            ),
                            size: Size(
                              constraints.maxWidth,
                              constraints.maxWidth,
                            ),
                          ),
                          Selector<MagicTriangleProvider, bool>(
                              selector: (p0, p1) => p1.currentState.is3x3,
                              builder: (context, is3x3, child) {
                                return is3x3
                                    ? Triangle3x3(
                                        radius: radius,
                                        padding: padding,
                                        triangleHeight: constraints.maxWidth,
                                        triangleWidth: constraints.maxWidth,
                                      )
                                    : Triangle4x4(
                                        radius: radius,
                                        padding: padding,
                                        triangleHeight: constraints.maxWidth,
                                        triangleWidth: constraints.maxWidth,
                                      );
                              }),
                        ],
                      );
                    }),
                  ),
                  Selector<MagicTriangleProvider, bool>(
                      selector: (p0, p1) => p1.currentState.is3x3,
                      builder: (context, is3x3, child) {
                        return is3x3 ? TriangleInput3x3() : TriangleInput4x4();
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
