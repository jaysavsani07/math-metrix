import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/data/models/quick_calculation.dart';
import 'package:mathgame/src/service/dialog_service.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/service/navigation_service.dart';
import 'package:mathgame/src/data/repository/quick_calculation_repository.dart';
import 'package:mathgame/src/core/coin_constant.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/score_constant.dart';
import 'package:mathgame/src/core/time_constant.dart';

class QuickCalculationProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();
  final DialogService _dialogService = GetIt.I<DialogService>();

  List<QuickCalculation> _list;
  QuickCalculation _currentState;
  int _index = 0;
  int _timeLength;
  FixedExtentScrollController _scrollController;
  bool _timeOut;
  double _time;
  bool _pause = false;
  double currentScore = 0;

  bool get timeOut => _timeOut;

  bool get pause => _pause;

  List<QuickCalculation> get list => _list;

  FixedExtentScrollController get scrollController => _scrollController;

  double get time => _time;

  int get timeLength => _timeLength;

  StreamSubscription timerSubscription;

  QuickCalculation get currentState => _currentState;

  QuickCalculationProvider() {
    _scrollController = FixedExtentScrollController();
    startGame();
  }

  void startGame() {
    _list = QuickCalculationRepository.getQuickCalculationDataList(1, 5);
    _index = 0;
    currentScore = 0;
    _currentState = _list[_index];
    _time = 0;
    _timeLength = TimeUtil.quickCalculationTimeOut;
    _timeOut = false;
    _scrollController.jumpToItem(_index);
    _scrollController.notifyListeners();
    notifyListeners();
    startTimer();
    if (homeViewModel.isFirstTime(GameCategoryType.QUICK_CALCULATION)) {
      showInfoDialogWithDelay();
    }
  }

  Future<void> checkResult(String answer) async {
    if (_currentState.userAnswer.length <
            _currentState.answer.toString().length &&
        !timeOut) {
      _currentState.userAnswer = _currentState.userAnswer + answer;
      notifyListeners();
      if (int.parse(_currentState.userAnswer) == _currentState.answer) {
        await Future.delayed(Duration(milliseconds: 300));
        _list.addAll(
            QuickCalculationRepository.getQuickCalculationDataList(
                _index ~/ 5 + 1, 1));
        _index = _index + 1;
        currentScore = currentScore + ScoreUtil.quickCalculationScore;
        if (time >= 0.0125)
          _timeLength = _timeLength + TimeUtil.quickCalculationPlusTime;
        _currentState = _list[_index];
        _scrollController.jumpToItem(_index);
        _scrollController.notifyListeners();
        notifyListeners();
      } else if (_currentState.userAnswer.length ==
          _currentState.answer.toString().length) {
        if (currentScore > 0) {
          currentScore =
              currentScore + ScoreUtil.quickCalculationScoreMinus;
        }
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
      double x =
          (time - ((_timeLength - TimeUtil.quickCalculationTimeOut) * 4)) /
              (TimeUtil.quickCalculationTimeOut * 4);
      _time = x < 0 ? 0 : x;
      notifyListeners();
    }, onDone: () {
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
        type: KeyUtil.GameOverDialog,
        gameCategoryType: GameCategoryType.QUICK_CALCULATION,
        score: currentScore,
        coin: _index * CoinUtil.quickCalculationCoin,
        isPause: _pause);

    if (dialogResult.exit) {
      homeViewModel.updateScoreboard(GameCategoryType.QUICK_CALCULATION,
          currentScore, _index * CoinUtil.quickCalculationCoin);
      GetIt.I<NavigationService>().goBack();
    } else if (dialogResult.restart) {
      homeViewModel.updateScoreboard(GameCategoryType.QUICK_CALCULATION,
          currentScore, _index * CoinUtil.quickCalculationCoin);
      timerSubscription.cancel();
      startGame();
    } else if (dialogResult.play) {
      timerSubscription.resume();
      _pause = false;
      notifyListeners();
    }
    notifyListeners();
  }

  Future showInfoDialogWithDelay() async {
    await Future.delayed(Duration(milliseconds: 500));
    showInfoDialog();
  }

  Future showInfoDialog() async {
    _pause = true;
    timerSubscription.pause();
    notifyListeners();
    var dialogResult = await _dialogService.showDialog(
        type: KeyUtil.InfoDialog,
        gameCategoryType: GameCategoryType.QUICK_CALCULATION,
        score: 0,
        coin: 0,
        isPause: false);

    if (dialogResult.exit) {
      homeViewModel.setFirstTime(GameCategoryType.QUICK_CALCULATION);
      timerSubscription.resume();
      _pause = false;
      notifyListeners();
    }
  }

  void dispose() {
    super.dispose();
    this.timerSubscription.cancel();
  }
}
