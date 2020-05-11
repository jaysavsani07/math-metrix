import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/models/mathPairs/MathPairsRootQandS.dart';
import 'package:mathgame/src/resources/dialog_service.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/resources/mathPairs/mathPairsQandSDataProvider.dart';
import 'package:mathgame/src/resources/navigation_service.dart';
import 'package:mathgame/src/utility/coinUtil.dart';
import 'package:mathgame/src/provider/dashboardViewModel.dart';
import 'package:mathgame/src/utility/keyUtil.dart';
import 'package:mathgame/src/utility/scoreUtil.dart';
import 'package:mathgame/src/utility/timeUtil.dart';

class MathPairsProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();
  final DialogService _dialogService = GetIt.I<DialogService>();

  List<MathPairsQandS> _list;
  MathPairsQandS _currentState;
  int _index = 0;
  int first = -1;
  int second = -1;

  bool _lock;
  bool _timeOut;
  int _time;
  bool _pause = false;
  double currentScore = 0;

  bool get timeOut => _timeOut;

  int get time => _time;

  bool get pause => _pause;

  StreamSubscription timerSubscription;

  MathPairsQandS get currentState => _currentState;

  MathPairsProvider() {
    startGame();
  }

  void startGame() {
    _list = MathPairsQandSDataProvider.getMathPairsDataList(1);
    _index = 0;
    currentScore = 0;
    _lock = false;
    _currentState = _list[_index];
    _time = TimeUtil.mathematicalPairsTimeOut;
    _timeOut = false;
    startTimer();
    if (homeViewModel.isFirstTime(GameCategoryType.MATH_PAIRS)) {
      showInfoDialogWithDelay();
    }
  }

  Future<void> checkResult(MathPair mathPair, int index) async {
    if (!timeOut) {
      _lock = true;
      if (!_currentState.list[index].isActive) {
        _currentState.list[index].isActive = true;
        notifyListeners();
        await Future.delayed(Duration(milliseconds: 300));
        if (first != -1) {
          if (_currentState.list[first].uid == _currentState.list[index].uid) {
            _currentState.list[first].isVisible = false;
            _currentState.list[index].isVisible = false;
            _currentState.availableItem = _currentState.availableItem - 2;
            first = -1;
            currentScore = currentScore + ScoreUtil.mathematicalPairsScore;
            notifyListeners();
            if (_currentState.availableItem == 0) {
              await Future.delayed(Duration(milliseconds: 300));
              if (_list.length - 1 == _index) {
                print("index $_index");
                print("index tild ${_index % 5 + 2}");
                _list.addAll(MathPairsQandSDataProvider.getMathPairsDataList(
                    _index + 2));
              }
              _index = _index + 1;
              _currentState = _list[_index];
              restartTimer();
              notifyListeners();
            }
          } else {
            _currentState.list[first].isActive = false;
            _currentState.list[index].isActive = false;
            if (currentScore > 0) {
              currentScore =
                  currentScore + ScoreUtil.mathematicalPairsScoreMinus;
            }
            first = -1;
            notifyListeners();
          }
        } else {
          first = index;
        }
        _lock = false;
      } else {
        first = -1;
        _currentState.list[index].isActive = false;
        notifyListeners();
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
        type: KeyUtil.GameOverDialog,
        gameCategoryType: GameCategoryType.MATH_PAIRS,
        score: currentScore,
        coin: _index * CoinUtil.mathematicalPairsCoin,
        isPause: _pause);

    if (dialogResult.exit) {
      homeViewModel.updateScoreboard(GameCategoryType.MATH_PAIRS, currentScore,
          _index * CoinUtil.mathematicalPairsCoin);
      GetIt.I<NavigationService>().goBack();
    } else if (dialogResult.restart) {
      homeViewModel.updateScoreboard(GameCategoryType.MATH_PAIRS, currentScore,
          _index * CoinUtil.mathematicalPairsCoin);
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
        gameCategoryType: GameCategoryType.MATH_PAIRS,
        score: 0,
        coin: 0,
        isPause: false);

    if (dialogResult.exit) {
      homeViewModel.setFirstTime(GameCategoryType.MATH_PAIRS);
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
