import 'package:flutter/material.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/data/models/number_pyramid.dart';
import 'package:mathgame/src/ui/numberPyramid/number_pyramid_view_model.dart';
import 'package:mathgame/src/core/size_config.dart';
import 'package:provider/provider.dart';

class PyramidNumberBox extends StatelessWidget {
  final NumPyramidCellModel numPyramidCellModel;
  final bool isLeftRadius;
  final bool isRightRadius;
  final double height;

  PyramidNumberBox({
    required this.numPyramidCellModel,
    this.isLeftRadius = false,
    this.isRightRadius = false,
    required   this.height,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                  colors: [Color(0xff4895EF), Color(0xff3f37c9)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          border: Border.all(
            color: numPyramidCellModel.isActive
                ? Color(0xff4895EF)
                : Theme.of(context).colorScheme.dividerColor,
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
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: numPyramidCellModel.isHint
                  ? Theme.of(context).colorScheme.baseColor
                  : Theme.of(context).colorScheme.crossColor),
        ),
      ),
    );
  }
}
