import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/provider/dashboardViewModel.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/resources/navigation_service.dart';
import 'package:mathgame/src/utility/keyUtil.dart';

import 'package:mathgame/src/utility/sizeConfig.dart';

import 'home.dart';
import 'package:mathgame/src/ui/home.dart';
import 'package:provider_architecture/provider_architecture.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
      lowerBound: 0.0,
      upperBound: 0.6,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    print("hello");
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _scale = 1 - _controller.value;

    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: ViewModelProvider.withConsumer(
            reuseExisting: true,
            viewModel: GetIt.I<DashboardViewModel>(),
            onModelReady: (model) => model.initialise(),
            builder: (context, DashboardViewModel model, child) => Container(
                  constraints: BoxConstraints.expand(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Container(
                            constraints: BoxConstraints.expand(),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.credit_card,
                                          color: Colors.deepOrange[300]),
                                      SizedBox(width: 5),
                                      Text(model.overallScore.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead),
                                      SizedBox(width: 30),
                                      Icon(Icons.monetization_on,
                                          color: Colors.yellow[300]),
                                      SizedBox(width: 5),
                                      Text(model.totalCoin.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 2,
                          child: Container(
                              constraints: BoxConstraints.expand(),
                              alignment: Alignment.center,
                              child: Text("Math Matrix",
                                  style:
                                      Theme.of(context).textTheme.display2))),
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: (SizeConfig.screenHeight / 20),
                            ),
                            GestureDetector(
                              onTapDown: (tapDownDetails) {
                                GetIt.I<NavigationService>().navigateTo(
                                    KeyUtil.Home,
                                    arguments: PuzzleType.MATH_PUZZLE);
                              },
                              child: Transform.scale(
                                scale: 1,
                                child: Card(
                                  margin: EdgeInsets.all(10),
                                  child: Container(
                                      alignment: Alignment.center,
                                      width: (SizeConfig.screenWidth / 10) * 6,
                                      margin: EdgeInsets.all(20),
                                      child: Text("Math Puzzle",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline)),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTapDown: (tapDownDetails) {
                                GetIt.I<NavigationService>().navigateTo(
                                    KeyUtil.Home,
                                    arguments: PuzzleType.MEMORY_PUZZLE);
                              },
                              child: Card(
                                margin: EdgeInsets.all(10),
                                child: Container(
                                    alignment: Alignment.center,
                                    width: (SizeConfig.screenWidth / 10) * 6,
                                    margin: EdgeInsets.all(20),
                                    child: Text("Memory Puzzle",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline)),
                              ),
                            ),
                            GestureDetector(
                              onTapDown: (tapDownDetails) {
                                GetIt.I<NavigationService>().navigateTo(
                                    KeyUtil.Home,
                                    arguments: PuzzleType.BRAIN_PUZZLE);
                              },
                              child: Card(
                                margin: EdgeInsets.all(10),
                                child: Container(
                                    alignment: Alignment.center,
                                    width: (SizeConfig.screenWidth / 10) * 6,
                                    margin: EdgeInsets.all(20),
                                    child: Text("Train Your Brain",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
