import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mathgame/src/core/app_assets.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/extension/math_extension.dart';
import 'package:tuple/tuple.dart';

class HomeSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final String title;
  final Tuple2<Color, Color> colorTuple;

  HomeSliverPersistentHeaderDelegate({
    required this.title,
    required this.colorTuple,
  });

  double scrollAnimationValue(double shrinkOffset) {
    double maxScrollAllowed = maxExtent - minExtent;
    return ((maxScrollAllowed - shrinkOffset) / maxScrollAllowed)
        .clamp(0, 1)
        .toDouble();
  }

  double scrollAnimationTextSizeValue(double shrinkOffset) {
    double maxScrollAllowed = maxExtent - minExtent;
    return ((maxScrollAllowed - shrinkOffset) / maxScrollAllowed)
        .clamp(0, 1)
        .toDouble()
        .remap(0, 1, 24, 28);
  }

  double scrollAnimationReValue(double shrinkOffset) {
    double maxScrollAllowed = maxExtent - minExtent;
    return 1 -
        ((maxScrollAllowed - shrinkOffset) / maxScrollAllowed)
            .clamp(0, 1)
            .toDouble();
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double visibleMainHeight = max(maxExtent - shrinkOffset, minExtent);
    final double animationVal = scrollAnimationValue(shrinkOffset);
    final double animationReVal = scrollAnimationReValue(shrinkOffset);

    final double elevation = shrinkOffset.toElevation(100, minExtent, 100, 4);
    final double radius = shrinkOffset.toRadius(100, minExtent, 100, 18);
    final double textSize =
        shrinkOffset.toTextSize(maxExtent, minExtent, 24, 28);

    return PhysicalModel(
      color: Theme.of(context).colorScheme.baseColor,
      elevation: elevation,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius)),
      child: Container(
        height: visibleMainHeight,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            // Icon(Icons.extension),
            Icon(
              Icons.extension_outlined,
              size: 100,
            ),
            Positioned(
              bottom: 66,
              right: 0,
              child: SvgPicture.asset(
                AppAssets.icHomeBg,
                height: 117,
                width: 127,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 7),
              child: Card(
                color: Theme.of(context).colorScheme.crossColor,
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
                      Icons.arrow_back_ios_new_rounded,
                      color: Theme.of(context).colorScheme.baseColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 62 * animationReVal,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 7, left: 20),
                child: Text(
                  title,
                  style: TextStyle(fontSize: textSize),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 183.0;

  @override
  double get minExtent => 56.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
