import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/models/whatsTheSign/SignQandS.dart';
import 'package:mathgame/src/resources/dialog_service.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/resources/navigation_service.dart';
import 'package:mathgame/src/resources/whatsTheSign/signQandSDataProvider.dart';
import 'package:mathgame/src/utility/coinUtil.dart';
import 'package:mathgame/src/provider/dashboardViewModel.dart';
import 'package:mathgame/src/utility/scoreUtil.dart';
import 'package:mathgame/src/utility/timeUtil.dart';

class SignProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();
  final DialogService _dialogService = GetIt.I<DialogService>();

  List<SignQandS> _list;
  SignQandS _currentState;
  String _result;
  int _index = 0;
  int currentScore = 0;

  bool _timeOut;
  int _time;
  bool _pause = false;

  bool get timeOut => _timeOut;

  String get result => _result;

  int get time => _time;

  bool get pause => _pause;

  StreamSubscription timerSubscription;

  SignQandS get currentState => _currentState;

  SignProvider() {
    startGame();
  }

  void startGame() {
    _list = SignQandSDataProvider.getSignDataList(1);
    _currentState = _list[_index];
    _time = TimeUtil.signTimeOut;
    _timeOut = false;
    _result = "";
    startTimer();
  }

  Future<void> checkResult(String answer) async {
    if (!timeOut) {
      _result = answer;
      notifyListeners();
      if (_result == _currentState.sign) {
        print("_index $_index");
        print(" _time = $_time");
        print("current score $currentScore");
        currentScore = currentScore + (ScoreUtil.signScore * _time).toInt();
        restartTimer();
        notifyListeners();
        await Future.delayed(Duration(milliseconds: 300));
        if (_list.length - 1 == _index) {
          _list.addAll(SignQandSDataProvider.getSignDataList(_index ~/ 5 + 1));
        }
        _time=TimeUtil.signTimeOut;
        _index = _index + 1;
        _result = "";
        _currentState = _list[_index];
        notifyListeners();
      }
    }
  }

  clear() {
    _result = "";
    notifyListeners();
  }

  void startTimer() {
    timerSubscription = Stream.periodic(
            Duration(seconds: 1), (x) => TimeUtil.signTimeOut - x - 1)
        .take(TimeUtil.signTimeOut)
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
        gameCategoryType: GameCategoryType.SIGN,
        score: _index * ScoreUtil.signScore,
        coin: _index * CoinUtil.signCoin,
        isPause: _pause);

    if (dialogResult.exit) {
      homeViewModel.updateScoreboard(GameCategoryType.SIGN,
          _index * ScoreUtil.signScore, _index * CoinUtil.signCoin);
      GetIt.I<NavigationService>().goBack();
    } else if (dialogResult.restart) {
      homeViewModel.updateScoreboard(GameCategoryType.SIGN, ScoreUtil.signScore,
          _index * CoinUtil.signCoin);
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
