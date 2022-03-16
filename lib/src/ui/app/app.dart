import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/app_theme.dart';
import 'package:mathgame/src/core/app_routes.dart';
import 'package:mathgame/src/ui/app/theme_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final String fontFamily = "Montserrat";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Consumer<ThemeProvider>(
        builder: (context, ThemeProvider provider, child) {
      return MaterialApp(
        title: 'Math Matrix',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        darkTheme: AppTheme.darkTheme,
        themeMode: provider.themeMode,
        initialRoute: KeyUtil.splash,
        routes: appRoutes,
        // home: DashboardView(),
      );
    });
  }
}
