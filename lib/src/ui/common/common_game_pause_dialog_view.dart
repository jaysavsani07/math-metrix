import 'package:flutter/material.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/data/models/game_info_dialog.dart';
import 'package:mathgame/src/utility/dialog_info_util.dart';

class CommonGamePauseDialogView extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final double score;

  const CommonGamePauseDialogView({
    required this.gameCategoryType,
    required this.score,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameInfoDialog gameInfoDialog =
        DialogInfoUtil.getInfoDialogData(gameCategoryType);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                gameInfoDialog.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 18),
              ),
            ),
            Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.iconCardBgColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: SizedBox(
                  height: 38,
                  width: 38,
                  child: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.crossColor,
                    size: 20,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 24),
        Text(
          "Your current score is $score",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                        height: 44,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xffF48C06), Color(0xffD00000)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Text("RESUME",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 18, color: Colors.white))),
                  ),
                ),
              ),
            ),
            SizedBox(width: 6),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context, false);
                },
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    alignment: Alignment.center,
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffF48C06), Color(0xffD00000)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
