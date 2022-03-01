import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/data/models/quick_calculation.dart';
import 'package:mathgame/src/ui/common/CommonBackButton.dart';
import 'package:mathgame/src/ui/common/CommonClearButton.dart';
import 'package:mathgame/src/ui/common/CommonNeumorphicView.dart';
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
  final Tuple2<Color, Color> colorTuple;

  const QuickCalculationView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<QuickCalculationProvider>(
            create: (context) =>
                QuickCalculationProvider(vsync: VsyncProvider.of(context)))
      ],
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: SafeArea(
          top: true,
          bottom: true,
          child: Scaffold(
            appBar:
                CommonAppBar<QuickCalculationProvider>(colorTuple: colorTuple),
            body: DialogListener<QuickCalculationProvider>(
              gameCategoryType: GameCategoryType.QUICK_CALCULATION,
              child: Container(
                margin: EdgeInsets.only(top: 24, left: 24, right: 24),
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
                                child: SizedBox(
                                  height: 72,
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
                              ),
                              SizedBox(width: 6),
                              Text(
                                " = ",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontSize: 30),
                              ),
                              SizedBox(width: 6),
                              CommonNeumorphicView(
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
                                        }),
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
