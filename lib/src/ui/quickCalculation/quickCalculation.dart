import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/quickCalculationProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/ui/quickCalculation/quick_calculation_button.dart';
import 'package:mathgame/src/ui/timer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class QuickCalculation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuickCalculationProvider>(
      create: (_) => QuickCalculationProvider(),
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          body: SafeArea(
            top: true,
            bottom: true,
            child: Container(
              margin: EdgeInsets.all(20),
              constraints: BoxConstraints.expand(),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Timer(GameCategoryType.QUICK_CALCULATION),
                  ),
                  Expanded(
                      flex: 6,
                      child: Consumer<QuickCalculationProvider>(
                        builder: (context, provider, child) {
                          return AbsorbPointer(
                            absorbing: true,
                            child: CircularPercentIndicator(
                              radius: 230.0,
                              lineWidth: 15.0,
                              animation: true,
                              animateFromLastPercent: true,
                              percent: provider.time,
                              center: CupertinoPicker(
                                itemExtent: 30,
                                diameterRatio: 1,
                                squeeze: 1.4,
                                scrollController: provider.scrollController,
                                backgroundColor: Colors.transparent,
                                children: provider.list.map((data) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(data.question,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline),
                                      Text(" = ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline),
                                      Text(
                                        data.userAnswer,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline,
                                      )
                                    ],
                                  );
                                }).toList(),
                                onSelectedItemChanged: (_) {},
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: Colors.green,
                            ),
                          );
                        },
                      )),
                  Expanded(
                    flex: 9,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 600,
                        width: 400,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    QuickCalculationButton(
                                        "7",
                                        BorderRadius.only(
                                            topLeft: Radius.circular(40))),
                                    QuickCalculationButton(
                                        "8", BorderRadius.all(Radius.zero)),
                                    QuickCalculationButton(
                                        "9",
                                        BorderRadius.only(
                                            topRight: Radius.circular(40)))
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    QuickCalculationButton(
                                        "4", BorderRadius.all(Radius.zero)),
                                    QuickCalculationButton(
                                        "5", BorderRadius.all(Radius.zero)),
                                    QuickCalculationButton(
                                        "6", BorderRadius.all(Radius.zero))
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    QuickCalculationButton(
                                        "1", BorderRadius.all(Radius.zero)),
                                    QuickCalculationButton(
                                        "2", BorderRadius.all(Radius.zero)),
                                    QuickCalculationButton(
                                        "3", BorderRadius.all(Radius.zero))
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    QuickCalculationButton(
                                        "0",
                                        BorderRadius.only(
                                            bottomLeft: Radius.circular(40))),
                                    QuickCalculationButton(
                                        "CLEAR",
                                        BorderRadius.only(
                                            bottomRight: Radius.circular(40)))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Consumer<QuickCalculationProvider>(
                          builder: (context, provider, child) {
                        return InkWell(
                          onTap: () {
                            provider.pauseTimer();
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            child: Center(
                              child: Icon(
                                provider.pause
                                    ? Icons.play_arrow
                                    : Icons.pause,
                                size: 40,
                              ),
                            ),
                          ),
                        );
                      })),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
