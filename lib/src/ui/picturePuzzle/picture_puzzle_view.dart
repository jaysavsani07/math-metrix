import 'package:flutter/material.dart';
import 'package:mathgame/src/data/models/picture_puzzle.dart';
import 'package:mathgame/src/ui/common/common_back_button.dart';
import 'package:mathgame/src/ui/common/common_clear_button.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/picturePuzzle/picture_puzzle_provider.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/picturePuzzle/picture_puzzle_button.dart';
import 'package:mathgame/src/ui/common/common_text_button.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';
import 'package:collection/collection.dart';

class PicturePuzzleView extends StatelessWidget {
  final Tuple2<Color, Color> colorTuple;

  const PicturePuzzleView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<PicturePuzzleProvider>(
            create: (context) =>
                PicturePuzzleProvider(vsync: VsyncProvider.of(context)))
      ],
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          appBar: CommonAppBar<PicturePuzzleProvider>(colorTuple: colorTuple),
          body: SafeArea(
            bottom: true,
            child: DialogListener<PicturePuzzleProvider>(
              gameCategoryType: GameCategoryType.PICTURE_PUZZLE,
              child: Container(
                margin: EdgeInsets.only(top: 24, left: 24, right: 24),
                constraints: BoxConstraints.expand(),
                child: Column(
                  children: <Widget>[
                    CommonInfoTextView<PicturePuzzleProvider>(
                        gameCategoryType: GameCategoryType.PICTURE_PUZZLE),
                    Expanded(
                      child: Selector<PicturePuzzleProvider, PicturePuzzle>(
                          selector: (p0, p1) => p1.currentState,
                          builder: (context, provider, child) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: provider.list.mapIndexed((index, list) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: index == 3 ? 6 : 12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: list.shapeList.map((subList) {
                                      return PicturePuzzleButton(
                                        picturePuzzleShape: subList,
                                        shapeColor: colorTuple.item1,
                                        colorTuple: colorTuple,
                                      );
                                    }).toList(),
                                  ),
                                );
                              }).toList(),
                            );
                          }),
                    ),
                    Builder(builder: (context) {
                      return GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.3,
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
                                          .read<PicturePuzzleProvider>()
                                          .clearResult();
                                    });
                              } else if (e == "Back") {
                                return CommonBackButton(onTab: () {
                                  context
                                      .read<PicturePuzzleProvider>()
                                      .backPress();
                                });
                              } else {
                                return CommonTextButton(
                                  text: e,
                                  colorTuple: colorTuple,
                                  onTab: () {
                                    context
                                        .read<PicturePuzzleProvider>()
                                        .checkGameResult(e);
                                  },
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
