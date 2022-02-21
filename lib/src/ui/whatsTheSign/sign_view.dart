import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mathgame/src/core/color_scheme.dart';
import 'package:mathgame/src/data/models/sign.dart';
import 'package:mathgame/src/ui/common/CommonNumberButton.dart';
import 'package:mathgame/src/ui/common/common_app_bar.dart';
import 'package:mathgame/src/ui/common/common_info_text_view.dart';
import 'package:mathgame/src/ui/common/dialog_listener.dart';
import 'package:mathgame/src/ui/whatsTheSign/sign_view_model.dart';
import 'package:mathgame/src/core/app_constant.dart';
import 'package:provider/provider.dart';
import 'package:vsync_provider/vsync_provider.dart';

class SignView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        const VsyncProvider(),
        ChangeNotifierProvider<SignProvider>(
            create: (context) => SignProvider(vsync: VsyncProvider.of(context)))
      ],
      child: SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          appBar: CommonAppBar<SignProvider>(),
          body: DialogListener<SignProvider>(
            gameCategoryType: GameCategoryType.SIGN,
            child: Container(
              margin: EdgeInsets.all(24),
              constraints: BoxConstraints.expand(),
              child: Column(
                children: <Widget>[
                  CommonInfoTextView<SignProvider>(
                      gameCategoryType: GameCategoryType.SIGN),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Selector<SignProvider, Sign>(
                            selector: (p0, p1) => p1.currentState,
                            builder: (context, calculatorProvider, child) {
                              return Text(
                                calculatorProvider.firstDigit,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontSize: 30),
                              );
                            }),
                        SizedBox(width: 8),
                        Neumorphic(
                          style: NeumorphicStyle(
                            // shape: NeumorphicShape.convex,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(18)),
                            depth: -8,
                            lightSource: LightSource.topLeft,
                            color: Theme.of(context).colorScheme.iconBgColor,
                          ),
                          child: Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 5, top: 10),
                            child: Selector<SignProvider, String>(
                              selector: (p0, p1) => p1.result,
                              builder: (context, calculatorProvider, child) {
                                return Text(
                                  calculatorProvider,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          fontSize: 30,
                                          color: Color(0xff4895EF)),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Selector<SignProvider, Sign>(
                            selector: (p0, p1) => p1.currentState,
                            builder: (context, calculatorProvider, child) {
                              return Text(
                                calculatorProvider.secondDigit,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontSize: 30),
                              );
                            }),
                        SizedBox(width: 8),
                        Text(
                          "=",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontSize: 30),
                        ),
                        SizedBox(width: 8),
                        Selector<SignProvider, Sign>(
                            selector: (p0, p1) => p1.currentState,
                            builder: (context, calculatorProvider, child) {
                              return Text(
                                calculatorProvider.answer,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(fontSize: 30),
                              );
                            }),
                      ],
                    ),
                  ),
                  Builder(builder: (context) {
                    return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ...[
                          "/",
                          "*",
                          "+",
                          "-",
                        ].map(
                          (e) {
                            return CommonNumberButton(
                              text: e,
                              onTab: () {
                                context.read<SignProvider>().checkResult(e);
                              },
                              startColor: Color(0xff4895EF),
                              endColor: Color(0xff3f37c9),
                            );
                          },
                        )
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
