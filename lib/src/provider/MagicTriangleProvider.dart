import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/models/MagicTriangle/MagicTriangleModel.dart';
import 'package:mathgame/src/resources/MagicTriangle/MagicTriangleDataProvider.dart';

class MagicTriangleProvider with ChangeNotifier {
  List<MagicTriangleModel> _list;
  MagicTriangleModel _currentState;
  String _result;
  int _index = 0;
  int selectedTriangleIndex = 0;
  bool _timeOut;
  int _time;

  bool get timeOut => _timeOut;

  String get result => _result;

  int get time => _time;

  StreamSubscription timerSubscription;

  MagicTriangleModel get currentState => _currentState;

  MagicTriangleProvider() {
    _list = MagicTriangleDataProvider.getTriangleDataProviderList();
    _currentState = _list[_index];
    _time = 5;
    _timeOut = false;
    _result = "";
    startTimer();
  }

  void inputTriangleSelection(int index, MagicTriangleInput input) {
    for (int i = 0; i < _currentState.listInput.length; i++) {
      _currentState.listInput[i].isActive = false;
    }
    selectedTriangleIndex = index;
    _currentState.listInput[index].isActive = true;
    notifyListeners();
  }

  Future<void> checkResult(int index, MagicTriangleDigits digit) async {
    print(digit.value);

    _currentState.listInput[selectedTriangleIndex].value = digit.value;
    _currentState.listDigits[index].isVisible = false;
    notifyListeners();

    /*if (!timeOut) {
      _result = _result + digit;
      notifyListeners();
      if (int.parse(_result) == _currentState.answer) {
        await Future.delayed(Duration(milliseconds: 300));
        _index = _index + 1;
        _currentState = _list[_index];
        _result = "";
        restartTimer();
        notifyListeners();
      }
    }*/
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
