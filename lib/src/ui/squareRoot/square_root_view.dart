import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/data/models/square_root.dart';
import 'package:mathgame/src/ui/common/CommonNumberButton.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/squareRoot/square_root_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:provider/provider.dart';
import 'package:vsync_provider/vsync_provider.dart';

class SquareRootView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<SquareRootProvider>(
            create: (context) =>
                SquareRootProvider(vsync: VsyncProvider.of(context)))
      ],
      child: SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          appBar: CommonAppBar<SquareRootProvider>(),
          body: DialogListener<SquareRootProvider>(
            gameCategoryType: GameCategoryType.SQUARE_ROOT,
            child: Container(
              margin: EdgeInsets.all(24),
              constraints: BoxConstraints.expand(),
              child: Column(
                children: <Widget>[
                  CommonInfoTextView<SquareRootProvider>(
                      gameCategoryType: GameCategoryType.SQUARE_ROOT),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Selector<SquareRootProvider, SquareRoot>(
                            selector: (p0, p1) => p1.currentState,
                            builder: (context, currentState, child) {
                              return Text(
                                currentState.question,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontSize: 30),
                              );
                            }),
                        SizedBox(height: 14),
                        Neumorphic(
                          style: NeumorphicStyle(
                            // shape: NeumorphicShape.convex,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(18)),
                            depth: -8,
                            lightSource: LightSource.topLeft,
                            color: Theme.of(context).colorScheme.iconBgColor,
                          ),
                          child: Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 5, top: 10),
                            child: Selector<SquareRootProvider, String>(
                              selector: (p0, p1) => p1.result,
                              builder: (context, calculatorProvider, child) {
                                return Text(
                                  calculatorProvider,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                      fontSize: 30, color: Color(0xff4895EF)),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Selector<SquareRootProvider, SquareRoot>(
                    selector: (p0, p1) => p1.currentState,
                    builder: (context, currentState, child) {
                      return GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ...[
                            currentState.firstAns,
                            currentState.secondAns,
                            currentState.thirdAns,
                            currentState.fourthAns,
                          ].map(
                            (e) {
                              return CommonNumberButton(
                                text: e,
                                onTab: () {
                                  context
                                      .read<SquareRootProvider>()
                                      .checkResult(e);
                                },
                                startColor: Color(0xff4895EF),
                                endColor: Color(0xff3f37c9),
                              );
                            },
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
