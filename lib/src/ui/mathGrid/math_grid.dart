import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/MathGridProvider.dart';
import 'package:mathgame/src/ui/calculator/square_button.dart';
import 'package:provider/provider.dart';

class MathGrid extends StatelessWidget {
  List<int> list = List<int>.generate(99, (i) => i + 1);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MathGridProvider>(
      create: (_) => MathGridProvider(),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Math Machine Square"),
          ),
          body: Consumer<MathGridProvider>(
            builder: (context, mathGridProvider, child) {
              return Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              mathGridProvider.currentState.currentAnswer
                                  .toString(),
                              style: TextStyle(fontSize: 40))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 9),
                        itemCount: mathGridProvider
                            .currentState.listForSquare.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SquareButton(
                              mathGridProvider
                                  .currentState.listForSquare[index].value,
                              mathGridProvider
                                  .currentState.listForSquare[index]);
                        }),
                  )
                ],
              );
            },
          )),
    );
  }
}
