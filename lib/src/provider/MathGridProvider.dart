import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/models/MagicTriangle/MagicTriangleModel.dart';
import 'package:mathgame/src/models/MathGrid/MathGridModel.dart';
import 'package:mathgame/src/resources/MagicTriangle/MagicTriangleDataProvider.dart';
import 'package:mathgame/src/resources/mathGrid/MathGridDataProvider.dart';

class MathGridProvider with ChangeNotifier {
  List<MathGridModel> _list;
  MathGridModel _currentState;
  String _result;
  int _index = 0;
  int answerIndex = 0;
  bool _timeOut;
  int _time;

  bool get timeOut => _timeOut;

  String get result => _result;

  int get time => _time;

  StreamSubscription timerSubscription;

  MathGridModel get currentState => _currentState;

  MathGridProvider() {
    _list = MathGridDataProvider.getMathGridData();
    _currentState = _list[_index];
    _time = 5;
    _timeOut = false;
    _result = "";
//    startTimer();
  }

  void inputTriangleSelection(int index, MathGridModel input) {}

  Future<void> checkResult(int index, MathGridCellModel gridModel) async {
    if (gridModel.isActive == true) {
      gridModel.isActive = false;
      notifyListeners();
      return;
    }
    gridModel.isActive = true;
    int total = 0;
    var listOfIndex = _currentState.listForSquare
        .where((result) => result.isActive == true)
        .toList();

    for (int i = 0; i < listOfIndex.length; i++) {
      total = total + listOfIndex[i].value;
    }

    if (_currentState.currentAnswer == total) {
      for (int i = 0; i < listOfIndex.length; i++) {
        listOfIndex[i].isActive = false;
        listOfIndex[i].isRemoved = true;
      }
      answerIndex = answerIndex + 1;
      _currentState.currentAnswer = _currentState.listOfAnswer[answerIndex];
    }
    print("total $total");
    notifyListeners();
  }

  clear() {
    _result = "";
    notifyListeners();
  }

  void startTimer() {
    timerSubscription = Stream.periodic(Duration(seconds: 1), (x) => 6 - x - 1)
        .take(6)
        .listen((time) {
      _time = time;
      notifyListeners();
    }, onDone: () {
      this._timeOut = true;
      notifyListeners();
    });
  }

  void restartTimer() {
    timerSubscription.cancel();
    startTimer();
  }

  void dispose() {
    this.timerSubscription.cancel();
  }
}
