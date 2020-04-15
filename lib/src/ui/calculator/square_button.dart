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
          border: Border.all(color: Colors.green),
          color: gridModel.isRemoved
              ? Colors.black
              : (gridModel.isActive ? Colors.blue[100] : Colors.grey[100])),
      child: Visibility(
        visible: !(gridModel.isRemoved),
        child: InkWell(
          onTap: () {
            mathGridProvider.checkResult(value, gridModel);
          },
          child: Center(
            child: Text(value.toString(), style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
