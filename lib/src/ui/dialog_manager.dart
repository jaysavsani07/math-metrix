import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/models/alert_request.dart';
import 'package:mathgame/src/models/alert_response.dart';
import 'package:mathgame/src/resources/dialog_service.dart';
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

    Alert(
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
    ).show();
  }
}
