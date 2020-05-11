import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/resources/navigation_service.dart';
import 'package:provider_architecture/provider_architecture.dart';

import 'package:mathgame/src/provider/dashboardViewModel.dart';

class MyHomePage extends StatelessWidget {
  final PuzzleType puzzleType;
  final String title;

  MyHomePage({Key key, @required this.puzzleType, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
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
                      flex: 10,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                          constraints: BoxConstraints.expand(),
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          alignment: Alignment.center,
                          child: FittedBox(
                            child: Text(title,
                                style: Theme.of(context).textTheme.display2),
                          )),
                    ),
                    Expanded(
                      flex: 70,
                      child: ViewModelProvider<DashboardViewModel>.withConsumer(
                          onModelReady: (model) =>
                              model.getGameByPuzzleType(puzzleType),
                          reuseExisting: true,
                          viewModel: GetIt.I<DashboardViewModel>(),
                          builder: (context, model, child) => GridView.builder(
                                padding: EdgeInsets.only(bottom: 20.0),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      GetIt.I<NavigationService>().navigateTo(
                                          model.list[index].routePath);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(40, 5, 40, 5),
                                      child: Card(
                                        color: Color(0xFF363636),
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
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
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomLeft:
                                                                    Radius.zero,
                                                                bottomRight:
                                                                    Radius
                                                                        .zero)),
                                                    alignment: Alignment.center,
                                                    constraints:
                                                        BoxConstraints.expand(),
                                                    child: Text(
                                                      model.list[index].name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .title,
                                                    )),
                                              ),
                                              Expanded(
                                                flex: 6,
                                                child: Container(
                                                  constraints:
                                                      BoxConstraints.expand(),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                                                child: Text(
                                                                    model
                                                                        .list[
                                                                            index]
                                                                        .scoreboard
                                                                        .highestScore
                                                                        .toString(),
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
                                                                    "Coin",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .subhead),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Center(
                                                                child: Text(
                                                                    model
                                                                        .list[
                                                                            index]
                                                                        .scoreboard
                                                                        .coin
                                                                        .toString(),
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
                                        childAspectRatio: 3.3,
                                        crossAxisCount: 1),
                              )),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.home),
                              onPressed: () {
                                GetIt.I<NavigationService>().goBack();
                              },
                              iconSize: 40,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ))),
      ),
    );
  }
}
