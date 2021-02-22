import 'dart:async';

import 'package:mathgame/src/data/models/alert_request.dart';
import 'package:mathgame/src/data/models/alert_response.dart';
import 'package:mathgame/src/core/app_constant.dart';

class DialogService {
  Function(AlertRequest) _showDialogListener;
  Completer<AlertResponse> _dialogCompleter;

  void registerDialogListener(Function(AlertRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future<AlertResponse> showDialog(
      {String type,
        GameCategoryType gameCategoryType,
      double score,
      double coin,
      bool isPause}) {
    _dialogCompleter = Completer<AlertResponse>();
    _showDialogListener(AlertRequest(
      type: type,
        gameCategoryType: gameCategoryType,
        score: score,
        coin: coin,
        isPause: isPause));
    return _dialogCompleter.future;
  }

  void dialogComplete(AlertResponse response) {
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }

}
