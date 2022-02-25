import 'package:flutter/widgets.dart';

import '../../core/app_assets.dart';

class CommonNeumorphicView extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;

  const CommonNeumorphicView({
    Key? key,
    required this.child,
    this.height = 56,
    this.width = 56,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.bgSmallButton),
        ),
      ),
      child: child,
    );
  }
}
