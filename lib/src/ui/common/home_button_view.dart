import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathgame/src/core/app_assets.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:tuple/tuple.dart';

class HomeButtonView extends StatelessWidget {
  final Function onTab;
  final String title;
  final String icon;
  final int score;
  final int coin;
  final Tuple2<Color, Color> colorTuple;
  final double opacity;

  const HomeButtonView({
    Key? key,
    required this.title,
    required this.icon,
    required this.score,
    required this.coin,
    required this.colorTuple,
    required this.onTab,
    required this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTab();
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
              alignment: Alignment.center,
              height: 150,
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
                    alignment: Alignment.bottomRight,
                    child: Transform(
                      transform: Matrix4.identity().scaled(5.2)
                        ..translate(-17.0, -27.0),
                      child: SvgPicture.asset(
                        icon,
                        color: Colors.white.withOpacity(opacity),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                icon,
                                width: 28,
                                height: 28,
                              ),
                              SizedBox(width: 22),
                              Text(title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          fontSize: 18, color: Colors.white)),
                            ],
                          ),
                          SizedBox(height: 16),
                          Divider(
                            color: Theme.of(context).colorScheme.dividerColor,
                            height: 1,
                          ),
                          SizedBox(height: 22),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Coin:",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: Colors.white)),
                                        SizedBox(height: 15),
                                        Text("Score:",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              AppAssets.icCoin,
                                              width: 18,
                                              height: 18,
                                            ),
                                            SizedBox(width: 7),
                                            Text(coin.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        color: Colors.white)),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              AppAssets.icTrophy,
                                              width: 18,
                                              height: 18,
                                            ),
                                            SizedBox(width: 7),
                                            Text(score.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        color: Colors.white)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: SvgPicture.asset(
                                    AppAssets.icPlayCircleFilled,
                                    color: Colors.white,
                                    height: 39,
                                    width: 39,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
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
    );
  }
}
