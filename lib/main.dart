import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/provider/dashboardViewModel.dart';
import 'package:mathgame/src/resources/dialog_service.dart';
import 'package:mathgame/src/resources/navigation_service.dart';
import 'package:mathgame/src/resources/router.dart';
import 'package:mathgame/src/ui/dashboard.dart';
import 'package:mathgame/src/ui/dialog_manager.dart';
import 'package:mathgame/src/ui/info_dialog_manager.dart';
import 'package:mathgame/src/utility/keyUtil.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

setupServiceLocator() {
  GetIt.I.registerLazySingleton(() => NavigationService());
  GetIt.I.registerSingleton<DashboardViewModel>(DashboardViewModel());
  GetIt.I.registerLazySingleton(() => DialogService());
}

class MyApp extends StatelessWidget {
  final String fontFamily = "Montserrat";

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Math Matrix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: Color(0xFFaa0000),
          brightness: Brightness.dark,
          primaryColor: Colors.deepPurple,
          primaryColorDark: Color(0x673ab7),
          primaryColorLight: Color(0x8561c5),
          primarySwatch: Colors.yellow,
          accentColor: Colors.deepOrange[300],
          scaffoldBackgroundColor: Color(0xFF121212),
          dialogBackgroundColor: Colors.blueGrey[900],
          splashColor: Colors.grey,
          highlightColor: Colors.white60,
          dividerColor: Colors.grey[900],
          applyElevationOverlayColor: true,
          /*cardTheme: CardTheme(

          ),*/
          textTheme: TextTheme(
            display4:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w300),
            display3: TextStyle(
                fontFamily: fontFamily,
                fontWeight: FontWeight.w500,
                color: Colors.white),
            display2: TextStyle(
                fontFamily: fontFamily,
                fontWeight: FontWeight.w400,
                color: Colors.white),
            display1: TextStyle(
                fontFamily: fontFamily,
                fontWeight: FontWeight.w400,
                color: Colors.white),
            headline:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400),
            title:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
            subhead:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400),
            body2:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
            body1:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400),
            caption:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400),
            subtitle:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
            button:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
          )),
      builder: (context, widget) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(
                  child: widget,
                )),
      ),
      navigatorKey: GetIt.I<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: KeyUtil.Dashboard,
      home: DashBoardPage(),
    );
  }
}
