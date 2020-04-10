import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/calculatorProvider.dart';
import 'package:provider/provider.dart';

class Timer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<CalculatorProvider>(context);
    return Text(timerProvider.time.toString(), style: TextStyle(fontSize: 20));
  }
}
