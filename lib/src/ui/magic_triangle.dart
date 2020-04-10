import 'package:flutter/material.dart';
import 'package:mathgame/src/ui/TrianglePainter.dart';

class MagicTriangle extends StatelessWidget {
  double padding = 20;
  double radius = 40;
  double triangleHeight;

  @override
  Widget build(BuildContext context) {
    triangleHeight = (MediaQuery.of(context).size.width) * 0.8660254;
    return Scaffold(
        appBar: AppBar(
          title: Text("Blade Runner"),
        ),
        body: Column(children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              constraints: BoxConstraints.expand(),
              color: Colors.blue,
              width: 0.0,
              height: 0.0,
            ),
          ),
          Expanded(
            flex: 6,
            child: Stack(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
//                      padding: EdgeInsets.all(20),
                      color: Colors.yellow[200],
                      child: Container(
                          color: Colors.red,
                          child: Row(
                            children: <Widget>[
                              CustomPaint(
                                painter: TrianglePainter(),
                                size: Size(
                                    (MediaQuery.of(context).size.width),
                                    triangleHeight),
                              )
                            ],
                          )),
                    ),
                    Positioned(
                      top: padding,
                      left: MediaQuery.of(context).size.width / 2 -  radius,
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(radius)),
                              border: Border.all(color: Colors.red)),
//                          color: Colors.red,
                          child: Center(
                            child: Text(
                              "50",
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                      height: (radius * 2 ),
                      width: (radius * 2 ),
                    ), // first
                    Positioned(
                      top: triangleHeight / 2 - (padding * 2),
                      left: (MediaQuery.of(context).size.width / 4) - padding / 2,
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.grey,
                              borderRadius:
                              BorderRadius.all(Radius.circular(radius)),
                              border: Border.all(color: Colors.red)),
//                          color: Colors.red,
                          child: Center(
                            child: Text(
                              "50",
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                      height: (radius * 2 ),
                      width: (radius * 2 ),
                    ),  // second one
                    Positioned(
                      top: triangleHeight / 2 - (padding * 2),
                      left: (MediaQuery.of(context).size.width / 4 - (radius / 2 )) * 3 - padding / 2,
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.grey,
                              borderRadius:
                              BorderRadius.all(Radius.circular(radius)),
                              border: Border.all(color: Colors.red)),
//                          color: Colors.red,
                          child: Center(
                            child: Text(
                              "50",
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                      height: (radius * 2 ),
                      width: (radius * 2 ),
                    ), // third
                    Positioned(
                      top: triangleHeight - padding - radius * 2,
                      left: padding,
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(radius)),
                              border: Border.all(color: Colors.red)),
//                          color: Colors.red,
                          child: Center(
                            child: Text(
                              "50",
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                      height: (radius * 2 ),
                      width: (radius * 2 ),
                    ), // fourth
                    Positioned(
                      top: triangleHeight - (radius * 3) + padding,
                      left: MediaQuery.of(context).size.width / 2 - radius,
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.grey,
                              borderRadius:
                              BorderRadius.all(Radius.circular(radius)),
                              border: Border.all(color: Colors.red)),
//                          color: Colors.red,
                          child: Center(
                            child: Text(
                              "50",
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                      height: (radius * 2 ),
                      width: (radius * 2 ),
                    ), // fifth
                    Positioned(
                      top: triangleHeight - ((radius * 2 + padding)),
                      right: padding,
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.grey,
                              borderRadius:
                              BorderRadius.all(Radius.circular(radius)),
                              border: Border.all(color: Colors.red)),
//                          color: Colors.red,
                          child: Center(
                            child: Text(
                              "50",
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                      height: (radius * 2 ),
                      width: (radius * 2 ),
                    ), // last one
                  ],
                )
              ],
            ),
          )
        ]));
  }
}
