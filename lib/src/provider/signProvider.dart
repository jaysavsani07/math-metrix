import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathgame/src/models/whatsTheSign/SignQandS.dart';
import 'package:mathgame/src/resources/whatsTheSign/signQandSDataProvider.dart';

class SignProvider with ChangeNotifier {
  List<SignQandS> _list;
  SignQandS _currentState;
  String _result;
  int _index = 0;

  bool _timeOut;
  int _time;

  bool get timeOut => _timeOut;

  String get result => _result;

  int get time => _time;

  StreamSubscription timerSubscription;

  SignQandS get currentState => _currentState;

  SignProvider() {
    _list = SignQandSDataProvider.getSignDataList(1);
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
      if (_result == _currentState.sign) {
        await Future.delayed(Duration(milliseconds: 300));
        if (_list.length - 1 == _index) {
          _list.addAll(SignQandSDataProvider.getSignDataList(_index ~/ 5 + 1));
        }
        _index = _index + 1;
        _result = "";
        _currentState = _list[_index];
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
