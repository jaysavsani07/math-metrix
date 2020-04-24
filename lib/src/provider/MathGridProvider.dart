import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/models/MathGrid/MathGridModel.dart';
import 'package:mathgame/src/resources/dialog_service.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';
import 'package:mathgame/src/resources/mathGrid/MathGridDataProvider.dart';
import 'package:mathgame/src/resources/navigation_service.dart';
import 'package:mathgame/src/utility/coinUtil.dart';
import 'package:mathgame/src/provider/dashboardViewModel.dart';
import 'package:mathgame/src/utility/keyUtil.dart';
import 'package:mathgame/src/utility/scoreUtil.dart';
import 'package:mathgame/src/utility/timeUtil.dart';

class MathGridProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();
  final DialogService _dialogService = GetIt.I<DialogService>();

  List<MathGridModel> _list;
  MathGridModel _currentState;
  int _index = 0;
  int answerIndex = 0;
  bool _timeOut;
  int _time;
  bool _pause = false;
  int currentScore = 0;

  bool get timeOut => _timeOut;

  int get time => _time;

  bool get pause => _pause;

  StreamSubscription timerSubscription;

  MathGridModel get currentState => _currentState;

  MathGridProvider() {
    startGame();
  }

  void startGame() {
    _list = MathGridDataProvider.getMathGridData();
    _index = 0;
    currentScore = 0;
    _currentState = _list[_index];
    _time = TimeUtil.mathMachineTimeOut;
    _timeOut = false;
    startTimer();
    if (homeViewModel.isFirstTime(GameCategoryType.MATH_MACHINE)) {
      showInfoDialogWithDelay();
    }
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
      currentScore = currentScore + (ScoreUtil.mathMachineScore).toInt();
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
        gameCategoryType: GameCategoryType.MATH_MACHINE,
        score: currentScore.toDouble(),
        coin: _index * CoinUtil.mathMachineCoin,
        isPause: _pause);

    if (dialogResult.exit) {
      homeViewModel.updateScoreboard(GameCategoryType.MATH_MACHINE,
          currentScore.toDouble(), _index * CoinUtil.mathMachineCoin);
      GetIt.I<NavigationService>().goBack();
    } else if (dialogResult.restart) {
      homeViewModel.updateScoreboard(GameCategoryType.MATH_MACHINE,
          currentScore.toDouble(), _index * CoinUtil.mathMachineCoin);
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
        gameCategoryType: GameCategoryType.MATH_MACHINE,
        score: 0,
        coin: 0,
        isPause: false);

    if (dialogResult.exit) {
      homeViewModel.setFirstTime(GameCategoryType.MATH_MACHINE);
      timerSubscription.resume();
      _pause = false;
      notifyListeners();
    }
  }

  void dispose() {
    this.timerSubscription.cancel();
  }
}
