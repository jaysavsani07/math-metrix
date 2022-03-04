import 'dart:math';
import 'package:flutter/material.dart';

class SineCurve extends Curve {
  final double count;

  SineCurve({this.count = 3});

  @override
  double transformInternal(double t) {
    var val = sin(count * 2 * pi * t) * 0.5 + 0.5;
    return val;
  }
}

class CommonWrongAnswerAnimationView extends StatefulWidget {
  final int currentScore;
  final int oldScore;
  final Widget child;

  const CommonWrongAnswerAnimationView({
    Key? key,
    required this.currentScore,
    required this.oldScore,
    required this.child,
  }) : super(key: key);

  @override
  State<CommonWrongAnswerAnimationView> createState() =>
      _CommonWrongAnswerAnimationViewState();
}

class _CommonWrongAnswerAnimationViewState
    extends State<CommonWrongAnswerAnimationView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<double> _opacityAnimationOut;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _opacityAnimationOut = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: SineCurve(count: 3),
    ));
  }

  @override
  void didUpdateWidget(CommonWrongAnswerAnimationView oldWidget) {
    if (oldWidget.currentScore != widget.currentScore) {
      if (widget.oldScore > widget.currentScore) {
        _controller.forward(from: 0.0);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacityAnimationOut,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_opacityAnimationOut.value * 4, 0),
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
