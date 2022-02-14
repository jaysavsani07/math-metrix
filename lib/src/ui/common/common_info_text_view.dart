import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/utility/dialog_info_util.dart';
import 'package:provider/provider.dart';

import 'game_provider.dart';

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(DialogInfoUtil.getInfoDialogData(gameCategoryType).title.toUpperCase(),
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
    );
  }
}
