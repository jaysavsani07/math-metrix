import 'package:flutter/material.dart';

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            Expanded(flex: 1, child: SizedBox()),
            Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "5+4",
                    style: TextStyle(fontSize: 35),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.grey),
                  ),
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 20),
                  constraints: BoxConstraints.expand(),
                  child: Center(
                    child: Text(
                      "9",
                      style:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
                    ),
                  ),
                )),
            Expanded(
              flex: 5,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        getButtonWidget("1", 1),
                        getButtonWidget("4", 1),
                        getButtonWidget("7", 1),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        getButtonWidget("2", 1),
                        getButtonWidget("5", 1),
                        getButtonWidget("8", 1),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        getButtonWidget("3", 1),
                        getButtonWidget("6", 1),
                        getButtonWidget("9", 1),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        getButtonWidget("Clear", 1),
                        getButtonWidget("0", 1),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(flex: 1, child: SizedBox()),
          ],
        ),
      ),
    );
  }

  Widget getButtonWidget(String text, int flex) {
    return Expanded(
      flex: flex,
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
    );
  }
}
