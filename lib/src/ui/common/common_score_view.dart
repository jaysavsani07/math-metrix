import 'package:flutter/material.dart';

class CommonScoreView extends StatefulWidget {
  final int currentScore;
  final int oldScore;

  const CommonScoreView({
    Key? key,
    required this.currentScore,
    required this.oldScore,
  }) : super(key: key);

  @override
  State<CommonScoreView> createState() => _CommonScoreViewState();
}

class _CommonScoreViewState extends State<CommonScoreView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<Offset> inAnimation;
  late final Animation<Offset> outAnimation;
  late final Animation<double> _opacityAnimationOut;
  late final Animation<double> _opacityAnimationIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    inAnimation = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.0,
        1.0,
        curve: Curves.easeIn,
      ),
    ));

    outAnimation =
        Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.0,
        1.0,
        curve: Curves.easeIn,
      ),
    ));

    _opacityAnimationOut = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.4,
        0.8,
        curve: Curves.easeIn,
      ),
    ));

    _opacityAnimationIn = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.4,
        0.8,
        curve: Curves.easeOut,
      ),
    ));
  }

  @override
  void didUpdateWidget(CommonScoreView oldWidget) {
    if (oldWidget.currentScore != widget.currentScore) {
      if (oldWidget.currentScore < widget.currentScore) {
        _controller.forward(from: 0.0);
      } else {
        _controller.reverse(from: 1.0);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SlideTransition(
          child: FadeTransition(
            opacity: _opacityAnimationIn,
            child: Text(
              widget.oldScore < widget.currentScore
                  ? widget.currentScore.toString()
                  : widget.oldScore.toString(),
              // key: ValueKey<int>(widget.score),
              style:
                  Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 24),
            ),
          ),
          position: inAnimation,
        ),
        SlideTransition(
          child: FadeTransition(
            opacity: _opacityAnimationOut,
            child: Text(
              widget.oldScore > widget.currentScore
                  ? widget.currentScore.toString()
                  : widget.oldScore.toString(),
              // key: ValueKey<int>(widget.score),
              style:
                  Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 24),
            ),
          ),
          position: outAnimation,
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// import 'package:flutter/material.dart';
//
// class CommonScoreView1 extends StatefulWidget {
//   final int currentScore;
//   final int oldScore;
//
//   const CommonScoreView1({
//     Key? key,
//     required this.currentScore,
//     required this.oldScore,
//   }) : super(key: key);
//
//   @override
//   State<CommonScoreView1> createState() => _CommonScoreView1State();
// }
//
// class _CommonScoreView1State extends State<CommonScoreView1>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late final Animation<Offset> inAnimation;
//   late final Animation<Offset> outAnimation;
//   late final Animation<double> _opacityAnimationOut;
//   late final Animation<double> _opacityAnimationIn;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//
//     inAnimation = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
//         .animate(CurvedAnimation(
//       parent: _controller,
//       curve: Interval(
//         0.0,
//         1.0,
//         curve: Curves.easeIn,
//       ),
//     ));
//
//     outAnimation =
//         Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, -1.0))
//             .animate(CurvedAnimation(
//           parent: _controller,
//           curve: Interval(
//             0.0,
//             1.0,
//             curve: Curves.easeIn,
//           ),
//         ));
//
//     _opacityAnimationOut = Tween<double>(
//       begin: 1.0,
//       end: 0.0,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Interval(
//         0.4,
//         0.8,
//         curve: Curves.easeIn,
//       ),
//     ));
//
//     _opacityAnimationIn = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Interval(
//         0.4,
//         0.8,
//         curve: Curves.easeOut,
//       ),
//     ));
//   }
//
//   @override
//   void didUpdateWidget(CommonScoreView1 oldWidget) {
//     print("ok ${widget.currentScore} ${widget.oldScore}");
//     if (oldWidget.currentScore != widget.currentScore &&
//         oldWidget.oldScore != widget.oldScore) {
//       if (widget.currentScore > widget.currentScore) {
//         _controller.reverse(from: 1.0);
//       } else {
//         _controller.forward(from: 0.0);
//       }
//     }
//     super.didUpdateWidget(oldWidget);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         SlideTransition(
//           child: FadeTransition(
//             opacity: _opacityAnimationIn,
//             child: Text(
//               widget.currentScore.toString(),
//               // key: ValueKey<int>(widget.score),
//               style:
//               Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 24),
//             ),
//           ),
//           position: inAnimation,
//         ),
//         SlideTransition(
//           child: FadeTransition(
//             opacity: _opacityAnimationOut,
//             child: Text(
//               widget.oldScore.toString(),
//               // key: ValueKey<int>(widget.score),
//               style:
//               Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 24),
//             ),
//           ),
//           position: outAnimation,
//         )
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
