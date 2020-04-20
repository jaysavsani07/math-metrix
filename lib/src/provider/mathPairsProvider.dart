import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/models/mathPairs/MathPairsRootQandS.dart';
import 'package:mathgame/src/resources/mathPairs/mathPairsQandSDataProvider.dart';

class MathPairsProvider with ChangeNotifier {
  List<MathPairsQandS> _list;
  MathPairsQandS _currentState;
  int _index = 0;
  int first = -1;
  int second = -1;

  bool _timeOut;
  int _time;

  bool get timeOut => _timeOut;

  int get time => _time;

  StreamSubscription timerSubscription;

  MathPairsQandS get currentState => _currentState;

  MathPairsProvider() {
    _list = MathPairsQandSDataProvider.getMathPairsDataList(1);
    _currentState = _list[_index];
    _time = 120;
    _timeOut = false;
    startTimer();
  }

  Future<void> checkResult(MathPair mathPair, int index) async {
    if (!timeOut) {
      _currentState.list[index].isActive = true;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 300));
      if (first != -1) {
        print(_currentState.list[first]);
        print(_currentState.list[index]);
        if (_currentState.list[first].uid == _currentState.list[index].uid) {
          _currentState.list[first].isVisible = false;
          _currentState.list[index].isVisible = false;

          _currentState.availableItem = _currentState.availableItem - 2;
          first = -1;
          notifyListeners();
          if (_currentState.availableItem == 0) {
            await Future.delayed(Duration(milliseconds: 300));
            if (_list.length - 1 == _index) {
              _list.addAll(MathPairsQandSDataProvider.getMathPairsDataList(
                  _index ~/ 5 + 1));
            }
            _index = _index + 1;
            _currentState = _list[_index];
            restartTimer();
            notifyListeners();
          }
        } else {
          _currentState.list[first].isActive = false;
          _currentState.list[index].isActive = false;
          first = -1;
          notifyListeners();
        }
      } else {
        first = index;
      }
    }
  }

  void startTimer() {
    timerSubscription =
        Stream.periodic(Duration(seconds: 1), (x) => 120 - x - 1)
            .take(120)
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
