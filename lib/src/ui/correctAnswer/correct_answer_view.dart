import 'package:flutter/material.dart';
import 'package:mathgame/src/data/models/correct_answer.dart';
import 'package:mathgame/src/ui/common/CommonNumberButton.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/correctAnswer/correct_answer_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:provider/provider.dart';
import 'package:vsync_provider/vsync_provider.dart';

class CorrectAnswerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<CorrectAnswerProvider>(
            create: (context) =>
                CorrectAnswerProvider(vsync: VsyncProvider.of(context)))
      ],
      child: SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          appBar: CommonAppBar<CorrectAnswerProvider>(),
          body: DialogListener<CorrectAnswerProvider>(
            gameCategoryType: GameCategoryType.CORRECT_ANSWER,
            child: Container(
              margin: EdgeInsets.all(24),
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
                            builder: (context, calculatorProvider, child) {
                              return Text(
                                calculatorProvider.question,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontSize: 30),
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
                                  startColor: Color(0xff4895EF),
                                  endColor: Color(0xff3f37c9),
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
    );
  }
}
