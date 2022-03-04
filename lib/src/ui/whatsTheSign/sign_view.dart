import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mathgame/src/data/models/sign.dart';
import 'package:mathgame/src/ui/common/CommonNeumorphicView.dart';
import 'package:mathgame/src/ui/common/CommonNumberButton.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/whatsTheSign/sign_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

class SignView extends StatelessWidget {
  final Tuple2<Color, Color> colorTuple;

  const SignView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<SignProvider>(
            create: (context) => SignProvider(vsync: VsyncProvider.of(context)))
      ],
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: SafeArea(
          top: true,
          bottom: true,
          child: Scaffold(
            appBar: CommonAppBar<SignProvider>(colorTuple: colorTuple),
            body: DialogListener<SignProvider>(
              gameCategoryType: GameCategoryType.SIGN,
              child: Container(
                margin: EdgeInsets.only(top: 24, left: 24, right: 24),
                constraints: BoxConstraints.expand(),
                child: Column(
                  children: <Widget>[
                    CommonInfoTextView<SignProvider>(
                        gameCategoryType: GameCategoryType.SIGN),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Selector<SignProvider, Sign>(
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
                          Selector<SignProvider, Tuple2<double, double>>(
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
                              child: Selector<SignProvider, String>(
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
                          Selector<SignProvider, Sign>(
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
                          Selector<SignProvider, Sign>(
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
                                  context.read<SignProvider>().checkResult(e);
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
