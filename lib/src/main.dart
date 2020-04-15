import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Game',
      theme: ThemeData(
          backgroundColor: Color(0xFF121212),
          brightness: Brightness.dark,
//        primaryColor: Color(0xfffdd835),
          primaryColor: Colors.deepPurple,
          primaryColorDark: Color(0x673ab7),
          primaryColorLight: Color(0x8561c5),
          primarySwatch: Colors.yellow,
          scaffoldBackgroundColor: Color(0xFF121212),
          dialogBackgroundColor: Colors.blueGrey[900],
          applyElevationOverlayColor: true,
          cardTheme: CardTheme(
            color: Colors.grey[900]
          ),
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 70.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w400),
            subhead: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w400),
            button: TextStyle(fontSize: 32.0, fontWeight: FontWeight.normal),
          )),
      home: MyHomePage(),
    );
  }
}
