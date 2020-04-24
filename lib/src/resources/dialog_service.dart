import 'dart:async';

import 'package:mathgame/src/models/alert_request.dart';
import 'package:mathgame/src/models/alert_response.dart';
import 'package:mathgame/src/resources/gameCategoryDataProvider.dart';

class DialogService {
  Function(AlertRequest) _showDialogListener;
  Completer<AlertResponse> _dialogCompleter;

  Function(AlertRequest) _showInfoDialogListener;
  Completer<AlertResponse> _dialogInfoCompleter;

  void registerDialogListener(Function(AlertRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  void registerInfoDialogListener(Function(AlertRequest) showInfoDialogListener) {
    _showInfoDialogListener = showInfoDialogListener;
  }

  Future<AlertResponse> showDialog(
      {GameCategoryType gameCategoryType,
      double score,
      double coin,
      bool isPause}) {
    _dialogCompleter = Completer<AlertResponse>();
    _showDialogListener(AlertRequest(
        gameCategoryType: gameCategoryType,
        score: score,
        coin: coin,
        isPause: isPause));
    return _dialogCompleter.future;
  }

  Future<AlertResponse> showInfoDialog(
      {GameCategoryType gameCategoryType,
        double score,
        double coin,
        bool isPause}) {
    _dialogInfoCompleter = Completer<AlertResponse>();
    _showInfoDialogListener(AlertRequest(
        gameCategoryType: gameCategoryType,
        score: score,
        coin: coin,
        isPause: isPause));
    return _dialogInfoCompleter.future;
  }

  void dialogComplete(AlertResponse response) {
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }

  void dialogInfoComplete(AlertResponse response) {
    _dialogInfoCompleter.complete(response);
    _dialogInfoCompleter = null;
  }
}
