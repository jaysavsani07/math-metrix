import 'package:flutter/material.dart';
import 'package:mathgame/src/core/app_assets.dart';
import 'package:store_redirect/store_redirect.dart';

class MathRiddleView extends StatelessWidget {
  const MathRiddleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.icAppMathRiddle,
              width: 38,
              height: 38,
            ),
            SizedBox(width: 8),
            Text(
              "Math Riddle",
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          "Unleash your puzzle-solving skills with our captivating new game app. Try it today and embark on a thrilling gaming adventure!",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),
        ),
        SizedBox(height: 24),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              StoreRedirect.redirect(androidAppId: "com.mathgame.riddles.puzzles.brain.teasers");
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
                child: Text(
                  "Try it Now",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
