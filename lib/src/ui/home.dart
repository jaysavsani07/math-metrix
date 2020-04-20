import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/homeViewModel.dart';
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

class MyHomePage extends StatelessWidget {
  final PuzzleType puzzleType;

  MyHomePage({Key key, @required this.puzzleType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: true,
          bottom: true,
          child: Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(
                        constraints: BoxConstraints.expand(),
                        alignment: Alignment.center,
                        child: Text("Math Puzzle",
                            style: Theme.of(context).textTheme.display2)),
                  ),
                  Expanded(
                    flex: 74,
                    child: ViewModelProvider<HomeViewModel>.withConsumer(
                        onModelReady: (model) => model.initialise(puzzleType),
                        viewModel: GetIt.I<HomeViewModel>(),
                        builder: (context, model, child) => GridView.builder(
                              padding: EdgeInsets.only(bottom: 80.0),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    switch (model.list[index].id) {
                                      case 1:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Calculator()));
                                        break;
                                      case 2:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WhatsTheSign()));
                                        break;
                                      case 3:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SquareRoot()));
                                        break;

                                      case 4:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MathPairs()));
                                        break;
                                      case 5:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CorrectAnswer()));
                                        break;
                                      case 6:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MagicTriangle()));
                                        break;
                                      case 7:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MentalArithmetic()));
                                        break;
                                      case 8:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    QuickCalculation()));
                                        break;
                                      case 9:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MathGrid()));
                                        break;
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(40, 12, 40, 12),
                                    child: Card(
                                      color: Color(0xFF242424),
                                      elevation: 20,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                  decoration: BoxDecoration(
//                                                    color: Colors.pink[300],
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              topRight: Radius
                                                                  .circular(20),
                                                              bottomLeft:
                                                                  Radius.zero,
                                                              bottomRight:
                                                                  Radius.zero)),
                                                  alignment: Alignment.center,
                                                  constraints:
                                                      BoxConstraints.expand(),
                                                  child: Text(
                                                    model.list[index].name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline,
                                                  )),
                                            ),
                                            Expanded(
                                              flex: 6,
                                              child: Container(
                                                constraints:
                                                    BoxConstraints.expand(),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 1,
                                                            child: Center(
                                                              child: Text(
                                                                  "Score",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .subhead),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Center(
                                                              child: Text("560",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .subhead),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 1,
                                                            child: Center(
                                                              child: Text(
                                                                  "Level",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .subhead),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Center(
                                                              child: Text("24",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .subhead),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: model.list.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 2.8, crossAxisCount: 1),
                            )),
                  ),
                  Expanded(
                    flex: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.home),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          iconSize: 40,
                          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        ),
                        IconButton(
                          icon: Icon(Icons.info_outline),
                          iconSize: 40,
                          padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                        )
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
