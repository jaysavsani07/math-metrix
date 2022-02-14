import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/mathGrid/math_grid_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/mathGrid/math_grid_button.dart';
import 'package:provider/provider.dart';

class MathGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: ChangeNotifierProvider<MathGridProvider>(
        create: (_) => MathGridProvider(),
        child: Scaffold(
          appBar: CommonAppBar<MathGridProvider>(),
          body: DialogListener<MathGridProvider>(
            gameCategoryType: GameCategoryType.MATH_MACHINE,
            child: Container(
              margin: EdgeInsets.all(24),
              constraints: BoxConstraints.expand(),
              child: Column(
                children: <Widget>[
                  CommonInfoTextView<MathGridProvider>(
                      gameCategoryType: GameCategoryType.MATH_MACHINE),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Selector<MathGridProvider, int>(
                            selector: (p0, p1) => p1.currentState.currentAnswer,
                            builder: (context, currentAnswer, child) {
                              return Text(
                                currentAnswer.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontSize: 38),
                              );
                            }),
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        alignment: Alignment.center,
                        // height: height,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff4895EF), Color(0xff3f37c9)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Consumer<MathGridProvider>(
                            builder: (context, listForSquare, child) {
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 9),
                              itemCount: listForSquare
                                  .currentState.listForSquare.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return MathGridButton(
                                  gridModel: listForSquare
                                      .currentState.listForSquare[index],
                                  index: index,
                                );
                              });
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
