import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/service/navigation_service.dart';

import 'package:mathgame/src/core/size_config.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetLeftEnter;
  Animation<Offset> _offsetRightEnter;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );
    _offsetLeftEnter = Tween<Offset>(
      begin: Offset(2.0, 0.0),
      end: Offset.zero,
    ).animate(_controller);

    _offsetRightEnter = Tween<Offset>(
      begin: Offset(-2.0, 0.0),
      end: Offset.zero,
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Container(
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
                              SvgPicture.asset(
                                "assets/images/goal.svg",
                                width: 18,
                                height: 18,
                              ),
                              SizedBox(width: 5),
                              Consumer<DashboardViewModel>(
                                builder: (context, model, child) => Text(
                                    model.overallScore.toString(),
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                              SizedBox(width: 30),
                              SvgPicture.asset(
                                "assets/images/money.svg",
                                width: 18,
                                height: 18,
                              ),
                              SizedBox(width: 5),
                              Consumer<DashboardViewModel>(
                                builder: (context, model, child) => Text(
                                    model.totalCoin.toString(),
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              )
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
                          style: Theme.of(context).textTheme.headline4))),
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
                        GetIt.I<NavigationService>().navigateTo(KeyUtil.Home,
                            arguments: PuzzleType.MATH_PUZZLE);
                      },
                      child: SlideTransition(
                        position: _offsetLeftEnter,
                        child: Card(
                          color: Color(0xFF363636),
                          elevation: 10,
                          margin: EdgeInsets.all(10),
                          child: Container(
                              alignment: Alignment.center,
                              width: (SizeConfig.screenWidth / 10) * 6,
                              margin: EdgeInsets.all(20),
                              child: Text("Math Puzzle",
                                  style:
                                      Theme.of(context).textTheme.headline4)),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (tapDownDetails) {
                        GetIt.I<NavigationService>().navigateTo(KeyUtil.Home,
                            arguments: PuzzleType.MEMORY_PUZZLE);
                      },
                      child: SlideTransition(
                        position: _offsetRightEnter,
                        child: Card(
                          color: Color(0xFF363636),
                          elevation: 10,
                          margin: EdgeInsets.all(10),
                          child: Container(
                              alignment: Alignment.center,
                              width: (SizeConfig.screenWidth / 10) * 6,
                              margin: EdgeInsets.all(20),
                              child: Text("Memory Puzzle",
                                  style:
                                      Theme.of(context).textTheme.headline4)),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (tapDownDetails) {
                        GetIt.I<NavigationService>().navigateTo(KeyUtil.Home,
                            arguments: PuzzleType.BRAIN_PUZZLE);
                      },
                      child: SlideTransition(
                        position: _offsetLeftEnter,
                        child: Card(
                          color: Color(0xFF363636),
                          elevation: 10,
                          margin: EdgeInsets.all(10),
                          child: Container(
                              alignment: Alignment.center,
                              width: (SizeConfig.screenWidth / 10) * 6,
                              margin: EdgeInsets.all(20),
                              child: Text("Train Your Brain",
                                  style:
                                      Theme.of(context).textTheme.headline4)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
