import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/data/models/math_grid.dart';
import 'package:mathgame/src/service/dialog_service.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/data/repository/math_grid_repository.dart';
import 'package:mathgame/src/service/navigation_service.dart';
import 'package:mathgame/src/core/coin_constant.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/score_constant.dart';
import 'package:mathgame/src/core/time_constant.dart';

class MathGridProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();
  final DialogService _dialogService = GetIt.I<DialogService>();

  late  List<MathGrid> _list;
  late  MathGrid _currentState;
  int _index = 0;
  int answerIndex = 0;
  late  bool _timeOut;
  late  int _time;
  bool _pause = false;
  double currentScore = 0;

  bool get timeOut => _timeOut;

  int get time => _time;

  bool get pause => _pause;

  late  StreamSubscription timerSubscription;

  MathGrid get currentState => _currentState;

  MathGridProvider() {
    startGame();
  }

  void startGame() {
    _list = MathGridRepository.getMathGridData();
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

  void inputTriangleSelection(int index, MathGrid input) {}

  Future<void> checkResult(int index, MathGridCellModel gridModel) async {
    if (gridModel.isActive == true) {
      gridModel.isActive = false;
      checkForCorrectAnswer();
      notifyListeners();
      return;
    }

    var listOfUnRemovedIndex = _currentState.listForSquare.where((result) => result.isRemoved == false).toList();
    if (listOfUnRemovedIndex.length <= 12) {
      var possiblePairs = getCountOfPossiblePairs(listOfUnRemovedIndex, _currentState.currentAnswer);
      _index = _index + 1 ;
      _currentState = _list[_index];
    }

    gridModel.isActive = true;
    checkForCorrectAnswer();

    notifyListeners();
  }

  void checkForCorrectAnswer(){
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
      currentScore = currentScore + ScoreUtil.mathMachineScore;
      answerIndex = answerIndex + 1;

      
      _currentState.currentAnswer = _currentState.listOfAnswer[answerIndex];
    }
  }

  int getCountOfPossiblePairs(List<MathGridCellModel> arr, int sum) {
    int count = 0;
    for (int i = 0; i < arr.length; i++) {
      for (int j = (i + 1); j < arr.length; j++) {
        if ((arr[i].value + arr[j].value) == sum) {
          count++;
        }
      }
    }
    return count;
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
        score: currentScore,
        coin: _index * CoinUtil.mathMachineCoin,
        isPause: _pause);

    if (dialogResult.exit) {
      homeViewModel.updateScoreboard(GameCategoryType.MATH_MACHINE,
          currentScore, _index * CoinUtil.mathMachineCoin);
      GetIt.I<NavigationService>().goBack();
    } else if (dialogResult.restart) {
      homeViewModel.updateScoreboard(GameCategoryType.MATH_MACHINE,
          currentScore, _index * CoinUtil.mathMachineCoin);
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
    super.dispose();
    this.timerSubscription.cancel();
  }
}
