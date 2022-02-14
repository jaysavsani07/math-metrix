import 'dart:async';
import 'package:mathgame/src/data/models/picture_puzzle.dart';
import 'package:mathgame/src/ui/common/game_provider.dart';
import 'package:mathgame/src/core/app_constant.dart';

class PicturePuzzleProvider extends GameProvider<PicturePuzzle> {
  late String _result;

  String get result => _result;

  PicturePuzzleProvider()
      : super(gameCategoryType: GameCategoryType.PICTURE_PUZZLE) {
    _result = "";
    startGame();
  }

  void checkGameResult(String answer) async {
    if (_result.length < currentState.answer.toString().length &&
        timerStatus != TimerStatus.pause) {
      _result = _result + answer;
      notifyListeners();
      if (int.parse(_result) == currentState.answer) {
        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired();
        _result = "";
        if (timerStatus != TimerStatus.pause) {
          startTimer();
        }
        notifyListeners();
      } else if (_result.length == currentState.answer.toString().length) {
        wrongAnswer();
      }
    }
  }

  void backPress() {
    if (_result.length > 0) {
      _result = _result.substring(0, _result.length - 1);
      notifyListeners();
    }
  }

  void clearResult() {
    _result = "";
    notifyListeners();
  }
}
