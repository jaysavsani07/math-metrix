import 'package:flutter/material.dart';
import 'package:mathgame/src/data/models/magic_triangle.dart';
import 'package:mathgame/src/ui/common/common_neumorphic_view.dart';
import 'package:mathgame/src/ui/magicTriangle/magic_triangle_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class TriangleInputButton extends StatelessWidget {
  final MagicTriangleInput input;
  final int index;
  final Tuple2<Color, Color> colorTuple;

  TriangleInputButton({
    required this.input,
    required this.index,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(24)),
      onTap: () {
        context
            .read<MagicTriangleProvider>()
            .inputTriangleSelection(index, input);
      },
      child: CommonNeumorphicView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            border: input.isActive ? Border.all(color: colorTuple.item1) : null,
            gradient: input.value.isNotEmpty
                ? LinearGradient(
                    colors: [colorTuple.item1, colorTuple.item2],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            input.value.toString(),
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
