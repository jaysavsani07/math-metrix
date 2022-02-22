import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/data/models/mental_arithmetic.dart';
import 'package:mathgame/src/ui/common/CommonBackButton.dart';
import 'package:mathgame/src/ui/common/CommonClearButton.dart';
import 'package:mathgame/src/ui/common/CommonNumberButton.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/mentalArithmetic/mental_arithmetic_question_view.dart';
import 'package:mathgame/src/ui/mentalArithmetic/mental_arithmetic_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:provider/provider.dart';
import 'package:vsync_provider/vsync_provider.dart';

class MentalArithmeticView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<MentalArithmeticProvider>(
            create: (context) =>
                MentalArithmeticProvider(vsync: VsyncProvider.of(context)))
      ],
      child: SafeArea(
        bottom: true,
        top: true,
        child: Scaffold(
          appBar: CommonAppBar<MentalArithmeticProvider>(),
          body: DialogListener<MentalArithmeticProvider>(
            gameCategoryType: GameCategoryType.MENTAL_ARITHMETIC,
            child: Container(
              margin: EdgeInsets.all(24),
              constraints: BoxConstraints.expand(),
              child: Column(
                children: <Widget>[
                  CommonInfoTextView<MentalArithmeticProvider>(
                      gameCategoryType: GameCategoryType.MENTAL_ARITHMETIC),
                  Expanded(
                    child: Selector<MentalArithmeticProvider, MentalArithmetic>(
                      selector: (p0, p1) => p1.currentState,
                      builder: (context, currentState, child) {
                        return MentalArithmeticQuestionView(
                          currentState: currentState,
                        );
                      },
                    ),
                  ),
                  Neumorphic(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    style: NeumorphicStyle(
                      // shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(18)),
                      depth: -8,
                      lightSource: LightSource.topLeft,
                      color: Theme.of(context).colorScheme.iconBgColor,
                    ),
                    child: Container(
                      width: 80,
                      height: 40,
                      alignment: Alignment.center,
                      child: Selector<MentalArithmeticProvider, String>(
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
                  SizedBox(height: 24),
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
                          "-",
                          "0",
                          "Back"
                        ].map(
                          (e) {
                            /*   if (e == "-") {
                              return CommonClearButton(onTab: () {
                                context
                                    .read<MentalArithmeticProvider>()
                                    .checkResult(e);
                              });
                            } else*/
                            if (e == "Back") {
                              return CommonBackButton(onTab: () {
                                context
                                    .read<MentalArithmeticProvider>()
                                    .backPress();
                              });
                            } else {
                              return CommonNumberButton(
                                text: e,
                                onTab: () {
                                  context
                                      .read<MentalArithmeticProvider>()
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
