import 'package:flutter/material.dart';
import 'package:mathgame/src/data/models/correct_answer.dart';
import 'package:mathgame/src/ui/common/CommonNumberButton.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/correctAnswer/correct_answer_question_view.dart';
import 'package:mathgame/src/ui/correctAnswer/correct_answer_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';
import '../common/CommonNeumorphicView.dart';

class CorrectAnswerView extends StatelessWidget {
  final Tuple2<Color, Color> colorTuple;

  const CorrectAnswerView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<CorrectAnswerProvider>(
            create: (context) =>
                CorrectAnswerProvider(vsync: VsyncProvider.of(context)))
      ],
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: SafeArea(
          top: true,
          bottom: true,
          child: Scaffold(
            appBar: CommonAppBar<CorrectAnswerProvider>(colorTuple: colorTuple),
            body: DialogListener<CorrectAnswerProvider>(
              gameCategoryType: GameCategoryType.CORRECT_ANSWER,
              child: Container(
                margin: EdgeInsets.only(top: 24, left: 24, right: 24),
                constraints: BoxConstraints.expand(),
                child: Column(
                  children: <Widget>[
                    CommonInfoTextView<CorrectAnswerProvider>(
                        gameCategoryType: GameCategoryType.CORRECT_ANSWER),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Selector<CorrectAnswerProvider, CorrectAnswer>(
                              selector: (p0, p1) => p1.currentState,
                              builder: (context, currentState, child) {
                                return CorrectAnswerQuestionView(
                                  question: currentState.question,
                                  questionView: CommonNeumorphicView(
                                    child:
                                        Selector<CorrectAnswerProvider, String>(
                                            selector: (p0, p1) => p1.result,
                                            builder: (context, result, child) {
                                              return Text(
                                                result == "" ? "?" : result,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2!
                                                    .copyWith(
                                                        fontSize: 30,
                                                        color: colorTuple.item1),
                                              );
                                            }),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                    Selector<CorrectAnswerProvider, CorrectAnswer>(
                        selector: (p0, p1) => p1.currentState,
                        builder: (context, currentState, child) {
                          return GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            padding: const EdgeInsets.only(bottom: 24),
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
                                          .read<CorrectAnswerProvider>()
                                          .checkResult(e);
                                    },
                                    colorTuple: colorTuple,
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
