import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/models/MathGrid/MathGridModel.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/resources/mathGrid/MathGridDataProvider.dart';
import 'package:mathgame/src/utility/dashboardViewModel.dart';
import 'package:mathgame/src/utility/scoreUtil.dart';
import 'package:mathgame/src/utility/timeUtil.dart';

class MathGridProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();

  List<MathGridModel> _list;
  MathGridModel _currentState;
  int _index = 0;
  int answerIndex = 0;
  bool _timeOut;
  int _time;

  bool get timeOut => _timeOut;

  int get time => _time;

  StreamSubscription timerSubscription;

  MathGridModel get currentState => _currentState;

  MathGridProvider() {
    _list = MathGridDataProvider.getMathGridData();
    _currentState = _list[_index];
    _time = TimeUtil.mathMachineTimeOut;
    _timeOut = false;
    startTimer();
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
    notifyListeners();
  }

  void startTimer() {
    timerSubscription = Stream.periodic(
            Duration(seconds: 1), (x) => TimeUtil.mathMachineTimeOut - x - 1)
        .take(TimeUtil.mathMachineTimeOut)
        .listen((time) {
      _time = time;
      notifyListeners();
    }, onDone: () {
      homeViewModel.updateScoreboard(
          GameCategoryType.MATH_MACHINE, _index * ScoreUtil.mathMachineScore);
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
