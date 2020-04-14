import 'package:flutter/material.dart';
import 'package:mathgame/src/models/gameCategory.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/ui/calculator/calculator.dart';
import 'package:mathgame/src/ui/correctAnswer/correct_answer.dart';
import 'package:mathgame/src/ui/magicTriangle/magic_triangle.dart';
import 'package:mathgame/src/ui/mathPairs/mathPairs.dart';
import 'package:mathgame/src/ui/squareRoot/square_root.dart';
import 'package:mathgame/src/ui/whatsTheSign/whats_the_sign.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GameCategory> list = GameCategoryProvider.getGameCategoryList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Math Game"),
      ),
      body: GridView.builder(
        padding: EdgeInsets.only(bottom: 80.0),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Theme.of(context).primaryColorLight,
            margin: EdgeInsets.all(7.0),
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(width: 1.5),
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      size: 40,
                    ),
                    Text(
                      list[index].name,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87),
                    )
                  ],
                ),
              ),
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Calculator()));
                    break;
                  case 1:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WhatsTheSign()));
                    break;
                  case 2:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SquareRoot()));
                    break;

                  case 3:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MathPairs()));
                    break;
                  case 4:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CorrectAnswer()));
                    break;
                  case 5:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MagicTriangle()));
                }
              },
            ),
          );
        },
        itemCount: list.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
    );
  }
}
