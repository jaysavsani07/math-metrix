import 'package:flutter/material.dart';
import 'package:mathgame/src/provider/signProvider.dart';
import 'package:provider/provider.dart';

class SignButton extends StatelessWidget {
  final int flex;
  final String text;

  SignButton(this.text, this.flex);

  @override
  Widget build(BuildContext context) {
    final signProvider = Provider.of<SignProvider>(context);
    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: () {
          signProvider.checkResult(text);
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.grey),
          ),
          margin: EdgeInsets.all(5),
          constraints: BoxConstraints.expand(),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
