import 'package:flutter/material.dart';
import 'package:mathgame/src/core/app_constant.dart';

class CommonGameOverDialogView extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final double score;

  const CommonGameOverDialogView({
    required this.gameCategoryType,
    required this.score,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 6),
        Text(
          "Game Over!!!",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
        ),
        SizedBox(height: 24),
        Text(
          "Your highest score is $score",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
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
                        child: Text("RESTART",
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
                  Navigator.pop(context);
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
                      Icons.clear,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
