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
      customBorder: CircleBorder(),
      onTap: () {
        magicTriangleProvider.inputTriangleSelection(index, input);
      },
      child: Card(
        elevation: 4.0,
        shape: CircleBorder(
          side: BorderSide(
              color: input.value.isNotEmpty ? Theme.of(context).primaryColor : (input.isActive ? Colors.yellow : Colors.grey), width: 3),
        ),
        child: Container(
            child: Center(
          child: Text(
            input.value,
            style: TextStyle(fontSize: 20),
          ),
        )),
      ),
    );
  }
}
