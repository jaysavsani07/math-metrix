import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/data/models/mental_arithmetic.dart';
import 'package:mathgame/src/service/dialog_service.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/data/repository/mental_arithmetic_repository.dart';
import 'package:mathgame/src/service/navigation_service.dart';
import 'package:mathgame/src/core/coin_constant.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/score_constant.dart';
import 'package:mathgame/src/core/time_constant.dart';

class MentalArithmeticProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();
  final DialogService _dialogService = GetIt.I<DialogService>();

  late  List<MentalArithmetic> _list;
  late  MentalArithmetic _currentState;
  late  String _result;
  int _index = 0;

  late  bool _timeOut;
  late  int _time;
  late  bool _localTimeOut;
  bool _pause = false;
  double currentScore = 0;

  bool get timeOut => _timeOut;

  String get result => _result;

  int get time => _time;

  bool get pause => _pause;

  late   StreamSubscription timerSubscription;
  late  StreamSubscription localTimerSubscription;

  MentalArithmetic get currentState => _currentState;

  MentalArithmeticProvider() {
    startGame();
  }

  void startGame() {
    _list = MentalArithmeticRepository.getMentalArithmeticDataList(1);
    _index = 0;
    currentScore = 0;
    _currentState = _list[_index];
    _time = TimeUtil.mentalArithmeticTimeOut;
    _timeOut = false;
    _result = "";
    startTimer();
    startLocalTimer();
    if (homeViewModel.isFirstTime(GameCategoryType.MENTAL_ARITHMETIC)) {
      showInfoDialogWithDelay();
    }
  }

  Future<void> checkResult(String answer) async {
    if (!timeOut &&
        _localTimeOut &&
        _result.length < _currentState.answer.toString().length &&
        ((_result.length == 0 && answer == "-") || (answer != "-"))) {
      _result = _result + answer;
      notifyListeners();
      if (_result != "-" && int.parse(_result) == _currentState.answer) {
        await Future.delayed(Duration(milliseconds: 300));
        if (_list.length - 1 == _index) {
          _list.addAll(
              MentalArithmeticRepository.getMentalArithmeticDataList(
                  _index ~/ 5 + 1));
        }
        _index = _index + 1;
        currentScore = currentScore + ScoreUtil.mentalArithmeticScore;
        _currentState = _list[_index];
        _result = "";
        restartLocalTimer();
        notifyListeners();
      } else if (_result.length == _currentState.answer.toString().length) {
        if (currentScore > 0) {
          currentScore = currentScore + ScoreUtil.mentalArithmeticScoreMinus;
        }
      }
    }
  }

  clear() {
    if (_localTimeOut) {
      if (!timeOut) {
        _result = "";
        notifyListeners();
      }
    }
  }

  void startLocalTimer() {
    _localTimeOut = false;
    _result = "";
    localTimerSubscription = Stream.periodic(Duration(seconds: 1), (x) => x)
        .take(TimeUtil.mentalArithmeticLocalTimeOut)
        .listen((time) {
      _currentState.currentQuestion = _currentState.questionList[time];
      notifyListeners();
    }, onDone: () {
      this._localTimeOut = true;
      notifyListeners();
    });
  }

  void startTimer() {
    timerSubscription = Stream.periodic(Duration(seconds: 1),
            (x) => TimeUtil.mentalArithmeticTimeOut - x - 1)
        .take(TimeUtil.mentalArithmeticTimeOut)
        .listen((time) {
      _time = time;
      notifyListeners();
    }, onDone: () {
      this._timeOut = true;
      showDialog();
      notifyListeners();
    });
  }

  void restartLocalTimer() {
    localTimerSubscription.cancel();
    startLocalTimer();
  }

  void pauseTimer() {
    _pause = true;
    timerSubscription.pause();
    localTimerSubscription.pause();
    notifyListeners();
    showDialog();
  }

  Future showDialog() async {
    notifyListeners();
    var dialogResult = await _dialogService.showDialog(
        type: KeyUtil.GameOverDialog,
        gameCategoryType: GameCategoryType.MENTAL_ARITHMETIC,
        score: currentScore,
        coin: _index * CoinUtil.mentalArithmeticCoin,
        isPause: _pause);

    if (dialogResult.exit) {
      homeViewModel.updateScoreboard(GameCategoryType.MENTAL_ARITHMETIC,
          currentScore, _index * CoinUtil.mentalArithmeticCoin);
      GetIt.I<NavigationService>().goBack();
    } else if (dialogResult.restart) {
      homeViewModel.updateScoreboard(GameCategoryType.MENTAL_ARITHMETIC,
          currentScore, _index * CoinUtil.mentalArithmeticCoin);
      timerSubscription.cancel();
      localTimerSubscription.cancel();
      startGame();
    } else if (dialogResult.play) {
      timerSubscription.resume();
      localTimerSubscription.resume();
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
    localTimerSubscription.pause();
    notifyListeners();
    var dialogResult = await _dialogService.showDialog(
        type: KeyUtil.InfoDialog,
        gameCategoryType: GameCategoryType.MENTAL_ARITHMETIC,
        score: 0,
        coin: 0,
        isPause: false);

    if (dialogResult.exit) {
      homeViewModel.setFirstTime(GameCategoryType.MENTAL_ARITHMETIC);
      timerSubscription.resume();
      localTimerSubscription.resume();
      _pause = false;
      notifyListeners();
    }
  }

  void dispose() {
    super.dispose();
    this.timerSubscription.cancel();
    this.localTimerSubscription.cancel();
  }
}
