import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/models/alert_request.dart';
import 'package:mathgame/src/models/alert_response.dart';
import 'package:mathgame/src/module/giffy_dialog.dart';
import 'package:mathgame/src/resources/dialog_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class InfoDialogManager extends StatefulWidget {
  final Widget child;

  InfoDialogManager({Key key, this.child}) : super(key: key);

  _InfoDialogManagerState createState() => _InfoDialogManagerState();
}

class _InfoDialogManagerState extends State<InfoDialogManager> {
  DialogService _dialogService = GetIt.I<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerInfoDialogListener(_showInfoDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showInfoDialog(AlertRequest request) {
    AssetGiffyDialog(
      buttonCancelColor: Theme.of(context).accentColor,
      onlyCancelButton: true,
      buttonCancelText: Text("Got it"),
      title: Text(
        'Calculator',
        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
      ),
      image: Image.asset("assets/magic-triangle-intro.gif"),
      description: Text(
        '''You need to solve given equation correctly
                                      
+1 for correct answer
-1 for wrong answer''',
        textAlign: TextAlign.center,
        style: TextStyle(),
      ),
      entryAnimation: EntryAnimation.BOTTOM,
      onOkButtonPressed: () {
        _dialogService.dialogInfoComplete(
            AlertResponse(play: true, exit: false, restart: false));
      },
    );
  }
}
