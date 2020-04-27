import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathgame/src/models/MagicTriangle/MagicTriangleModel.dart';
import 'package:mathgame/src/provider/MagicTriangleProvider.dart';
import 'package:provider/provider.dart';

class TriangleButton extends StatelessWidget {
  final MagicTriangleGrid digit;
  final int index;

  TriangleButton(this.digit, this.index);

  @override
  Widget build(BuildContext context) {
    final magicTriangleProvider = Provider.of<MagicTriangleProvider>(context);
    return Visibility(
      visible: digit.isVisible,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: Card(
        color: Color(0xFF303030),
        shape: CircleBorder(
          side: BorderSide(color: Colors.white70, width: 2),
        ),
        child: Container(
          height: 58,
          width: 58,
          child: FlatButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              magicTriangleProvider.checkResult(index, digit);
            },
            child:
                Text(digit.value, style: Theme.of(context).textTheme.headline),
          ),
        ),
      ),
    );
  }
}
