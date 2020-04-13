import 'package:flutter/material.dart';
import 'package:mathgame/src/models/mathPairs/MathPairsRootQandS.dart';
import 'package:mathgame/src/provider/mathPairsProvider.dart';
import 'package:provider/provider.dart';

class MathPairsButton extends StatelessWidget {
  final int flex;
  final MathPair mathPairs;
  final int index;

  MathPairsButton(this.mathPairs, this.flex, this.index);

  @override
  Widget build(BuildContext context) {
    final mathPairsProvider = Provider.of<MathPairsProvider>(context);
    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: () {
          mathPairsProvider.checkResult(mathPairs, index);
        },
        child: Visibility(
          visible: mathPairs.isVisible,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                  color: mathPairs.isActive ? Colors.blue : Colors.grey),
            ),
            margin: EdgeInsets.all(5),
            constraints: BoxConstraints.expand(),
            child: Center(
              child: Text(
                mathPairs.text,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
