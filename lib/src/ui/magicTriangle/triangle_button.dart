import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mathgame/src/models/MagicTriangle/MagicTriangleModel.dart';
import 'package:mathgame/src/provider/MagicTriangleProvider.dart';
import 'package:provider/provider.dart';

class TriangleButton extends StatelessWidget {
  final MagicTriangleGrid digit;
  final int index;
  final double size;

  TriangleButton(this.digit, this.index, this.size);

  @override
  Widget build(BuildContext context) {
    final magicTriangleProvider = Provider.of<MagicTriangleProvider>(context);
    return Expanded(
      flex: 1,
      child: Visibility(
        visible: digit.isVisible,
        child: Card(
          shape: CircleBorder(
            side: BorderSide(color: Colors.white70, width: 3),
          ),
          child: Container(
           constraints: BoxConstraints.expand(),
            child: FlatButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                magicTriangleProvider.checkResult(index, digit);
              },
              child: Text(digit.value, style: TextStyle(fontSize: 28)),
            ),
          ),
        ),
      ),
    );
  }
}
