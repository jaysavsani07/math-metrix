import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/app_assets.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/ui/common/common_score_view.dart';
import 'package:mathgame/src/ui/app/game_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'common_linear_percent_indicator3.dart';

class CommonAppBar<T extends GameProvider> extends StatelessWidget
    implements PreferredSizeWidget {
  final Tuple2<Color, Color> colorTuple;

  const CommonAppBar({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: PhysicalModel(
          color: Theme.of(context).colorScheme.toolbarCollapsedColor,
          elevation: 4,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18)),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18)),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CommonLinearPercentIndicator<T>(
                  lineHeight: 24,
                  backgroundColor: Color(0xffeeeeee),
                  linearGradient: LinearGradient(
                    colors: [
                      colorTuple.item1,
                      colorTuple.item2,
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 20, top: 7, bottom: 9, right: 20),
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.toolbarCollapsedColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        color: Theme.of(context).colorScheme.crossColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          onTap: () {
                            // Navigator.pop(context);
                            context.read<T>().showExitDialog();
                          },
                          child: SizedBox(
                            height: 38,
                            width: 38,
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Theme.of(context).colorScheme.baseColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.icTrophy,
                            width: 28,
                            height: 28,
                          ),
                          SizedBox(width: 7),
                          // SizedBox(
                          //   height: 28,
                          //   child:  Selector<T, double>(
                          //       selector: (p0, p1) => p1.currentScore,
                          //       builder: (context, currentScore, child) {
                          //         return CommonScoreView1(
                          //             currentScore: currentScore.toInt());
                          //       }),
                          // ),
                          SizedBox(
                            height: 28,
                            child: Selector<T, Tuple2<double, double>>(
                                selector: (p0, p1) =>
                                    Tuple2(p1.currentScore, p1.oldScore),
                                builder: (context, tuple2, child) {
                                  return CommonScoreView(
                                    currentScore: tuple2.item1.toInt(),
                                    oldScore: tuple2.item2.toInt(),
                                  );
                                }),
                          ),
                        ],
                      ),
                      Consumer<T>(builder: (context, provider, child) {
                        return Card(
                          color: Theme.of(context).colorScheme.iconCardBgColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            onTap: () {
                              provider.pauseResumeGame();
                            },
                            child: SizedBox(
                              height: 38,
                              width: 38,
                              child: Icon(
                                provider.timerStatus == TimerStatus.pause
                                    ? Icons.play_arrow
                                    : Icons.pause,
                                color: Theme.of(context).colorScheme.crossColor,
                                size: 20,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(96);
}
