import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathgame/src/data/models/magic_triangle.dart';
import 'package:mathgame/src/ui/magicTriangle/magic_triangle_view_model.dart';
import 'package:provider/provider.dart';

class TriangleButton extends StatelessWidget {
  final MagicTriangleGrid digit;
  final int index;

  TriangleButton(this.digit, this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<MagicTriangleProvider>().checkResult(index, digit);
      },
      child: Visibility(
        visible: digit.isVisible,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 8,
          child: Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              border: Border.all(color: Color(0xff4895EF)),
            ),
            alignment: Alignment.center,
            child: Text(
              digit.value,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontSize: 24, color: Color(0xff4895EF)),
            ),
          ),
        ),
      ),
    );
  }
}
