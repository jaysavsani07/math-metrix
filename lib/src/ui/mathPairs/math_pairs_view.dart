import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/mathPairs/math_pairs_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/ui/mathPairs/math_pairs_button.dart';
import 'package:provider/provider.dart';
import 'package:vsync_provider/vsync_provider.dart';

class MathPairsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<MathPairsProvider>(
            create: (context) =>
                MathPairsProvider(vsync: VsyncProvider.of(context)))
      ],
      child: SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          appBar: CommonAppBar<MathPairsProvider>(),
          body: DialogListener<MathPairsProvider>(
            gameCategoryType: GameCategoryType.MATH_PAIRS,
            child: Container(
              margin: EdgeInsets.all(24),
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
                            shrinkWrap: true,
                            itemCount:
                                mathPairsProvider.currentState.list.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return MathPairsButton(
                                mathPairs:
                                    mathPairsProvider.currentState.list[index],
                                index: index,
                                startColor: Color(0xff4895EF),
                                endColor: Color(0xff3f37c9),
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
    );
  }
}
