import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/data/models/alert_request.dart';
import 'package:mathgame/src/data/models/alert_response.dart';
import 'package:mathgame/src/data/models/game_info_dialog.dart';
import 'package:mathgame/src/service/dialog_service.dart';
import 'package:mathgame/src/utility/dialog_info_util.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DialogManager extends StatefulWidget {
  final Widget child;

  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = GetIt.I<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(AlertRequest request) {
    Alert view = request.type == KeyUtil.GameOverDialog
        ? getGameOverDialog(request)
        : getInfoDialog(request);

    view.show();
  }

  Alert getGameOverDialog(AlertRequest request) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      buttonAreaPadding: EdgeInsets.all(5),
      isOverlayTapDismiss: false,
      animationDuration: Duration(milliseconds: 600),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: request.isPause ? Colors.green : Colors.red,
        fontWeight: FontWeight.w900,
        fontSize: 28,
      ),
    );
    return Alert(
      context: context,
      style: alertStyle,
      title: request.isPause ? "Resume Game" : "Game Over",
      buttons: [],
      content: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Your score ${request.score.toInt()}"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {
                  _dialogService.dialogComplete(
                      AlertResponse(exit: true, restart: false, play: false));
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back,
                      size: 40,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !request.isPause,
                child: InkWell(
                  onTap: () {
                    _dialogService.dialogComplete(
                        AlertResponse(restart: true, exit: false, play: false));
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: Center(
                      child: Icon(
                        Icons.refresh,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: request.isPause,
                child: InkWell(
                  onTap: () {
                    _dialogService.dialogComplete(
                        AlertResponse(play: true, exit: false, restart: false));
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: Center(
                      child: Icon(
                        Icons.play_arrow,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Alert getInfoDialog(AlertRequest request) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      buttonAreaPadding: EdgeInsets.all(5),
      isOverlayTapDismiss: false,
      animationDuration: Duration(milliseconds: 600),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: Theme.of(context).textTheme.headline
    );

    GameInfoDialog dialog =
        DialogInfoUtil.getInfoDialogData(request.gameCategoryType);
    return Alert(
      context: context,
      style: alertStyle,
      title: dialog.title,
      buttons: [],
      content: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0)),
                  ),
                  child: Image.asset(dialog.image)),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                      dialog.dec,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.body1
                    ),
                  ),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    onPressed: () {
                      _dialogService.dialogComplete(AlertResponse(
                          exit: true, restart: false, play: false));
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Got it',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
