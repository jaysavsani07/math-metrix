import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/provider/dashboardViewModel.dart';
import 'package:mathgame/src/ui/dashboard.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

setupServiceLocator() {
  GetIt.I.registerSingleton<DashboardViewModel>(DashboardViewModel());
}

class MyApp extends StatelessWidget {
  final String fontFamily = "Montserrat";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Game',
      theme: ThemeData(
          backgroundColor: Color(0xFFaa0000),
          brightness: Brightness.dark,
          primaryColor: Colors.deepPurple,
          primaryColorDark: Color(0x673ab7),
          primaryColorLight: Color(0x8561c5),
          primarySwatch: Colors.yellow,
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
            display3:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
            display2: TextStyle(
                fontFamily: fontFamily,
                fontWeight: FontWeight.w400,
                color: Colors.white),
            display1:
                TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400),
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
      home: DashBoardPage(),
    );
  }
}
