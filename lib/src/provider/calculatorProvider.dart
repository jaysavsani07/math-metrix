import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/models/calculator/calculatorQandS.dart';
import 'package:mathgame/src/resources/calculator/calculatorQandSDataProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';

import '../utility/dashboardViewModel.dart';

class CalculatorProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();

  List<CalculatorQandS> _list;
  CalculatorQandS _currentState;
  String _result;
  int _index = 0;

  bool _timeOut;
  int _time;

  bool get timeOut => _timeOut;

  String get result => _result;

  int get time => _time;

  StreamSubscription timerSubscription;

  CalculatorQandS get currentState => _currentState;

  CalculatorProvider() {
    _list = CalculatorQandSDataProvider.getCalculatorDataList(1);
    _currentState = _list[_index];
    _time = 5;
    _timeOut = false;
    _result = "";
    startTimer();
  }

  Future<void> checkResult(String answer) async {
    if (_result.length < 2 && !timeOut) {
      _result = _result + answer;
      notifyListeners();
      if (int.parse(_result) == _currentState.answer) {
        await Future.delayed(Duration(milliseconds: 300));
        if (_list.length - 1 == _index) {
          _list.addAll(CalculatorQandSDataProvider.getCalculatorDataList(
              _index ~/ 5 + 1));
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
      homeViewModel.updateScoreboard(GameCategoryType.CALCULATOR, _index);
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
