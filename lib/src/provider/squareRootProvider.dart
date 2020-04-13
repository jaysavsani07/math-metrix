import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/models/squareRoot/SquareRootQandS.dart';
import 'package:mathgame/src/resources/squareRoot/squareRootQandSDataProvider.dart';

class SquareRootProvider with ChangeNotifier {
  List<SquareRootQandS> _list;
  SquareRootQandS _currentState;
  String _result;
  int _index = 0;

  bool _timeOut;
  int _time;

  bool get timeOut => _timeOut;

  String get result => _result;

  int get time => _time;

  StreamSubscription timerSubscription;

  SquareRootQandS get currentState => _currentState;

  SquareRootProvider() {
    _list = SquareRootQandSDataProvider.getSquareDataList();
    _currentState = _list[_index];
    _time = 5;
    _timeOut = false;
    _result = "";
    startTimer();
  }

  Future<void> checkResult(String answer) async {
    if (!timeOut) {
      _result = answer;
      notifyListeners();
      if (int.parse(_result) == _currentState.answer) {
        await Future.delayed(Duration(milliseconds: 300));
        _index = _index + 1;
        _currentState = _list[_index];
        _result = "";
        restartTimer();
        notifyListeners();
      }
    }
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
