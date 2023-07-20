import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/data/models/dashboard.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_provider.dart';
import 'package:mathgame/src/ui/home/home_button_view.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class HomeView1 extends HookWidget {
  final Tuple2<Dashboard, double> tuple2;

  const HomeView1({Key? key, required this.tuple2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late bool isGamePageOpen;
    ScrollController scrollController = useScrollController();

    return Scaffold(
      appBar: PreferredSize(
        child: SizedBox(),
        preferredSize: Size.fromHeight(0),
      ),
      body: SafeArea(
        bottom: true,
        child: Container(
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.only(top: tuple2.item2),
          child: Stack(
            children: [
              ListView(
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                  top: 183,
                  bottom: tuple2.item1.puzzleType == PuzzleType.BRAIN_PUZZLE
                      ? MediaQuery.of(context).size.height / 3
                      : MediaQuery.of(context).size.height / 4,
                ),
                children: Provider.of<DashboardProvider>(context)
                    .getGameByPuzzleType(tuple2.item1.puzzleType)
                    .map((e) => HomeButtonView(
                        title: e.name,
                        icon: e.icon,
                        score: e.scoreboard.highestScore,
                        colorTuple: tuple2.item1.colorTuple,
                        opacity: tuple2.item1.opacity,
                        onTab: () {
                          if (!isGamePageOpen) {
                            isGamePageOpen = true;
                            Navigator.pushNamed(
                              context,
                              e.routePath,
                              arguments: tuple2.item1.colorTuple,
                            ).then((value) {
                              isGamePageOpen = false;
                            });
                          }
                        }))
                    .toList(),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: RepaintBoundary(
                  child: Animate(
                      adapter: ScrollAdapter(
                    scrollController,
                    // begin: tuple2.item2,
                    end: 127,
                  )).custom(
                    builder: (_, value, __) {
                      return PhysicalModel(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Theme.of(context).colorScheme.baseColor
                            : Color.lerp(
                                Colors.black, Color(0xFF212121), value)!,
                        elevation: value * 4,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(value * 18),
                            bottomRight: Radius.circular(value * 18)),
                        child: Container(
                          height: 183 - (value * 127),
                          child: Stack(
                            children: <Widget>[
                              // Positioned(
                              //   bottom: fillImageBottomPositionTween.value,
                              //   right: fillImageRightPositionTween.value,
                              //   child: SvgPicture.asset(
                              //     widget.tuple2.item1.icon,
                              //     height: 200,
                              //     width: 200,
                              //     colorFilter: ColorFilter.mode(
                              //       widget.tuple2.item1.fillIconColor.withOpacity(
                              //           Theme.of(context).brightness ==
                              //                   Brightness.light
                              //               ? 0.08
                              //               : 0.24),
                              //       BlendMode.srcIn,
                              //     ),
                              //   ),
                              // ),
                              // Positioned(
                              //   bottom: outlineImageBottomPositionTween.value,
                              //   right: outlineImageRightPositionTween.value,
                              //   child: SvgPicture.asset(
                              //     widget.tuple2.item1.outlineIcon,
                              //     height: 175,
                              //     width: 175,
                              //     colorFilter: ColorFilter.mode(
                              //       widget.tuple2.item1.outlineIconColor
                              //           .withOpacity(
                              //               Theme.of(context).brightness ==
                              //                       Brightness.light
                              //                   ? 0.16
                              //                   : 0.80),
                              //       BlendMode.srcIn,
                              //     ),
                              //     // color: widget.dashboard.colorTuple.item1,
                              //   ),
                              // ),
                              Padding(
                                padding: EdgeInsets.only(left: 20, top: 7),
                                child: Card(
                                  color:
                                      Theme.of(context).colorScheme.crossColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16))),
                                  child: InkWell(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: SizedBox(
                                      height: 38,
                                      width: 38,
                                      child: Icon(
                                        Icons.arrow_back_ios_new_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .baseColor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0.0,
                                left: 66 * value,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        tuple2.item1.title,
                                        style: TextStyle(
                                          fontSize: 28 - (value * 4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      ClipRect(
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          heightFactor: max(1 - value, 0),
                                          child: Opacity(
                                            opacity: 1 - value,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    62,
                                                child: Text(
                                                  tuple2.item1.subtitle,
                                                  maxLines: 2,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
