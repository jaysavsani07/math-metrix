import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/assets.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/ui/common/common_linear_percent_indicator.dart';
import 'package:mathgame/src/ui/common/game_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class CommonAppBar<T extends GameProvider> extends StatelessWidget
    implements PreferredSizeWidget {
  const CommonAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
        color: Theme.of(context).colorScheme.baseColor,
        elevation: 4,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(18), bottomRight: Radius.circular(18)),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18)),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Selector<T, Tuple2<TimerStatus,int>>(
                selector: (p0, p1) => Tuple2(p1.timerStatus, p1.totalTime),
                builder: (context, tuple2, child) {
                  return CommonLinearPercentIndicator(
                    lineHeight: 24,
                    timerStatus: tuple2.item1,
                    linearGradient: LinearGradient(colors: [
                      Color(0xff4895EF),
                      Color(0xff3f37c9),
                    ]),
                    linearStrokeCap: LinearStrokeCap.butt,
                    padding: const EdgeInsets.all(0),
                    animationDuration: tuple2.item2*1000,
                  );
                },
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 20, top: 7, bottom: 9, right: 20),
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.baseColor,
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
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: InkWell(
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
                        Consumer<T>(builder: (context, provider, child) {
                          return Text(provider.currentScore.toInt().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(fontSize: 24));
                        })
                      ],
                    ),
                    Consumer<T>(builder: (context, provider, child) {
                      return Card(
                        color: Theme.of(context).colorScheme.iconBgColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: InkWell(
                          onTap: () {
                            provider.pauseResumeGame();
                          },
                          child: SizedBox(
                            height: 38,
                            width: 38,
                            child: Icon(
                              provider.timerStatus == TimerStatus.pause
                                  ? Icons.pause
                                  : Icons.play_arrow,
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
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(96);
}
