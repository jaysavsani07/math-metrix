import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/data/models/magic_triangle.dart';
import 'package:mathgame/src/ui/magicTriangle/magic_triangle_view_model.dart';
import 'package:provider/provider.dart';

class TriangleInputButton extends StatelessWidget {
  final MagicTriangleInput input;
  final int index;

  TriangleInputButton(this.input, this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: () {
        context
            .read<MagicTriangleProvider>()
            .inputTriangleSelection(index, input);
      },
      child: Neumorphic(
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(24)),
          depth: -8,
          lightSource: LightSource.topLeft,
          color: Theme.of(context).colorScheme.iconBgColor,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            border:
                input.isActive ? Border.all(color: Color(0xff4895EF)) : null,
            gradient: input.value.isNotEmpty
                ? LinearGradient(
                    colors: [Color(0xff4895EF), Color(0xff3f37c9)],
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
                .subtitle2!
                .copyWith(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
