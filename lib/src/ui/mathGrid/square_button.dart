import 'package:flutter/material.dart';
import 'package:mathgame/src/models/MathGrid/MathGridModel.dart';
import 'package:provider/provider.dart';
import 'package:mathgame/src/provider/MathGridProvider.dart';

class SquareButton extends StatelessWidget {
  final int value;
  final MathGridCellModel gridModel;

  SquareButton(this.value, this.gridModel);

  @override
  Widget build(BuildContext context) {
    final mathGridProvider = Provider.of<MathGridProvider>(context);
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          color: gridModel.isRemoved
              ? Colors.grey[800]
              : (gridModel.isActive ? Theme.of(context).accentColor : Colors.grey[900])),
      child: Visibility(
        visible: !(gridModel.isRemoved),
        child: InkWell(
          onTap: () {
            mathGridProvider.checkResult(value, gridModel);
          },
          child: Center(
            child: Text(value.toString(), style: Theme.of(context).textTheme.subhead),
          ),
        ),
      ),
    );
  }
}
