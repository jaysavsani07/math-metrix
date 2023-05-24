import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/app/theme_provider.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/mathGrid/math_grid_provider.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/mathGrid/math_grid_button.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

class MathGridView extends StatelessWidget {
  final Tuple2<Color, Color> colorTuple;

  const MathGridView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<MathGridProvider>(
            create: (context) => MathGridProvider(
                  vsync: VsyncProvider.of(context),
                  difficultyType: context.read<ThemeProvider>().difficultyType,
                ))
      ],
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          appBar: CommonAppBar<MathGridProvider>(colorTuple: colorTuple),
          body: SafeArea(
            bottom: true,
            child: DialogListener<MathGridProvider>(
              gameCategoryType: GameCategoryType.MATH_GRID,
              child: Container(
                margin: EdgeInsets.all(24),
                constraints: BoxConstraints.expand(),
                child: Column(
                  children: <Widget>[
                    CommonInfoTextView<MathGridProvider>(
                        gameCategoryType: GameCategoryType.MATH_GRID),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Selector<MathGridProvider, int>(
                              selector: (p0, p1) =>
                                  p1.currentState.currentAnswer,
                              builder: (context, currentAnswer, child) {
                                return Text(
                                  currentAnswer.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontSize: 40),
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
                              colors: [colorTuple.item1, colorTuple.item2],
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
                                    colorTuple: colorTuple,
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
      ),
    );
  }
}
