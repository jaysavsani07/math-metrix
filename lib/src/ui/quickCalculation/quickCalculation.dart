import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/quickCalculationProvider.dart';
import 'package:mathgame/src/ui/quickCalculation/quick_calculation_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class QuickCalculation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuickCalculationProvider>(
      create: (_) => QuickCalculationProvider(),
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(20),
          constraints: BoxConstraints.expand(),
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 4,
                  child: SizedBox(
                    child: Align(
                      alignment: Alignment.center,
                      child: Consumer<QuickCalculationProvider>(
                        builder: (context, provider, child) {
                          return AbsorbPointer(
                            absorbing: true,
                            child: CircularPercentIndicator(
                              radius: 200.0,
                              lineWidth: 12.0,
                              animation: true,
                              animateFromLastPercent: true,
                              percent: provider.time,
                              center: CupertinoPicker(
                                itemExtent: 20,
                                diameterRatio: 1,
                                squeeze: 1,
                                scrollController: provider.scrollController,
                                backgroundColor: Colors.transparent,
                                children: provider.list.map((data) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(data.question),
                                      Text(" = "),
                                      Text(data.userAnswer)
                                    ],
                                  );
                                }).toList(),
                                onSelectedItemChanged: (_) {},
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: Colors.blueGrey,
                            ),
                          );
                        },
                      ),
                    ),
                  )),
              Expanded(
                flex: 5,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          QuickCalculationButton("1", 1),
                          QuickCalculationButton("4", 1),
                          QuickCalculationButton("7", 1),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          QuickCalculationButton("2", 1),
                          QuickCalculationButton("5", 1),
                          QuickCalculationButton("8", 1),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          QuickCalculationButton("3", 1),
                          QuickCalculationButton("6", 1),
                          QuickCalculationButton("9", 1),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          QuickCalculationButton("Clear", 1),
                          QuickCalculationButton("0", 1),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
