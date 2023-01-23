import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mathgame/src/core/app_assets.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/ui/app/theme_provider.dart';
import 'package:provider/provider.dart';

class CommonDifficultyView extends StatelessWidget {
  final DifficultyType selectedDifficulty;

  const CommonDifficultyView({
    required this.selectedDifficulty,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                "Change Difficulty",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
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
                  Navigator.pop(context);
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
        CommonDifficultyButtonView(
          name: "HIGH",
          difficultyType: DifficultyType.HIGH,
          selectedDifficulty: selectedDifficulty,
        ),
        CommonDifficultyButtonView(
          name: "MEDIUM",
          difficultyType: DifficultyType.MEDIUM,
          selectedDifficulty: selectedDifficulty,
        ),
        CommonDifficultyButtonView(
          name: "LOW",
          difficultyType: DifficultyType.LOW,
          selectedDifficulty: selectedDifficulty,
        ),
      ],
    );
  }
}

class CommonDifficultyButtonView extends StatelessWidget {
  final String name;
  final DifficultyType difficultyType;
  final DifficultyType selectedDifficulty;

  const CommonDifficultyButtonView({
    required this.name,
    required this.difficultyType,
    required this.selectedDifficulty,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          context.read<ThemeProvider>().changeDifficulty(difficultyType);
          Navigator.pop(context);
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
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                  ),
                ),
                selectedDifficulty == difficultyType
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Transform(
                          transform: Matrix4.identity()..translate(0.0, 4),
                          child: SvgPicture.asset(AppAssets.icButtonShape),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
