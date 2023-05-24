import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathgame/src/core/app_assets.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/ui/app/theme_provider.dart';
import 'package:mathgame/src/ui/common/common_alert_dialog.dart';
import 'package:mathgame/src/ui/common/common_difficulty_view.dart';
import 'package:mathgame/src/ui/common/math_riddle_view.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_button_view.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_provider.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetLeftEnter;
  late Animation<Offset> _offsetRightEnter;
  late bool isHomePageOpen;

  @override
  void initState() {
    super.initState();
    isHomePageOpen = false;
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Theme.of(context).brightness,
      ),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SafeArea(
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.infoDialogBgColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.icTrophy,
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 5),
                              Consumer<DashboardProvider>(
                                builder: (context, model, child) => Text(
                                    model.overallScore.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                        //TODO Remove this when ios version of Math Riddle is live on App Store.
                        if (Platform.isAndroid)
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              showDialog<bool>(
                                context: context,
                                builder: (newContext) {
                                  return CommonAlertDialog(
                                    child: MathRiddleView(),
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .infoDialogBgColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(12.0),
                              child: RepaintBoundary(
                                child: Image.asset(
                                  AppAssets.icAppMathRiddle,
                                  width: 24,
                                  height: 24,
                                )
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(reverse: true),
                                    )
                                    .scaleXY(begin: 1.5, end: 0.8),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        showDialog<bool>(
                          context: context,
                          builder: (newContext) {
                            final model = Provider.of<ThemeProvider>(context,
                                listen: true);
                            return CommonAlertDialog(
                              child: ChangeNotifierProvider.value(
                                value: model,
                                child: CommonDifficultyView(
                                  selectedDifficulty: model.difficultyType,
                                ),
                              ),
                            );
                          },
                          barrierDismissible: false,
                        ).then((value) {});
                      },
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.infoDialogBgColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                            left: 12, top: 12, bottom: 12, right: 8),
                        child: SvgPicture.asset(
                          Theme.of(context).brightness == Brightness.light
                              ? AppAssets.ic3dStairsDark
                              : AppAssets.ic3dStairsLight,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.read<ThemeProvider>().changeTheme();
                      },
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.infoDialogBgColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                            right: 12, top: 12, bottom: 12, left: 8),
                        child: SvgPicture.asset(
                          Theme.of(context).brightness == Brightness.light
                              ? AppAssets.icDarkMode
                              : AppAssets.icLightMode,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                  ],
                ),
                SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 36),
                        Text(
                          "Math Matrix",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Train Your Brain, Improve Your Math Skill",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 14),
                        ),
                        SizedBox(height: 36),
                        DashboardButtonView(
                          dashboard: KeyUtil.dashboardItems[0],
                          position: _offsetLeftEnter,
                          onTab: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              KeyUtil.home,
                              ModalRoute.withName(KeyUtil.dashboard),
                              arguments: Tuple2(KeyUtil.dashboardItems[0],
                                  MediaQuery.of(context).padding.top),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        DashboardButtonView(
                          dashboard: KeyUtil.dashboardItems[1],
                          position: _offsetRightEnter,
                          onTab: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              KeyUtil.home,
                              ModalRoute.withName(KeyUtil.dashboard),
                              arguments: Tuple2(KeyUtil.dashboardItems[1],
                                  MediaQuery.of(context).padding.top),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        DashboardButtonView(
                          dashboard: KeyUtil.dashboardItems[2],
                          position: _offsetLeftEnter,
                          onTab: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              KeyUtil.home,
                              ModalRoute.withName(KeyUtil.dashboard),
                              arguments: Tuple2(KeyUtil.dashboardItems[2],
                                  MediaQuery.of(context).padding.top),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.infoDialogBgColor,
                      borderRadius: BorderRadius.circular(18)),
                  padding: const EdgeInsets.all(12.0),
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text("Math Matrix by Nividata",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.normal)),
                      ),
                      SizedBox(width: 12),
                      FutureBuilder<PackageInfo>(
                        future: PackageInfo.fromPlatform(),
                        builder: (context, snapshot) => Text(
                            "v${snapshot.data?.version}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 14)),
                      ),
                    ],
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
