import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/models/MagicTriangle/MagicTriangleModel.dart';
import 'package:mathgame/src/resources/MagicTriangle/MagicTriangleDataProvider.dart';
import 'package:mathgame/src/resources/dialog_service.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/resources/navigation_service.dart';
import 'package:mathgame/src/utility/coinUtil.dart';
import 'package:mathgame/src/provider/dashboardViewModel.dart';
import 'package:mathgame/src/utility/scoreUtil.dart';
import 'package:mathgame/src/utility/timeUtil.dart';

class MagicTriangleProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();
  final DialogService _dialogService = GetIt.I<DialogService>();

  List<MagicTriangleModel> _list;
  MagicTriangleModel _currentState;
  int _index = 0;
  int selectedTriangleIndex = 0;
  bool _timeOut;
  int _time;
  bool _pause = false;
  int currentScore = 0 ;

  bool get timeOut => _timeOut;

  int get time => _time;

  bool get pause => _pause;

  StreamSubscription timerSubscription;

  MagicTriangleModel get currentState => _currentState;

  MagicTriangleProvider() {
    startGame();
  }

  void startGame() {
    _list = MagicTriangleDataProvider.getTriangleDataProviderList();
    _currentState = _list[_index];
    _time = TimeUtil.magicTriangleTimeOut;
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

  Future<void> checkResult(int index, MagicTriangleGrid digit) async    {
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
          currentScore = currentScore + (ScoreUtil.magicTriangleScore).toInt();
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
    timerSubscription = Stream.periodic(
            Duration(seconds: 1), (x) => TimeUtil.magicTriangleTimeOut - x - 1)
        .take(TimeUtil.magicTriangleTimeOut)
        .listen((time) {
      _time = time;
      notifyListeners();
    }, onDone: () {
      this._timeOut = true;
      showDialog();
      notifyListeners();
    });
  }

  void restartTimer() {
    timerSubscription.cancel();
    startTimer();
  }

  void pauseTimer() {
    _pause = true;
    timerSubscription.pause();
    notifyListeners();
    showDialog();
  }

  Future showDialog() async {
    notifyListeners();
    var dialogResult = await _dialogService.showDialog(
        gameCategoryType: GameCategoryType.MAGIC_TRIANGLE,
        score: _index * ScoreUtil.magicTriangleScore,
        coin: _index * CoinUtil.magicTriangleCoin,
        isPause: _pause);

    if (dialogResult.exit) {
      homeViewModel.updateScoreboard(
          GameCategoryType.MAGIC_TRIANGLE,
          _index * ScoreUtil.magicTriangleScore,
          _index * CoinUtil.magicTriangleCoin);
      GetIt.I<NavigationService>().goBack();
    } else if (dialogResult.restart) {
      homeViewModel.updateScoreboard(
          GameCategoryType.MAGIC_TRIANGLE,
          _index * ScoreUtil.magicTriangleScore,
          _index * CoinUtil.magicTriangleCoin);
      timerSubscription.cancel();
      _index = 0;
      startGame();
    } else if (dialogResult.play) {
      timerSubscription.resume();
      _pause = false;
      notifyListeners();
    }
    notifyListeners();
  }

  void dispose() {
    this.timerSubscription.cancel();
  }
}
