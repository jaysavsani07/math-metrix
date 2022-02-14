import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mathgame/src/data/models/picture_puzzle.dart';
import 'package:mathgame/src/ui/common/CommonBackButton.dart';
import 'package:mathgame/src/ui/common/CommonClearButton.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/picturePuzzle/picture_puzzle_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/picturePuzzle/picture_puzzle_button.dart';
import 'package:mathgame/src/ui/common/common_text_button.dart';
import 'package:provider/provider.dart';

class PicturePuzzleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: ChangeNotifierProvider<PicturePuzzleProvider>(
        create: (_) => PicturePuzzleProvider(),
        child: Scaffold(
          appBar: CommonAppBar<PicturePuzzleProvider>(),
          body: DialogListener<PicturePuzzleProvider>(
            gameCategoryType: GameCategoryType.PICTURE_PUZZLE,
            child: Container(
              margin: EdgeInsets.all(24),
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
                            children: provider.list.map((list) {
                              return Padding(
                                padding: const EdgeInsets.all(6),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: list.shapeList.map((subList) {
                                    return PicturePuzzleButton(subList);
                                  }).toList(),
                                ),
                              );
                            }).toList(),
                          );
                        }),
                  ),
                  Builder(
                    builder: (context) {
                      return GridView(
                        gridDelegate: SliverQuiltedGridDelegate(
                          crossAxisCount: 10,
                          pattern: [
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(2, 5),
                            QuiltedGridTile(2, 5),
                          ],
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ...[
                            "5",
                            "6",
                            "7",
                            "8",
                            "9",
                            "0",
                            "1",
                            "2",
                            "3",
                            "4",
                            "Clear",
                            "Back"
                          ].map(
                            (e) {
                              if (e == "Clear") {
                                return CommonClearButton(onTab: () {
                                  context
                                      .read<PicturePuzzleProvider>()
                                      .clearResult();
                                });
                              } else if (e == "Back") {
                                return CommonBackButton(onTab: () {
                                  context.read<PicturePuzzleProvider>().backPress();
                                });
                              } else {
                                return CommonTextButton(
                                  text: e,
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
                    }
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
