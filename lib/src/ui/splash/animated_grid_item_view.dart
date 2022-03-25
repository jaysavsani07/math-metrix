import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedGridItemView extends StatefulWidget {
  final int duration;

  const AnimatedGridItemView({
    Key? key,
    required this.duration,
  }) : super(key: key);

  @override
  State<AnimatedGridItemView> createState() => _AnimatedGridItemViewState();
}

class _AnimatedGridItemViewState extends State<AnimatedGridItemView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotateAnimationIn;
  late Animation<double> _rotateAnimationOut;
  List<String> randomNumber = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    ..shuffle();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _rotateAnimationIn = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween(begin: 0.0, end: pi / 2)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
      ],
    ).animate(_controller);

    _rotateAnimationOut = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: -pi / 2, end: 0.0)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 50.0,
        ),
      ],
    ).animate(_controller);

    Future.delayed(Duration(milliseconds: widget.duration))
        .then((value) => _controller.forward());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
            animation: _rotateAnimationIn,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                border: Border.all(color: Colors.white24, width: 1),
              ),
              child: Text(
                randomNumber[0],
                style: TextStyle(
                  color: Colors.white24.withOpacity(0.25),
                  fontFamily: "Poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            builder: (context, child) {
              return Transform(
                transform: Matrix4.rotationY(_rotateAnimationIn.value),
                alignment: Alignment.center,
                child: child,
              );
            }),
        AnimatedBuilder(
            animation: _rotateAnimationOut,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                border: Border.all(color: Colors.white24, width: 1),
              ),
              child: Text(
                randomNumber[1],
                style: TextStyle(
                  color: Colors.white24.withOpacity(0.25),
                  fontFamily: "Poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            builder: (context, child) {
              return Transform(
                transform: Matrix4.rotationY(_rotateAnimationOut.value),
                alignment: Alignment.center,
                child: child,
              );
            }),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
