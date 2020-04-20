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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Game',
      theme: ThemeData(
          backgroundColor: Color(0xFF000000),
          brightness: Brightness.dark,
//        primaryColor: Color(0xfffdd835),
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
            color: Colors.grey[900]
          ),*/
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w400),
            subhead: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w400),
            body1: TextStyle(
                fontSize: 38.0,
                fontWeight: FontWeight.w400,
                color: Colors.yellow[300]),
            body2: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400),
            display1: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400),
            display2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
            display3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),
            display4: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w200,
                color: Colors.white),
            button: TextStyle(fontSize: 32.0, fontWeight: FontWeight.normal),
          )),
      home: DashBoardPage(),
    );
  }
}
