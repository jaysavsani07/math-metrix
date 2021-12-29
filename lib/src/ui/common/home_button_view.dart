import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeButtonView extends StatelessWidget {
  final Function onTab;
  final Animation<Offset> position;
  final String title;
  final String icon;
  final Color startColor;
  final Color endColor;

  const HomeButtonView({
    Key? key,
    required this.title,
    required this.icon,
    required this.startColor,
    required this.endColor,
    required this.position,
    required this.onTab,
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
                height: 96,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [startColor, endColor],
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
                          color: Colors.white.withOpacity(0.05),
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
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 12),
                          Text(title,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(fontSize: 20, color: Colors.white)),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 8,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(110),
                        ),
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
