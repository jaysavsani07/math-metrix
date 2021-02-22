import 'package:flutter/material.dart';
import 'package:mathgame/src/data/models/number_pyramid.dart';
import 'package:mathgame/src/ui/numberPyramid/number_pyramid_view_model.dart';
import 'package:mathgame/src/core/size_config.dart';
import 'package:provider/provider.dart';

class PyramidNumberBox extends StatelessWidget {
  final String text;

  final NumPyramidCellModel numPyramidCellModel;

  PyramidNumberBox(this.text, this.numPyramidCellModel);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double boxHeight = (SizeConfig.screenHeight / 100);
    double boxWidth = (SizeConfig.screenWidth / 100);
    final numberProvider = Provider.of<NumberPyramidProvider>(context);
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        numberProvider.pyramidBoxSelection(numPyramidCellModel);
      },
      child: Container(
        height: boxHeight * 4.6,
        width: boxWidth * 12,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: numPyramidCellModel.isHint
                ? Theme.of(context).primaryColorLight
                : (numPyramidCellModel.isDone
                    ? (numPyramidCellModel.isCorrect ? Colors.transparent : Colors.redAccent)
                    : Colors.transparent),
            border: new Border.all(
                color:
                    numPyramidCellModel.isActive ? Colors.yellow : Colors.white,
                width: numPyramidCellModel.isActive ? 2 : 1,
                style: BorderStyle.solid)),
        child: Text(
          numPyramidCellModel.isHidden
              ? numPyramidCellModel.text
              : numPyramidCellModel.numberOnCell.toString(),
          style: Theme.of(context).textTheme.title,
        ),
      ),
    );
  }
}
