import 'package:flutter/material.dart';
import 'package:mathgame/src/data/models/math_grid.dart';
import 'package:provider/provider.dart';
import 'package:mathgame/src/ui/mathGrid/math_grid_view_model.dart';

class MathGridButton extends StatelessWidget {
  final MathGridCellModel gridModel;
  final int index;

  MathGridButton({required this.gridModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white24, width: 0.5),
          color: gridModel.isRemoved
              ? Colors.white
              : (gridModel.isActive ? Colors.white : Colors.transparent)),
      child: Visibility(
        visible: !(gridModel.isRemoved),
        child: InkWell(
          onTap: () {
            context.read<MathGridProvider>().checkResult(index, gridModel);
          },
          child: Center(
            child: Text(gridModel.value.toString(),
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color:
                        gridModel.isActive ? Color(0xff4895EF) : Colors.white)),
          ),
        ),
      ),
    );
  }
}
