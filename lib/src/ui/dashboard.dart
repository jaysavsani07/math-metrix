import 'package:flutter/material.dart';

import 'home.dart';

class DashBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.green,
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: RaisedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage()));
                },
                child: Text("Math puzzle"),
              ),
            ),
            Card(
              child: Text("Math Puzzle"),
            ),
            Card(
              child: Text("Math Puzzle"),
            )
          ],
        ),
      ),
    );
  }
}
