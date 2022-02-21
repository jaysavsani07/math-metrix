import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/ui/calculator/calculator_provider.dart';
import 'package:mathgame/src/ui/common/CommonBackButton.dart';
import 'package:mathgame/src/ui/common/CommonClearButton.dart';
import 'package:mathgame/src/ui/common/CommonNumberButton.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:provider/provider.dart';
import 'package:vsync_provider/vsync_provider.dart';

class CalculatorView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<CalculatorProvider>(
            create: (context) =>
                CalculatorProvider(vsync: VsyncProvider.of(context)))
      ],
      child: SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          appBar: CommonAppBar<CalculatorProvider>(),
          body: DialogListener<CalculatorProvider>(
            gameCategoryType: GameCategoryType.CALCULATOR,
            child: Container(
              margin: EdgeInsets.all(24),
              constraints: BoxConstraints.expand(),
              child: Column(
                children: <Widget>[
                  CommonInfoTextView<CalculatorProvider>(
                      gameCategoryType: GameCategoryType.CALCULATOR),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<CalculatorProvider>(
                            builder: (context, calculatorProvider, child) {
                              return Text(
                                calculatorProvider.currentState.question,
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
                            width: double.infinity,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(10),
                            child: Consumer<CalculatorProvider>(
                              builder: (context, calculatorProvider, child) {
                                return Text(
                                  calculatorProvider.result,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                      fontSize: 30,
                                      color: Color(0xff4895EF)),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Builder(builder: (context) {
                    return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ...[
                          "7",
                          "8",
                          "9",
                          "4",
                          "5",
                          "6",
                          "1",
                          "2",
                          "3",
                          "Clear",
                          "0",
                          "Back"
                        ].map(
                              (e) {
                            if (e == "Clear") {
                              return CommonClearButton(onTab: () {
                                context
                                    .read<CalculatorProvider>()
                                    .clearResult();
                              });
                            } else if (e == "Back") {
                              return CommonBackButton(onTab: () {
                                context.read<CalculatorProvider>().backPress();
                              });
                            } else {
                              return CommonNumberButton(
                                text: e,
                                onTab: () {
                                  context
                                      .read<CalculatorProvider>()
                                      .checkResult(e);
                                },
                                startColor: Color(0xff4895EF),
                                endColor: Color(0xff3f37c9),
                              );
                            }
                          },
                        )
                      ],
                    );
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
