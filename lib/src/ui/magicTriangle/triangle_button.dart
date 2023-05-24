import 'package:flutter/material.dart';
import 'package:mathgame/src/data/models/magic_triangle.dart';
import 'package:mathgame/src/ui/magicTriangle/magic_triangle_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class TriangleButton extends StatelessWidget {
  final MagicTriangleGrid digit;
  final int index;
  final Tuple2<Color, Color> colorTuple;

  const TriangleButton({
    Key? key,
    required this.colorTuple,
    required this.digit,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: digit.isVisible,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 2,
        child: InkWell(
          onTap: () {
            context.read<MagicTriangleProvider>().checkResult(index, digit);
          },
          borderRadius: BorderRadius.circular(24),
          child: Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              border: Border.all(color: colorTuple.item1),
            ),
            alignment: Alignment.center,
            child: Text(
              digit.value,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 24, color: colorTuple.item1),
            ),
          ),
        ),
      ),
    );
  }
}
