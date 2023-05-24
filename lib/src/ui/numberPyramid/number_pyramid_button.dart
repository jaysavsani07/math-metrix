import 'package:flutter/material.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/data/models/number_pyramid.dart';
import 'package:mathgame/src/ui/numberPyramid/number_pyramid_provider.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class PyramidNumberButton extends StatelessWidget {
  final NumPyramidCellModel numPyramidCellModel;
  final bool isLeftRadius;
  final bool isRightRadius;
  final double height;
  final Tuple2<Color, Color> colorTuple;

  PyramidNumberButton({
    required this.numPyramidCellModel,
    this.isLeftRadius = false,
    this.isRightRadius = false,
    required this.height,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    final numberProvider = Provider.of<NumberPyramidProvider>(context);
    return InkWell(
      onTap: () {
        numberProvider.pyramidBoxSelection(numPyramidCellModel);
      },
      child: Container(
        height: (height / 7) * 0.65,
        width: height / 7,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: numPyramidCellModel.isHint
              ? null
              : (numPyramidCellModel.isDone
                  ? (numPyramidCellModel.isCorrect
                      ? Colors.transparent
                      : Colors.redAccent)
                  : Colors.transparent),
          gradient: numPyramidCellModel.isHint
              ? LinearGradient(
                  colors: [colorTuple.item1, colorTuple.item2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          border: Border.all(
            color: numPyramidCellModel.isActive
                ? colorTuple.item1
                : Theme.of(context).colorScheme.triangleLineColor,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            topRight: isRightRadius ? Radius.circular(8) : Radius.circular(0),
            topLeft: isLeftRadius ? Radius.circular(8) : Radius.circular(0),
          ),
        ),
        child: Text(
          numPyramidCellModel.isHidden
              ? numPyramidCellModel.text
              : numPyramidCellModel.numberOnCell.toString(),
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: numPyramidCellModel.isHint
                  ?  Colors.white
                  : colorTuple.item1),
        ),
      ),
    );
  }
}
