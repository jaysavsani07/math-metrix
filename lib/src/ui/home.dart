import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/assets.dart';
import 'package:mathgame/src/service/navigation_service.dart';
import 'package:mathgame/src/ui/common/HomeSliverPersistentHeaderDelegate.dart';
import 'package:mathgame/src/ui/common/home_button_view.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_view_model.dart';

import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  final PuzzleType puzzleType;
  final String title;

  MyHomePage({Key? key, required this.puzzleType, required this.title})
      : super(key: key);

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
              delegate: HomeSliverPersistentHeaderDelegate(title: title),
            ),
            SliverList(
              // padding: EdgeInsets.only(bottom: 20.0),
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              delegate:
                  SliverChildListDelegate(Provider.of<DashboardViewModel>(context)
                      .getGameByPuzzleType(puzzleType)
                      .map((e) => HomeButtonView(
                          title: e.name,
                          icon: e.icon,
                          score: e.scoreboard.highestScore,
                          coin: e.scoreboard.coin,
                          startColor: Color(0xff4895EF),
                          endColor: Color(0xff3f37c9),
                          onTab: () {
                            GetIt.I<NavigationService>().navigateTo(e.routePath);
                          }))
                      .toList()),
              // children: Provider.of<DashboardViewModel>(context)
              //     .getGameByPuzzleType(puzzleType)
              //     .map((e) => HomeButtonView(
              //         title: e.name,
              //         icon: e.icon,
              //         score: e.scoreboard.highestScore,
              //         coin: e.scoreboard.coin,
              //         startColor: Color(0xff4895EF),
              //         endColor: Color(0xff3f37c9),
              //         onTab: () {
              //           GetIt.I<NavigationService>()
              //               .navigateTo(e.routePath);
              //         }))
              //     .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
