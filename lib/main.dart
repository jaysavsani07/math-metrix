import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_view_model.dart';
import 'package:mathgame/src/service/dialog_service.dart';
import 'package:mathgame/src/service/navigation_service.dart';
import 'package:mathgame/src/core/router.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_view.dart';
import 'package:mathgame/src/ui/common/dialog_manager.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MultiProvider(providers: [
    Provider<SharedPreferences>(create: (context) => sharedPreferences),
    ChangeNotifierProxyProvider<SharedPreferences, DashboardViewModel>(
      create: (context) => DashboardViewModel(preferences: sharedPreferences),
      update: (context, value, previous) =>
          DashboardViewModel(preferences: value),
    )
  ], child: MyApp()));
}

setupServiceLocator() {
  GetIt.I.registerLazySingleton(() => NavigationService());
  // GetIt.I.registerSingleton<DashboardViewModel>(DashboardViewModel());
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
        primaryColorDark: Colors.deepPurple[700],
        primaryColorLight: Colors.deepPurple[300],
        /*primaryColorDark: Color(0x673ab7),
          primaryColorLight: Color(0x8561c5),*/
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
        // textTheme: TextTheme(
        //   headline4: TextStyle(
        //       fontFamily: fontFamily, fontWeight: FontWeight.w300),
        //   headline3: TextStyle(
        //       fontFamily: fontFamily,
        //       fontWeight: FontWeight.w500,
        //       color: Colors.white),
        //   headline2: TextStyle(
        //       fontFamily: fontFamily,
        //       fontWeight: FontWeight.w400,
        //       color: Colors.white),
        //   headline1: TextStyle(
        //       fontFamily: fontFamily,
        //       fontWeight: FontWeight.w400,
        //       color: Colors.white),
        //   headline: TextStyle(
        //       fontFamily: fontFamily, fontWeight: FontWeight.w400),
        //   title: TextStyle(
        //       fontFamily: fontFamily, fontWeight: FontWeight.w500),
        //   subhead: TextStyle(
        //       fontFamily: fontFamily, fontWeight: FontWeight.w400),
        //   body2: TextStyle(
        //       fontFamily: fontFamily, fontWeight: FontWeight.w500),
        //   body1: TextStyle(
        //       fontFamily: fontFamily, fontWeight: FontWeight.w400),
        //   caption: TextStyle(
        //       fontFamily: fontFamily, fontWeight: FontWeight.w400),
        //   subtitle: TextStyle(
        //       fontFamily: fontFamily, fontWeight: FontWeight.w500),
        //   button: TextStyle(
        //       fontFamily: fontFamily, fontWeight: FontWeight.w500),
        // ),
      ),
      builder: (context, widget) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(
                  child: widget,
                )),
      ),
      navigatorKey: GetIt.I<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: KeyUtil.Dashboard,
      home: DashboardView(),
    );
  }
}
