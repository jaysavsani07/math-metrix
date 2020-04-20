import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/models/quickCalculation/quickCalculationQandS.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/resources/quickCalculation/quickCalculationQandSDataProvider.dart';
import 'package:mathgame/src/utility/dashboardViewModel.dart';

class QuickCalculationProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();

  List<QuickCalculationQandS> _list;
  QuickCalculationQandS _currentState;
  int _index = 0;
  int _timeLength = 60;
  FixedExtentScrollController _scrollController;
  bool _timeOut;
  double _time;

  bool get timeOut => _timeOut;

  List<QuickCalculationQandS> get list => _list;

  FixedExtentScrollController get scrollController => _scrollController;

  double get time => _time;

  int get timeLength => _timeLength;

  StreamSubscription timerSubscription;

  QuickCalculationQandS get currentState => _currentState;

  QuickCalculationProvider() {
    _scrollController = FixedExtentScrollController();
    _list = QuickCalculationQandSDataProvider.getQuickCalculationDataList(1, 5);
    _currentState = _list[_index];
    _time = 0;
    _timeOut = false;
    startTimer();
  }

  Future<void> checkResult(String answer) async {
    if (_currentState.userAnswer.length < 2 && !timeOut) {
      _currentState.userAnswer = _currentState.userAnswer + answer;
      notifyListeners();
      if (int.parse(_currentState.userAnswer) == _currentState.answer) {
        await Future.delayed(Duration(milliseconds: 300));
        _list.addAll(
            QuickCalculationQandSDataProvider.getQuickCalculationDataList(
                _index ~/ 5 + 1, 1));
        _index = _index + 1;
        _timeLength = _timeLength + 8;
        _currentState = _list[_index];
        scrollController.jumpToItem(_index);
        scrollController.notifyListeners();
        notifyListeners();
      }
    }
  }

  clear() {
    _currentState.userAnswer = "";
    notifyListeners();
  }

  void startTimer() {
    timerSubscription = Stream.periodic(Duration(milliseconds: 250), (x) => x)
        .takeWhile((time) => time <= _timeLength)
        .listen((time) {
      homeViewModel.updateScoreboard(GameCategoryType.QUICK_CALCULATION, _index);
      _time = time / _timeLength;
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
