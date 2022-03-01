import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/data/models/mental_arithmetic.dart';
import 'package:mathgame/src/ui/common/CommonBackButton.dart';
import 'package:mathgame/src/ui/common/CommonClearButton.dart';
import 'package:mathgame/src/ui/common/CommonNeumorphicView.dart';
import 'package:mathgame/src/ui/common/CommonNumberButton.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/mentalArithmetic/mental_arithmetic_question_view.dart';
import 'package:mathgame/src/ui/mentalArithmetic/mental_arithmetic_view_model.dart';
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
        child: SafeArea(
          bottom: true,
          top: true,
          child: Scaffold(
            appBar:
                CommonAppBar<MentalArithmeticProvider>(colorTuple: colorTuple),
            body: DialogListener<MentalArithmeticProvider>(
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
                        },
                      ),
                    ),
                    CommonNeumorphicView(
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
