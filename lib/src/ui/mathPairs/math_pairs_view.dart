import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/mathPairs/math_pairs_provider.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/mathPairs/math_pairs_button.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

class MathPairsView extends StatelessWidget {
  final Tuple2<Color, Color> colorTuple;

  const MathPairsView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<MathPairsProvider>(
            create: (context) =>
                MathPairsProvider(vsync: VsyncProvider.of(context)))
      ],
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          appBar: CommonAppBar<MathPairsProvider>(colorTuple: colorTuple),
          body: SafeArea(
            bottom: true,
            child: DialogListener<MathPairsProvider>(
              gameCategoryType: GameCategoryType.MATH_PAIRS,
              child: Container(
                margin: EdgeInsets.only(top: 24, left: 24, right: 24),
                constraints: BoxConstraints.expand(),
                child: Column(
                  children: <Widget>[
                    CommonInfoTextView<MathPairsProvider>(
                        gameCategoryType: GameCategoryType.MATH_PAIRS),
                    Expanded(
                      child: Center(
                        child: Consumer<MathPairsProvider>(
                            builder: (context, mathPairsProvider, child) {
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, childAspectRatio: 1.2),
                              padding: const EdgeInsets.only(bottom: 24),
                              shrinkWrap: true,
                              itemCount:
                                  mathPairsProvider.currentState.list.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return MathPairsButton(
                                  mathPairs: mathPairsProvider
                                      .currentState.list[index],
                                  index: index,
                                  colorTuple: colorTuple,
                                );
                              });
                        }),
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
