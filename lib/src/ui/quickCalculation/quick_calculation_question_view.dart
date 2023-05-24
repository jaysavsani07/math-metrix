import 'package:flutter/material.dart';
import 'package:mathgame/src/data/models/quick_calculation.dart';

class QuickCalculationQuestionView extends StatefulWidget {
  final QuickCalculation currentState;
  final QuickCalculation nextCurrentState;
  final QuickCalculation? previousCurrentState;

  const QuickCalculationQuestionView({
    Key? key,
    required this.currentState,
    required this.nextCurrentState,
    required this.previousCurrentState,
  }) : super(key: key);

  @override
  _QuickCalculationQuestionViewState createState() =>
      _QuickCalculationQuestionViewState();
}

class _QuickCalculationQuestionViewState
    extends State<QuickCalculationQuestionView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<AlignmentGeometry> _animation;
  late Animation<TextStyle> _textStyleAnimation;
  late final Animation<double> _opacityAnimationOut;
  late final Animation<double> _opacityAnimationIn;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();
    _animation = Tween<AlignmentGeometry>(
      begin: Alignment.topLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _textStyleAnimation = TextStyleTween(
      begin: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w200,
      ),
      end: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.w700,
      ),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    ));

    _opacityAnimationOut = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.0,
        0.3,
        curve: Curves.easeIn,
      ),
    ));

    _opacityAnimationIn = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.3,
        0.7,
        curve: Curves.easeOut,
      ),
    ));
  }

  @override
  void didUpdateWidget(QuickCalculationQuestionView oldWidget) {
    if (oldWidget.currentState != widget.currentState) {
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Align(
              alignment: _animation.value,
              child: Text(
                widget.currentState.question,
                style: _textStyleAnimation.value,
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.centerRight,
          child: FadeTransition(
            opacity: _opacityAnimationOut,
            child: Text(
              widget.previousCurrentState?.question ?? "",
              style:
                  Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 30),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: FadeTransition(
            opacity: _opacityAnimationIn,
            child: Text(
              widget.nextCurrentState.question,
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
