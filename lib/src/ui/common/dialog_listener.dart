import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/ui/common/common_alert_dialog.dart';
import 'package:mathgame/src/ui/common/common_game_exit_dialog_view.dart';
import 'package:mathgame/src/ui/common/common_game_over_dialog_view.dart';
import 'package:mathgame/src/ui/common/common_game_pause_dialog_view.dart';
import 'package:mathgame/src/ui/common/common_info_dialog_view.dart';
import 'package:mathgame/src/ui/common/game_provider.dart';
import 'package:provider/provider.dart';

class DialogListener<T extends GameProvider> extends StatelessWidget {
  final Widget child;
  final GameCategoryType gameCategoryType;

  const DialogListener({
    Key? key,
    required this.child,
    required this.gameCategoryType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<T, DialogType>(
      selector: (p0, p1) => p1.dialogType,
      // shouldRebuild: (previous, next) => previous != next,
      builder: (context, dialogType, child1) {
        print("********");
        print(dialogType);
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          switch (dialogType) {
            case DialogType.over:
              showDialog<bool>(
                context: context,
                builder: (newContext) => CommonAlertDialog(
                  child: CommonGameOverDialogView(
                    gameCategoryType: gameCategoryType,
                    score: context.read<T>().currentScore,
                  ),
                ),
                barrierDismissible: false,
              ).then((value) {
                if (value != null && value) {
                  context.read<T>().startGame();
                } else {
                  Navigator.pop(context);
                }
              });
              break;
            case DialogType.info:
              showModalBottomSheet(
                context: context,
                builder: (context) => CommonInfoDialogView(
                  gameCategoryType: gameCategoryType,
                ),
                backgroundColor: Theme.of(context).colorScheme.dialogBgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24)),
                ),
                isDismissible: false,
                enableDrag: false,
                isScrollControlled: true,
              ).then((value) {
                if (value != null && value) {
                  context.read<T>().startTimer();
                } else {
                  Navigator.pop(context);
                }
              });
              break;
            case DialogType.pause:
              showDialog<bool>(
                context: context,
                builder: (newContext) => CommonAlertDialog(
                  child: CommonGamePauseDialogView(
                    gameCategoryType: gameCategoryType,
                    score: context.read<T>().currentScore,
                  ),
                ),
                barrierDismissible: false,
              ).then((value) {
                if (value != null) {
                  if (value) {
                    context.read<T>().pauseResumeGame();
                  } else {
                    context.read<T>().startGame();
                  }
                } else {
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
                  Navigator.pop(context);
                } else {
                  context.read<T>().pauseResumeGame();
                }
              });
              break;
            case DialogType.non:
              break;
          }
        });
        return child1!;
      },
      child: child,
    );
  }
}
