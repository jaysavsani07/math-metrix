import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/service/navigation_service.dart';
import 'package:mathgame/src/ui/common/home_button_view.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_view_model.dart';

import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class HomeView extends StatefulWidget {
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
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation bgColorTween;
  late Animation<double> elevationTween;
  late Animation<double> radiusTween;
  late Animation<double> heightTween;
  late Animation<TextStyle> textStyleTween;
  late Animation<double> outlineImageBottomPositionTween;
  late Animation<double> fillImageBottomPositionTween;
  late Animation<double> outlineImageRightPositionTween;
  late Animation<double> fillImageRightPositionTween;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    bgColorTween =
        ColorTween(begin: Colors.black, end: Color(0xFF212121)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.8,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    elevationTween = Tween(begin: 0.0, end: 4.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.8,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );
    radiusTween = Tween(begin: 0.0, end: 18.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.8,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );
    heightTween = Tween(begin: 183.0, end: 56.0).animate(animationController);
    textStyleTween = TextStyleTween(
        begin: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
        end: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        )).animate(animationController);

    outlineImageBottomPositionTween =
        Tween(begin: 56.0, end: 56.0).animate(animationController);
    outlineImageRightPositionTween =
        Tween(begin: -50.0, end: -150.0).animate(animationController);
    fillImageBottomPositionTween =
        Tween(begin: 80.0, end: 136.0).animate(animationController);
    fillImageRightPositionTween =
        Tween(begin: -86.0, end: -240.0).animate(animationController);

    super.initState();
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical &&
        scrollInfo.metrics.pixels <= 127) {
      print(scrollInfo.metrics.pixels / 127);
      animationController.animateTo(scrollInfo.metrics.pixels / 127);
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        body: NotificationListener<ScrollNotification>(
          onNotification: _scrollListener,
          child: Container(
            constraints: BoxConstraints.expand(),
            child: Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.only(top: 183),
                  children: Provider.of<DashboardViewModel>(context)
                      .getGameByPuzzleType(widget.puzzleType)
                      .map((e) => HomeButtonView(
                          title: e.name,
                          icon: e.icon,
                          score: e.scoreboard.highestScore,
                          coin: e.scoreboard.coin,
                          colorTuple: widget.colorTuple,
                          opacity: widget.opacity,
                          onTab: () {
                            GetIt.I<NavigationService>().navigateTo(e.routePath,
                                arguments: widget.colorTuple);
                          }))
                      .toList(),
                ),
                AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) => PhysicalModel(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).colorScheme.baseColor
                        : bgColorTween.value,
                    elevation: elevationTween.value,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radiusTween.value),
                        bottomRight: Radius.circular(radiusTween.value)),
                    child: Container(
                      width: double.infinity,
                      height: heightTween.value,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            bottom: fillImageBottomPositionTween.value,
                            right: fillImageRightPositionTween.value,
                            child: Icon(
                              Icons.extension,
                              color: Color(0xffECF0FC),
                              size: 183,
                            ),
                          ),
                          Positioned(
                            bottom: outlineImageBottomPositionTween.value,
                            right: outlineImageRightPositionTween.value,
                            child: Icon(
                              Icons.extension_outlined,
                              color: Color(0xffB8BBED),
                              size: 183,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 7),
                            child: Card(
                              color: Theme.of(context).colorScheme.crossColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
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
                                    color:
                                        Theme.of(context).colorScheme.baseColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 62 * animationController.value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, left: 20),
                              child: Text(
                                widget.title,
                                style: textStyleTween.value,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
