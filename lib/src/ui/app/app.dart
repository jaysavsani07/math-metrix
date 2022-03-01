import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/app_theme.dart';
import 'package:mathgame/src/core/router.dart';
import 'package:mathgame/src/service/navigation_service.dart';
import 'package:mathgame/src/ui/app/theme_provider.dart';
import 'package:mathgame/src/ui/common/dialog_manager.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_view.dart';
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
            builder: (context, widget) => Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) => DialogManager(
                    child: widget!,
                  )),
            ),
            navigatorKey: GetIt.I<NavigationService>().navigatorKey,
            onGenerateRoute: generateRoute,
            initialRoute: KeyUtil.dashboard,
            // home: DashboardView(),
          );
        });
  }
}
