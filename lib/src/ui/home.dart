import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/ui/calculator/calculator.dart';
import 'package:mathgame/src/ui/correctAnswer/correct_answer.dart';
import 'package:mathgame/src/ui/magicTriangle/magic_triangle.dart';
import 'package:mathgame/src/ui/mathGrid/math_grid.dart';
import 'package:mathgame/src/ui/mathPairs/mathPairs.dart';
import 'package:mathgame/src/ui/mentalArithmetic/mental_arithmetic.dart';
import 'package:mathgame/src/ui/quickCalculation/quickCalculation.dart';
import 'package:mathgame/src/ui/squareRoot/square_root.dart';
import 'package:mathgame/src/ui/whatsTheSign/whats_the_sign.dart';
import 'package:provider_architecture/provider_architecture.dart';

import '../utility/dashboardViewModel.dart';

class MyHomePage extends StatelessWidget {
  final PuzzleType puzzleType;

  MyHomePage({Key key, @required this.puzzleType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Math Game"),
        backgroundColor: Colors.transparent,
      ),
      body: ViewModelProvider<DashboardViewModel>.withConsumer(
          onModelReady: (model) => model.getGameByPuzzleType(puzzleType),
          viewModel: GetIt.I<DashboardViewModel>(),
          reuseExisting: true,
          builder: (context, model, child) => GridView.builder(
                padding: EdgeInsets.only(bottom: 80.0),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
//                    color: Theme.of(context).primaryColorLight,
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
                              model.list[index].name,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w800),
                            ),
                            Text(
                              model.list[index].scoreboard.highestScore
                                  .toString(),
                              style: TextStyle(fontSize: 14.0),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        switch (model.list[index].id) {
                          case 1:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Calculator()));
                            break;
                          case 2:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WhatsTheSign()));
                            break;
                          case 3:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SquareRoot()));
                            break;

                          case 4:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MathPairs()));
                            break;
                          case 5:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CorrectAnswer()));
                            break;
                          case 6:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MagicTriangle()));
                            break;
                          case 7:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MentalArithmetic()));
                            break;
                          case 8:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuickCalculation()));
                            break;
                          case 9:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MathGrid()));
                            break;
                        }
                      },
                    ),
                  );
                },
                itemCount: model.list.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
              )),
      backgroundColor: Colors.black,
    );
  }
}
