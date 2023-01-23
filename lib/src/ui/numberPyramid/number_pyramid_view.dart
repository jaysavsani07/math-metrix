import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/app/theme_provider.dart';
import 'package:mathgame/src/ui/common/common_back_button.dart';
import 'package:mathgame/src/ui/common/common_clear_button.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/numberPyramid/number_pyramid_provider.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/common/common_text_button.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

import 'number_pyramid_button.dart';

class NumberPyramidView extends StatelessWidget {
  final Tuple2<Color, Color> colorTuple;

  const NumberPyramidView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<NumberPyramidProvider>(
            create: (context) => NumberPyramidProvider(
                  vsync: VsyncProvider.of(context),
                  difficultyType: context.read<ThemeProvider>().difficultyType,
                ))
      ],
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
            appBar: CommonAppBar<NumberPyramidProvider>(colorTuple: colorTuple),
            body: SafeArea(
              bottom: true,
              child: DialogListener<NumberPyramidProvider>(
                gameCategoryType: GameCategoryType.NUMBER_PYRAMID,
                child: Container(
                  margin: EdgeInsets.only(top: 24, left: 24, right: 24),
                  constraints: BoxConstraints.expand(),
                  child: Column(
                    children: <Widget>[
                      CommonInfoTextView<NumberPyramidProvider>(
                          gameCategoryType: GameCategoryType.NUMBER_PYRAMID),
                      Expanded(
                        flex: 5,
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Center(
                            child: Consumer<NumberPyramidProvider>(builder:
                                (context, numberPyramidProvider, child) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  PyramidNumberButton(
                                    numPyramidCellModel: numberPyramidProvider
                                        .currentState.list[27],
                                    isLeftRadius: true,
                                    isRightRadius: true,
                                    height: constraints.maxWidth,
                                    colorTuple: colorTuple,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[26],
                                        isLeftRadius: true,
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[25],
                                        isRightRadius: true,
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[24],
                                        isLeftRadius: true,
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[23],
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[22],
                                        isRightRadius: true,
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[21],
                                        isLeftRadius: true,
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[20],
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[19],
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[18],
                                        isRightRadius: true,
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[17],
                                        isLeftRadius: true,
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[16],
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[15],
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[14],
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[13],
                                        isRightRadius: true,
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[12],
                                        isLeftRadius: true,
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[11],
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[10],
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[9],
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[8],
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[7],
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                        isRightRadius: true,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[6],
                                        isLeftRadius: true,
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[5],
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[4],
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[3],
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[2],
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[1],
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                      PyramidNumberButton(
                                        numPyramidCellModel:
                                            numberPyramidProvider
                                                .currentState.list[0],
                                        isRightRadius: true,
                                        height: constraints.maxWidth,
                                        colorTuple: colorTuple,
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                          );
                        }),
                      ),
                      Expanded(
                        flex: 5,
                        child: LayoutBuilder(builder: (context, constraints) {
                          return GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: (constraints.maxWidth / 3) /
                                  ((constraints.maxHeight - 24) / 4),
                            ),
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
                                "Done",
                                "0",
                                "Back"
                              ].map(
                                (e) {
                                  if (e == "Back") {
                                    return CommonBackButton(onTab: () {
                                      context
                                          .read<NumberPyramidProvider>()
                                          .pyramidBoxInputValue(e);
                                    });
                                  } else if (e == "Done") {
                                    return CommonClearButton(
                                        text: "Done",
                                        onTab: () {
                                          context
                                              .read<NumberPyramidProvider>()
                                              .pyramidBoxInputValue(e);
                                        });
                                  } else {
                                    return CommonTextButton(
                                      text: e,
                                      colorTuple: colorTuple,
                                      onTab: () {
                                        context
                                            .read<NumberPyramidProvider>()
                                            .pyramidBoxInputValue(e);
                                      },
                                    );
                                  }
                                },
                              )
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
