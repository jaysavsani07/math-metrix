import 'package:flutter/material.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/ui/common/common_alert_dialog.dart';
import 'package:mathgame/src/ui/common/common_game_exit_dialog_view.dart';
import 'package:mathgame/src/ui/common/common_game_over_dialog_view.dart';
import 'package:mathgame/src/ui/common/common_game_pause_dialog_view.dart';
import 'package:mathgame/src/ui/common/common_info_dialog_view.dart';
import 'package:mathgame/src/ui/app/game_provider.dart';
import 'package:provider/provider.dart';

class DialogListener<T extends GameProvider> extends StatefulWidget {
  final Widget child;
  final GameCategoryType gameCategoryType;

  const DialogListener({
    Key? key,
    required this.child,
    required this.gameCategoryType,
  }) : super(key: key);

  @override
  State<DialogListener<T>> createState() => _DialogListenerState<T>();
}

class _DialogListenerState<T extends GameProvider>
    extends State<DialogListener<T>> {
  late final T provider;

  @override
  void initState() {
    provider = context.read<T>();
    provider.addListener(addListener);
    super.initState();
  }

  void addListener() {
    switch (provider.dialogType) {
      case DialogType.over:
        showDialog<bool>(
          context: context,
          builder: (newContext) => CommonAlertDialog(
            child: CommonGameOverDialogView(
              gameCategoryType: widget.gameCategoryType,
              score: context.read<T>().currentScore,
            ),
          ),
          barrierDismissible: false,
        ).then((value) {
          if (value != null && value) {
            context.read<T>().updateScore();
            context.read<T>().startGame();
          } else {
            context.read<T>().updateScore();
            Navigator.pop(context);
          }
        });
        break;
      case DialogType.info:
        showModalBottomSheet(
          context: context,
          builder: (context) => CommonInfoDialogView(
            gameCategoryType: widget.gameCategoryType,
          ),
          backgroundColor: Theme.of(context).colorScheme.infoDialogBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          ),
          isDismissible: false,
          enableDrag: false,
          isScrollControlled: true,
        ).then((value) {
            context.read<T>().gotItFromInfoDialog();
        });
        break;
      case DialogType.pause:
        showDialog<bool>(
          context: context,
          builder: (newContext) => CommonAlertDialog(
            child: CommonGamePauseDialogView(
              gameCategoryType: widget.gameCategoryType,
              score: context.read<T>().currentScore,
            ),
          ),
          barrierDismissible: false,
        ).then((value) {
          if (value != null) {
            if (value) {
              context.read<T>().pauseResumeGame();
            } else {
              context.read<T>().updateScore();
              context.read<T>().startGame();
            }
          } else {
            context.read<T>().updateScore();
            Navigator.pop(context);
          }
        });
        break;
      case DialogType.exit:
        showDialog<bool>(
          context: context,
          builder: (newContext) => CommonAlertDialog(
            child: CommonGameExitDialogView(
              score: context.read<T>().currentScore,
            ),
          ),
          barrierDismissible: false,
        ).then((value) {
          if (value != null && value) {
            context.read<T>().updateScore();
            Navigator.pop(context);
          } else {
            context.read<T>().pauseResumeGame();
          }
        });
        break;
      case DialogType.non:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    provider.removeListener(addListener);
    super.dispose();
  }
}
