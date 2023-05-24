import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mathgame/src/core/app_assets.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/data/models/square_root.dart';
import 'package:mathgame/src/ui/app/theme_provider.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/common_number_button.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/squareRoot/square_root_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:vsync_provider/vsync_provider.dart';

class SquareRootView extends StatelessWidget {
  final Tuple2<Color, Color> colorTuple;

  const SquareRootView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<SquareRootProvider>(
            create: (context) => SquareRootProvider(
                  vsync: VsyncProvider.of(context),
                  difficultyType: context.read<ThemeProvider>().difficultyType,
                ))
      ],
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          appBar: CommonAppBar<SquareRootProvider>(colorTuple: colorTuple),
          body: SafeArea(
            bottom: true,
            child: DialogListener<SquareRootProvider>(
              gameCategoryType: GameCategoryType.SQUARE_ROOT,
              child: Container(
                margin: EdgeInsets.only(top: 24, left: 24, right: 24),
                constraints: BoxConstraints.expand(),
                child: Column(
                  children: <Widget>[
                    CommonInfoTextView<SquareRootProvider>(
                        gameCategoryType: GameCategoryType.SQUARE_ROOT),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.icRoot,
                            height: 40,
                            colorFilter: ColorFilter.mode(
                              colorTuple.item1,
                              BlendMode.srcIn,
                            ),
                          ),
                          Selector<SquareRootProvider, SquareRoot>(
                              selector: (p0, p1) => p1.currentState,
                              builder: (context, currentState, child) {
                                return Text(
                                  currentState.question,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontSize: 40),
                                );
                              }),
                        ],
                      ),
                    ),
                    Selector<SquareRootProvider, SquareRoot>(
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
                                        .read<SquareRootProvider>()
                                        .checkResult(e);
                                  },
                                  colorTuple: colorTuple,
                                  fontSize: 48,
                                );
                              },
                            )
                          ],
                        );
                      },
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
