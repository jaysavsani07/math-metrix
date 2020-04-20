import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/models/MagicTriangle/MagicTriangleModel.dart';
import 'package:mathgame/src/resources/MagicTriangle/MagicTriangleDataProvider.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/utility/dashboardViewModel.dart';

class MagicTriangleProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();

  List<MagicTriangleModel> _list;
  MagicTriangleModel _currentState;
  int _index = 0;
  int selectedTriangleIndex = 0;
  bool _timeOut;
  int _time;

  bool get timeOut => _timeOut;

  int get time => _time;

  StreamSubscription timerSubscription;

  MagicTriangleModel get currentState => _currentState;

  MagicTriangleProvider() {
    _list = MagicTriangleDataProvider.getTriangleDataProviderList();
    _currentState = _list[_index];
    _time = 120;
    _timeOut = false;
    startTimer();
  }

  void inputTriangleSelection(int index, MagicTriangleInput input) {
    if (!timeOut) {
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
        _currentState.listTriangle[index].isActive = false;
        _currentState.listTriangle[index].value = "";
        _currentState.availableDigit = _currentState.availableDigit + 1;
        _currentState.listGrid[listGridIndex].isVisible = true;
        notifyListeners();
      }
    }
  }

  Future<void> checkResult(int index, MagicTriangleGrid digit) async {
    if (!timeOut) {
      int activeTriangelIndex =
          _currentState.listTriangle.indexWhere((val) => val.isActive == true);
      if (_currentState.listTriangle[activeTriangelIndex].value.isNotEmpty) {
        return;
      }
      _currentState.listTriangle[selectedTriangleIndex].value = digit.value;
      _currentState.listGrid[index].isVisible = false;
      _currentState.availableDigit = _currentState.availableDigit - 1;
      if (_currentState.availableDigit == 0) {
        // check if total of triangle is as per given answer
        int sumOfLeftSide = (int.parse(_currentState.listTriangle[0].value) +
            int.parse(_currentState.listTriangle[1].value) +
            int.parse(_currentState.listTriangle[3].value));
        int sumOfRightSide = (int.parse(_currentState.listTriangle[0].value) +
            int.parse(_currentState.listTriangle[2].value) +
            int.parse(_currentState.listTriangle[5].value));
        int sumOfBottomSide = (int.parse(_currentState.listTriangle[3].value) +
            int.parse(_currentState.listTriangle[4].value) +
            int.parse(_currentState.listTriangle[5].value));
        if (_currentState.answer == sumOfLeftSide &&
            _currentState.answer == sumOfRightSide &&
            _currentState.answer == sumOfBottomSide) {
          print("voila it's correct");
          await Future.delayed(Duration(milliseconds: 300));
          _index = _index + 1;
          _currentState = _list[_index];
          restartTimer();
          notifyListeners();
        }
      }
      notifyListeners();
    }
  }

  clear() {
    notifyListeners();
  }

  void startTimer() {
    timerSubscription =
        Stream.periodic(Duration(seconds: 1), (x) => 120 - x - 1)
            .take(120)
            .listen((time) {
      _time = time;
      notifyListeners();
    }, onDone: () {
      homeViewModel.updateScoreboard(GameCategoryType.MAGIC_TRIANGLE, _index);
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
