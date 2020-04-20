import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/utility/dashboardViewModel.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/ui/home.dart';
import 'package:provider_architecture/provider_architecture.dart';

class DashBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ViewModelProvider.withConsumer(
          reuseExisting: true,
          viewModel: GetIt.I<DashboardViewModel>(),
          onModelReady: (model) => model.initialise(),
          builder: (context, model, child) => Container(
                color: Colors.green,
                constraints: BoxConstraints.expand(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Overall score ${model.overallScore}"),
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
              )),
    );
  }
}
