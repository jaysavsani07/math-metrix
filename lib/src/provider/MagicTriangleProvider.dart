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
    if (input.value.isEmpty) {
      for (int i = 0; i < _currentState.listTriangle.length; i++) {
        _currentState.listTriangle[i].isActive = false;
      }
      selectedTriangleIndex = index;
      _currentState.listTriangle[index].isActive = true;
      notifyListeners();
    } else {
      int listGridIndex = _currentState.listGrid.indexWhere(
          (val) => val.value == input.value && val.isVisible == false);
      _currentState.listTriangle[index] = MagicTriangleInput(false, "");
      _currentState.listGrid[listGridIndex].isVisible = true;
      notifyListeners();
    }
  }

  Future<void> checkResult(int index, MagicTriangleGrid digit) async {
    print(digit.value);

    _currentState.listTriangle[selectedTriangleIndex].value = digit.value;
    _currentState.listGrid[index].isVisible = false;
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
