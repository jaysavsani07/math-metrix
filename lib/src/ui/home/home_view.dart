import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/service/navigation_service.dart';
import 'package:mathgame/src/ui/common/HomeSliverPersistentHeaderDelegate.dart';
import 'package:mathgame/src/ui/common/home_button_view.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_view_model.dart';

import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class HomeView extends StatelessWidget {
  final PuzzleType puzzleType;
  final String title;
  final Tuple2<Color, Color> colorTuple;
  final double opacity;

  HomeView({
    Key? key,
    required this.puzzleType,
    required this.title,
    required this.colorTuple,
    required this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: HomeSliverPersistentHeaderDelegate(
                  title: title, colorTuple: colorTuple),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                  Provider.of<DashboardViewModel>(context)
                      .getGameByPuzzleType(puzzleType)
                      .map((e) => HomeButtonView(
                          title: e.name,
                          icon: e.icon,
                          score: e.scoreboard.highestScore,
                          coin: e.scoreboard.coin,
                          colorTuple: colorTuple,
                          opacity: opacity,
                          onTab: () {
                            GetIt.I<NavigationService>()
                                .navigateTo(e.routePath, arguments: colorTuple);
                          }))
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}
