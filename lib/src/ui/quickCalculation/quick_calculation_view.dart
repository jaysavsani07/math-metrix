import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/data/models/quick_calculation.dart';
import 'package:mathgame/src/ui/common/CommonBackButton.dart';
import 'package:mathgame/src/ui/common/CommonClearButton.dart';
import 'package:mathgame/src/ui/common/CommonNumberButton.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/quickCalculation/quick_calculation_question_view.dart';
import 'package:mathgame/src/ui/quickCalculation/quick_calculation_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

class QuickCalculationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<QuickCalculationProvider>(
            create: (context) =>
                QuickCalculationProvider(vsync: VsyncProvider.of(context)))
      ],
      child: SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          appBar: CommonAppBar<QuickCalculationProvider>(),
          body: DialogListener<QuickCalculationProvider>(
            gameCategoryType: GameCategoryType.QUICK_CALCULATION,
            child: Container(
              margin: EdgeInsets.all(24),
              constraints: BoxConstraints.expand(),
              child: Column(
                children: <Widget>[
                  CommonInfoTextView<QuickCalculationProvider>(
                      gameCategoryType: GameCategoryType.QUICK_CALCULATION),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "NEXT",
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 10),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Selector<
                                  QuickCalculationProvider,
                                  Tuple3<QuickCalculation, QuickCalculation,
                                      QuickCalculation?>>(
                                selector: (p0, p1) => Tuple3(
                                    p1.currentState,
                                    p1.nextCurrentState,
                                    p1.previousCurrentState),
                                builder: (context, tuple3, child) {
                                  return QuickCalculationQuestionView(
                                    currentState: tuple3.item1,
                                    nextCurrentState: tuple3.item2,
                                    previousCurrentState: tuple3.item3,
                                  );
                                },
                              ),
                            ),
                            Text(
                              " = ",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Neumorphic(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              style: NeumorphicStyle(
                                // shape: NeumorphicShape.convex,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(18)),
                                depth: -8,
                                lightSource: LightSource.topLeft,
                                color:
                                    Theme.of(context).colorScheme.iconBgColor,
                              ),
                              child: Container(
                                width: 40,
                                height: 40,
                                alignment: Alignment.center,
                                child:
                                    Selector<QuickCalculationProvider, String>(
                                  selector: (p0, p1) => p1.result,
                                  builder: (context, result, child) {
                                    return Text(result,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                                fontSize: 24,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .crossColor));
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 60),
                          ],
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
                                    .read<QuickCalculationProvider>()
                                    .clearResult();
                              });
                            } else if (e == "Back") {
                              return CommonBackButton(onTab: () {
                                context
                                    .read<QuickCalculationProvider>()
                                    .backPress();
                              });
                            } else {
                              return CommonNumberButton(
                                text: e,
                                onTab: () {
                                  context
                                      .read<QuickCalculationProvider>()
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
