import 'package:flutter/material.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';

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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(
                                puzzleType: PuzzleType.MATH_PUZZLE,
                              )));
                },
                child: Text("Math puzzle"),
              ),
            ),
            Card(
              child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage(
                                  puzzleType: PuzzleType.MEMORY_PUZZLE,
                                )));
                  },
                  child: Text("Math Puzzle")),
            ),
            Card(
              child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage(
                                  puzzleType: PuzzleType.BRAIN_PUZZLE,
                                )));
                  },
                  child: Text("Math Puzzle")),
            )
          ],
        ),
      ),
    );
  }
}
