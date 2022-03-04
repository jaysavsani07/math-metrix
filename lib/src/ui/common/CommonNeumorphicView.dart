import 'package:flutter/material.dart';
import '../../core/app_assets.dart';

class CommonNeumorphicView extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final bool isLarge;

  const CommonNeumorphicView({
    Key? key,
    required this.child,
    this.height = 56,
    this.width = 56,
    this.isLarge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: isLarge ? null : width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Theme.of(context).brightness == Brightness.light
              ? (isLarge ? AppAssets.bgLargeButton : AppAssets.bgSmallButton)
              : (isLarge
                  ? AppAssets.bgLargeDarkButton
                  : AppAssets.bgSmallDarkButton)),
        ),
      ),
      child: child,
    );
  }
}
