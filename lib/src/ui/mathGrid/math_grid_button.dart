import 'package:flutter/material.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/data/models/math_grid.dart';
import 'package:provider/provider.dart';
import 'package:mathgame/src/ui/mathGrid/math_grid_provider.dart';
import 'package:tuple/tuple.dart';

class MathGridButton extends StatelessWidget {
  final MathGridCellModel gridModel;
  final int index;
  final Tuple2<Color, Color> colorTuple;

  MathGridButton({
    required this.gridModel,
    required this.index,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white24, width: 0.5),
          color: gridModel.isRemoved
              ? Theme.of(context).colorScheme.baseColor
              : (gridModel.isActive
                  ? Theme.of(context).colorScheme.baseColor
                  : Colors.transparent)),
      child: Visibility(
        visible: !(gridModel.isRemoved),
        child: InkWell(
          onTap: () {
            context.read<MathGridProvider>().checkResult(index, gridModel);
          },
          child: Center(
            child: Text(
              gridModel.value.toString(),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: gridModel.isActive ? colorTuple.item1 : Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
