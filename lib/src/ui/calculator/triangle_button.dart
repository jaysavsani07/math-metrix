import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathgame/src/models/MagicTriangle/MagicTriangleModel.dart';
import 'package:mathgame/src/provider/MagicTriangleProvider.dart';
import 'package:provider/provider.dart';

class TriangleButton extends StatelessWidget {
  final MagicTriangleDigits digit;
  final int index;

  TriangleButton(this.digit, this.index);

  @override
  Widget build(BuildContext context) {
    final magicTriangleProvider = Provider.of<MagicTriangleProvider>(context);
    return Expanded(
      flex: 1,
      child: Visibility(
        visible: digit.isVisible,
        child: Container(
          height: 80,
          width: 80,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey),
          ),
          child: FlatButton(
            onPressed: () {
              magicTriangleProvider.checkResult(index, digit);
            },
            child: Text(digit.value, style: TextStyle(fontSize: 28)),
          ),
        ),
      ),
    );
  }
}
