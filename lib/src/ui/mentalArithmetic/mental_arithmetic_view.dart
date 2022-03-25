import 'package:flutter/material.dart';
import 'package:mathgame/src/data/models/mental_arithmetic.dart';
import 'package:mathgame/src/ui/common/common_back_button.dart';
import 'package:mathgame/src/ui/common/common_clear_button.dart';
import 'package:mathgame/src/ui/common/common_neumorphic_view.dart';
import 'package:mathgame/src/ui/common/common_number_button.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/mentalArithmetic/mental_arithmetic_question_view.dart';
import 'package:mathgame/src/ui/mentalArithmetic/mental_arithmetic_provider.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

class MentalArithmeticView extends StatelessWidget {
  final Tuple2<Color, Color> colorTuple;

  const MentalArithmeticView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<MentalArithmeticProvider>(
            create: (context) =>
                MentalArithmeticProvider(vsync: VsyncProvider.of(context)))
      ],
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          appBar:
              CommonAppBar<MentalArithmeticProvider>(colorTuple: colorTuple),
          body: SafeArea(
            bottom: true,
            child: DialogListener<MentalArithmeticProvider>(
              gameCategoryType: GameCategoryType.MENTAL_ARITHMETIC,
              child: Container(
                margin: EdgeInsets.only(top: 24, left: 24, right: 24),
                constraints: BoxConstraints.expand(),
                child: Column(
                  children: <Widget>[
                    CommonInfoTextView<MentalArithmeticProvider>(
                        gameCategoryType: GameCategoryType.MENTAL_ARITHMETIC),
                    Expanded(
                      child:
                          Selector<MentalArithmeticProvider, MentalArithmetic>(
                              selector: (p0, p1) => p1.currentState,
                              builder: (context, currentState, child) {
                                return MentalArithmeticQuestionView(
                                  currentState: currentState,
                                );
                              }),
                    ),
                    Selector<MentalArithmeticProvider, Tuple2<double, double>>(
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
                        child: Selector<MentalArithmeticProvider, String>(
                          selector: (p0, p1) => p1.result,
                          builder: (context, result, child) {
                            return Text(result,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                        fontSize: 24, color: colorTuple.item1));
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Builder(builder: (context) {
                      return GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
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
                            "-",
                            "0",
                            "Back"
                          ].map(
                            (e) {
                              if (e == "Back") {
                                return CommonBackButton(onTab: () {
                                  context
                                      .read<MentalArithmeticProvider>()
                                      .backPress();
                                });
                              } else if (e == "-") {
                                return CommonClearButton(
                                    text: e,
                                    fontSize: 40,
                                    onTab: () {
                                      context
                                          .read<MentalArithmeticProvider>()
                                          .checkResult(e);
                                    });
                              } else {
                                return CommonNumberButton(
                                  text: e,
                                  onTab: () {
                                    context
                                        .read<MentalArithmeticProvider>()
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
