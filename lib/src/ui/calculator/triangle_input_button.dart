import 'package:flutter/material.dart';
import 'package:mathgame/src/models/MagicTriangle/MagicTriangleModel.dart';
import 'package:mathgame/src/provider/MagicTriangleProvider.dart';
import 'package:provider/provider.dart';

class TriangleInputButton extends StatelessWidget {
  final MagicTriangleInput input;
  final int index;

  TriangleInputButton(this.input, this.index);

  @override
  Widget build(BuildContext context) {
    final magicTriangleProvider = Provider.of<MagicTriangleProvider>(context);
    return InkWell(
      onTap: () {
        magicTriangleProvider.inputTriangleSelection(index, input);
      },
      child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(40)),
            border:
                Border.all(color: input.isActive ? Colors.blue : Colors.grey),
          ),
          child: Center(
            child: Text(
              input.value,
              style: TextStyle(fontSize: 20),
            ),
          )),
    );
  }
}
