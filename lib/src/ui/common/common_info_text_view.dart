import 'package:flutter/material.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/utility/dialog_info_util.dart';
import 'package:provider/provider.dart';
import '../app/game_provider.dart';

class CommonInfoTextView<T extends GameProvider> extends StatelessWidget {
  final GameCategoryType gameCategoryType;

  const CommonInfoTextView({
    required this.gameCategoryType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<T>().showInfoDialog();
      },
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                DialogInfoUtil.getInfoDialogData(gameCategoryType)
                    .title
                    .toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(fontWeight: FontWeight.bold)),
            SizedBox(width: 4),
            Icon(
              Icons.info,
              size: 13,
              color: Theme.of(context).textTheme.caption!.color,
            ),
          ],
        ),
      ),
    );
  }
}
