import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/models/mathPairs/MathPairsRootQandS.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/resources/mathPairs/mathPairsQandSDataProvider.dart';
import 'package:mathgame/src/utility/dashboardViewModel.dart';
import 'package:mathgame/src/utility/scoreUtil.dart';
import 'package:mathgame/src/utility/timeUtil.dart';

class MathPairsProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();

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
    _time = TimeUtil.mathematicalPairsTimeOut;
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
    timerSubscription = Stream.periodic(Duration(seconds: 1),
            (x) => TimeUtil.mathematicalPairsTimeOut - x - 1)
        .take(TimeUtil.mathematicalPairsTimeOut)
        .listen((time) {
      _time = time;
      notifyListeners();
    }, onDone: () {
      homeViewModel.updateScoreboard(GameCategoryType.MATH_PAIRS,
          _index * ScoreUtil.mathematicalPairsScore);
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
