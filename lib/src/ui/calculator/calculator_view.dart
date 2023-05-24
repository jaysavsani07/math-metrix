import 'package:flutter/material.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/app/theme_provider.dart';
import 'package:mathgame/src/ui/calculator/calculator_provider.dart';
import 'package:mathgame/src/ui/common/common_back_button.dart';
import 'package:mathgame/src/ui/common/common_clear_button.dart';
import 'package:mathgame/src/ui/common/common_neumorphic_view.dart';
import 'package:mathgame/src/ui/common/common_number_button.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

class CalculatorView extends StatelessWidget {
  final Tuple2<Color, Color> colorTuple;

  const CalculatorView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<CalculatorProvider>(
            create: (context) => CalculatorProvider(
                  vsync: VsyncProvider.of(context),
                  difficultyType: context.read<ThemeProvider>().difficultyType,
                ))
      ],
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          appBar: CommonAppBar<CalculatorProvider>(colorTuple: colorTuple),
          body: SafeArea(
            bottom: true,
            child: DialogListener<CalculatorProvider>(
              gameCategoryType: GameCategoryType.CALCULATOR,
              child: Container(
                margin: EdgeInsets.only(top: 24, left: 24, right: 24),
                constraints: BoxConstraints.expand(),
                child: Column(
                  children: <Widget>[
                    CommonInfoTextView<CalculatorProvider>(
                        gameCategoryType: GameCategoryType.CALCULATOR),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Consumer<CalculatorProvider>(
                              builder: (context, calculatorProvider, child) {
                            return Text(
                              calculatorProvider.currentState.question,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontSize: 30),
                            );
                          }),
                        ],
                      ),
                    ),
                    Selector<CalculatorProvider, Tuple2<double, double>>(
                      selector: (p0, p1) =>
                          Tuple2(p1.currentScore, p1.oldScore),
                      builder: (context, tuple2, child) {
                        return CommonWrongAnswerAnimationView(
                          currentScore: tuple2.item1.toInt(),
                          oldScore: tuple2.item2.toInt(),
                          child: child!,
                        );
                      },
                      child: CommonNeumorphicView(
                        isLarge: true,
                        child: Selector<CalculatorProvider, String>(
                          selector: (p0, p1) => p1.result,
                          builder: (context, result, child) {
                            return Text(
                              result,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                  fontSize: 30,
                                  color: colorTuple.item1),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Expanded(
                      flex: 8,
                      child: LayoutBuilder(builder: (context, constraints) {
                        return GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: (constraints.maxWidth / 3) /
                                ((constraints.maxHeight - 24) / 4),
                          ),
                          padding: const EdgeInsets.only(bottom: 24),
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
                                  return CommonClearButton(
                                      text: "Clear",
                                      onTab: () {
                                        context
                                            .read<CalculatorProvider>()
                                            .clearResult();
                                      });
                                } else if (e == "Back") {
                                  return CommonBackButton(onTab: () {
                                    context
                                        .read<CalculatorProvider>()
                                        .backPress();
                                  });
                                } else {
                                  return CommonNumberButton(
                                    text: e,
                                    onTab: () {
                                      context
                                          .read<CalculatorProvider>()
                                          .checkResult(e);
                                    },
                                    colorTuple: colorTuple,
                                  );
                                }
                              },
                            )
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
