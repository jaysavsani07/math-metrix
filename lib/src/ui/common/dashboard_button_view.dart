import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathgame/src/core/app_assets.dart';
import 'package:tuple/tuple.dart';

class DashboardButtonView extends StatelessWidget {
  final Function onTab;
  final Animation<Offset> position;
  final String title;
  final String icon;
  final Tuple2<Color, Color> colorTuple;
  final double opacity;

  const DashboardButtonView({
    Key? key,
    required this.title,
    required this.icon,
    required this.colorTuple,
    required this.position,
    required this.onTab,
    required this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTab();
      },
      child: SlideTransition(
        position: position,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
                alignment: Alignment.center,
                height: 116,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colorTuple.item1, colorTuple.item2],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Transform(
                        transform: Matrix4.identity().scaled(5.0)
                          ..translate(0.0, -27.0),
                        child: SvgPicture.asset(
                          icon,
                          color: Colors.white.withOpacity(opacity),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            icon,
                            width: 28,
                            height: 28,
                          ),
                          SizedBox(width: 12),
                          Text(title,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Transform(
                        transform: Matrix4.identity()..translate(0.0, 2),
                        child: SvgPicture.asset(AppAssets.icButtonShape),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
