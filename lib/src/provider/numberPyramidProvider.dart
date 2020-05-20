import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import 'package:mathgame/src/models/numberPyramid/number_pyramid_model.dart';
import 'package:mathgame/src/resources/dialog_service.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';

import 'package:mathgame/src/resources/navigation_service.dart';
import 'package:mathgame/src/resources/numberPyramid/numberPyramidDataProvider.dart';
import 'package:mathgame/src/utility/coinUtil.dart';
import 'package:mathgame/src/provider/dashboardViewModel.dart';
import 'package:mathgame/src/utility/keyUtil.dart';
import 'package:mathgame/src/utility/scoreUtil.dart';
import 'package:mathgame/src/utility/timeUtil.dart';

class NumberPyramidProvider with ChangeNotifier {
  var homeViewModel = GetIt.I<DashboardViewModel>();
  final DialogService _dialogService = GetIt.I<DialogService>();

  List<NumberPyramidModel> _list;
  NumberPyramidModel _currentState;
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

  NumberPyramidModel get currentState => _currentState;

  NumberPyramidProvider() {
    startGame();
  }

  void startGame() {
    _list = NumberPyramidDataProvider.getPyramidDataList(1);
    _index = 0;
    currentScore = 0;
    _lock = false;
    _currentState = _list[_index];
    _time = TimeUtil.numPyramidTimeOut;
    _timeOut = false;
    startTimer();
    if (homeViewModel.isFirstTime(GameCategoryType.NUMBER_PYRAMID)) {
      showInfoDialogWithDelay();
    }

  }

  void pyramidBoxSelection(NumPyramidCellModel model) {
    if (model.isHint) {
      // you can't select/edit hint cell
      return;
    }
    //first find previously selected index
    var previouslySelectedCell =
        _currentState.list.indexWhere((cell) => cell.isActive == true);
    if (!previouslySelectedCell.isNegative) {
      _currentState.list[previouslySelectedCell].isActive = false;
    }
    _currentState.list[model.id - 1].isActive = true;

    notifyListeners();
  }

  void pyramidBoxInputValue(String value) {
    var currentActiveCellIndex =
        _currentState.list.indexWhere((cell) => cell.isActive == true);
    if (value == "CLEAR") {
      // if clear is pressed then empty existing text value and return
      _currentState.list[currentActiveCellIndex].text = "";
      notifyListeners();
      return;
    }
    var listOfCellWithValues =
        _currentState.list.where((cell) => cell.text.isNotEmpty);
    if (value == "DONE") {
      if (listOfCellWithValues.length > 17) {
        checkCorrectValues();
        return;
      } else {
        return;
      }
    }

    var currentCellValue = _currentState.list[currentActiveCellIndex].text;
    if (currentCellValue.isNotEmpty) {
      // check if already have value, then append
      var length = _currentState.list[currentActiveCellIndex].text.length;
      if (length == 3) {
        // can't have more then 3 digits
        return;
      }
      _currentState.list[currentActiveCellIndex].text =
          currentCellValue + value;
    } else {
      // fresh value
      _currentState.list[currentActiveCellIndex].text = value;
    }

    notifyListeners();
  }

  void checkCorrectValues() {
    for (int i = 0; i < _currentState.list.length; i++) {
      if (!_currentState.list[i].isHint) {
        if (!(_currentState.list[i].numberOnCell ==
            int.parse(_currentState.list[i].text))) {
          _currentState.list[i].isCorrect = false;
          _currentState.list[i].isDone = true;
        } else {
          _currentState.list[i].isCorrect = true;
          _currentState.list[i].isDone = true;
        }
      }
    }
    var correctVal = _currentState.list.where((cell) => cell.isCorrect == true);

    if (correctVal.length == 18) {
      _index = _index + 1;
      _currentState = _list[_index];

      currentScore = currentScore + ScoreUtil.numberPyramidScore;
      if (!timeOut) {
        restartTimer();
        notifyListeners();
      }
    }
  }

  void startTimer() {
    timerSubscription = Stream.periodic(
            Duration(seconds: 1), (x) => TimeUtil.numPyramidTimeOut - x - 1)
        .take(TimeUtil.numPyramidTimeOut)
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
        gameCategoryType: GameCategoryType.NUMBER_PYRAMID,
        score: currentScore,
        coin: _index * CoinUtil.numberPyramidCoin,
        isPause: _pause);

    if (dialogResult.exit) {
      homeViewModel.updateScoreboard(GameCategoryType.NUMBER_PYRAMID,
          currentScore, _index * CoinUtil.numberPyramidCoin);
      GetIt.I<NavigationService>().goBack();
    } else if (dialogResult.restart) {
      homeViewModel.updateScoreboard(GameCategoryType.NUMBER_PYRAMID,
          currentScore, _index * CoinUtil.numberPyramidCoin);
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
        gameCategoryType: GameCategoryType.NUMBER_PYRAMID,
        score: 0,
        coin: 0,
        isPause: false);

    if (dialogResult.exit) {
      homeViewModel.setFirstTime(GameCategoryType.NUMBER_PYRAMID);
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
