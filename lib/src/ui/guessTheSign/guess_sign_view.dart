import 'package:flutter/material.dart';
import 'package:mathgame/src/data/models/sign.dart';
import 'package:mathgame/src/ui/common/common_neumorphic_view.dart';
import 'package:mathgame/src/ui/common/common_number_button.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/guessTheSign/guess_sign_provider.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

class GuessSignView extends StatelessWidget {
  final Tuple2<Color, Color> colorTuple;

  const GuessSignView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<GuessSignProvider>(
            create: (context) => GuessSignProvider(vsync: VsyncProvider.of(context)))
      ],
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          appBar: CommonAppBar<GuessSignProvider>(colorTuple: colorTuple),
          body: SafeArea(
            bottom: true,
            child: DialogListener<GuessSignProvider>(
              gameCategoryType: GameCategoryType.GUESS_SIGN,
              child: Container(
                margin: EdgeInsets.only(top: 24, left: 24, right: 24),
                constraints: BoxConstraints.expand(),
                child: Column(
                  children: <Widget>[
                    CommonInfoTextView<GuessSignProvider>(
                        gameCategoryType: GameCategoryType.GUESS_SIGN),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Selector<GuessSignProvider, Sign>(
                              selector: (p0, p1) => p1.currentState,
                              builder: (context, calculatorProvider, child) {
                                return Text(
                                  calculatorProvider.firstDigit,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontSize: 30),
                                );
                              }),
                          SizedBox(width: 14),
                          Selector<GuessSignProvider, Tuple2<double, double>>(
                            selector: (p0, p1) =>
                                Tuple2(p1.currentScore, p1.oldScore),
                            builder: (context, tuple2, child) {
                              return CommonWrongAnswerAnimationView(
                                currentScore: tuple2.item1.toInt(),
                                oldScore: tuple2.item2.toInt(),
                                child: child!,
                              );
                            },
                            child:  CommonNeumorphicView(
                              child: Selector<GuessSignProvider, String>(
                                selector: (p0, p1) => p1.result,
                                builder: (context, result, child) {
                                  return Text(
                                    result,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                        fontSize: 30,
                                        color: colorTuple.item1),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 14),
                          Selector<GuessSignProvider, Sign>(
                              selector: (p0, p1) => p1.currentState,
                              builder: (context, calculatorProvider, child) {
                                return Text(
                                  calculatorProvider.secondDigit,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontSize: 30),
                                );
                              }),
                          SizedBox(width: 6),
                          Text(
                            "=",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 30),
                          ),
                          SizedBox(width: 6),
                          Selector<GuessSignProvider, Sign>(
                              selector: (p0, p1) => p1.currentState,
                              builder: (context, calculatorProvider, child) {
                                return Text(
                                  calculatorProvider.answer,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontSize: 30),
                                );
                              }),
                        ],
                      ),
                    ),
                    Builder(builder: (context) {
                      return GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        padding: const EdgeInsets.only(bottom: 24),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ...[
                            "/",
                            "*",
                            "+",
                            "-",
                          ].map(
                            (e) {
                              return CommonNumberButton(
                                text: e,
                                onTab: () {
                                  context.read<GuessSignProvider>().checkResult(e);
                                },
                                colorTuple: colorTuple,
                                fontSize: 48,
                              );
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
