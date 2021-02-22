import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/quickCalculation/quick_calculation_view_model.dart';
import 'package:provider/provider.dart';

class QuickCalculationButton extends StatelessWidget {
  final String text;
  final BorderRadius borderRadius;

  QuickCalculationButton(this.text, this.borderRadius);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuickCalculationProvider>(context);
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          if (text == "CLEAR") {
            provider.clear();
          } else {
            provider.checkResult(text);
          }
        },
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: borderRadius,
            border: Border.all(color: Theme.of(context).dividerColor, width: 1),
          ),
          margin: EdgeInsets.all(1),
          constraints: BoxConstraints.expand(),
          child: Center(
            child: Text(
              text,
              style: text == "CLEAR"
                  ? Theme.of(context).textTheme.display1
                  : Theme.of(context).textTheme.display1,
            ),
          ),
        ),
      ),
    );
  }
}
