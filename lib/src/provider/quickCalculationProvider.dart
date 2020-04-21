import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/models/quickCalculation/quickCalculationQandS.dart';
import 'package:mathgame/src/resources/dialog_service.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/resources/navigation_service.dart';
import 'package:mathgame/src/resources/quickCalculation/quickCalculationQandSDataProvider.dart';
import 'package:mathgame/src/utility/coinUtil.dart';
import 'package:mathgame/src/provider/dashboardViewModel.dart';
import 'package:mathgame/src/utility/scoreUtil.dart';
import 'package:mathgame/src/utility/timeUtil.dart';

class QuickCalculationProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();
  final DialogService _dialogService = GetIt.I<DialogService>();

  List<QuickCalculationQandS> _list;
  QuickCalculationQandS _currentState;
  int _index = 0;
  int _timeLength;
  FixedExtentScrollController _scrollController;
  bool _timeOut;
  double _time;
  bool _pause = false;

  bool get timeOut => _timeOut;

  bool get pause => _pause;

  List<QuickCalculationQandS> get list => _list;

  FixedExtentScrollController get scrollController => _scrollController;

  double get time => _time;

  int get timeLength => _timeLength;

  StreamSubscription timerSubscription;

  QuickCalculationQandS get currentState => _currentState;

  QuickCalculationProvider() {
    startGame();
  }

  void startGame() {
    _scrollController = FixedExtentScrollController();
    _list = QuickCalculationQandSDataProvider.getQuickCalculationDataList(1, 5);
    _currentState = _list[_index];
    _time = 0;
    _timeLength = TimeUtil.quickCalculationTimeOut;
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
        _timeLength = _timeLength + TimeUtil.quickCalculationPlusTime * 4;
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
        .takeWhile((time) => time <= _timeLength * 4)
        .listen((time) {
      _time = time / (_timeLength * 4);
      notifyListeners();
    }, onDone: () {
      homeViewModel.updateScoreboard(
          GameCategoryType.QUICK_CALCULATION,
          _index * ScoreUtil.quickCalculationScore,
          _index * CoinUtil.quickCalculationCoin);
      showDialog();
      this._timeOut = true;
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
        gameCategoryType: GameCategoryType.QUICK_CALCULATION,
        score: _index * ScoreUtil.quickCalculationScore,
        coin: _index * CoinUtil.quickCalculationCoin,
        isPause: _pause);

    if (dialogResult.exit) {
      homeViewModel.updateScoreboard(
          GameCategoryType.QUICK_CALCULATION,
          _index * ScoreUtil.quickCalculationScore,
          _index * CoinUtil.quickCalculationCoin);
      GetIt.I<NavigationService>().goBack();
    } else if (dialogResult.restart) {
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
