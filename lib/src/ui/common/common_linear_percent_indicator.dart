import 'package:flutter/material.dart';

enum LinearStrokeCap { butt, round, roundAll }

// ignore: must_be_immutable
class CommonLinearPercentIndicator extends StatelessWidget {
  ///Height of the line
  final double lineHeight;
  final Animation<double> percent;

  ///Color of the background of the Line , default = transparent
  final Color fillColor;

  ///First color applied to the complete line
  Color get backgroundColor => _backgroundColor;
  late Color _backgroundColor;

  ///First color applied to the complete line
  final LinearGradient? linearGradientBackgroundColor;

  Color get progressColor => _progressColor;

  late Color _progressColor;

  ///duration of the animation in milliseconds, It only applies if animation attribute is true
  final int animationDuration;

  ///The kind of finish to place on the end of lines drawn, values supported: butt, round, roundAll
  final LinearStrokeCap? linearStrokeCap;

  ///alignment of the Row (leading-widget-center-trailing)
  final MainAxisAlignment alignment;

  ///padding to the LinearPercentIndicator
  final EdgeInsets padding;

  /// If present, this will make the progress bar colored by this gradient.
  ///
  /// This will override [progressColor]. It is an error to provide both.
  final LinearGradient? linearGradient;

  /// set false if you don't want to preserve the state of the widget
  final bool addAutomaticKeepAlive;

  /// Creates a mask filter that takes the progress shape being drawn and blurs it.
  final MaskFilter? maskFilter;

  /// Set true if you want to display only part of [linearGradient] based on percent value
  /// (ie. create 'VU effect'). If no [linearGradient] is specified this option is ignored.
  final bool clipLinearGradient;

  /// set a linear curve animation type
  final Curve curve;

  /// set true when you want to restart the animation, it restarts only when reaches 1.0 as a value
  /// defaults to false
  final bool restartAnimation;

  /// Callback called when the animation ends (only if `animation` is true)
  final VoidCallback? onAnimationEnd;

  CommonLinearPercentIndicator({
    Key? key,
    this.fillColor = Colors.transparent,
    this.lineHeight = 5.0,
    required this.percent,
    Color? backgroundColor,
    this.linearGradientBackgroundColor,
    this.linearGradient,
    Color? progressColor,
    this.animationDuration = 500,
    this.addAutomaticKeepAlive = true,
    this.linearStrokeCap,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0),
    this.alignment = MainAxisAlignment.start,
    this.maskFilter,
    this.clipLinearGradient = false,
    this.curve = Curves.linear,
    this.restartAnimation = false,
    this.onAnimationEnd,
  }) : super(key: key) {
    if (linearGradient != null && progressColor != null) {
      throw ArgumentError(
          'Cannot provide both linearGradient and progressColor');
    }
    _progressColor = progressColor ?? Colors.red;

    if (linearGradientBackgroundColor != null && backgroundColor != null) {
      throw ArgumentError(
          'Cannot provide both linearGradientBackgroundColor and backgroundColor');
    }
    _backgroundColor = backgroundColor ?? Color(0xFFB8C7CB);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: fillColor,
        child: Container(
          width: double.infinity,
          height: lineHeight,
          padding: padding,
          child: CustomPaint(
            painter: LinearPainter(
              isRTL: false,
              progress: percent,
              progressColor: progressColor,
              linearGradient: linearGradient,
              backgroundColor: backgroundColor,
              linearGradientBackgroundColor: linearGradientBackgroundColor,
              linearStrokeCap: linearStrokeCap,
              lineWidth: lineHeight,
              maskFilter: maskFilter,
              clipLinearGradient: clipLinearGradient,
            ),
            child: Container(),
          ),
        ),
      ),
    );
  }
}

class LinearPainter extends CustomPainter {
  final Paint _paintBackground = new Paint();
  final Paint _paintLine = new Paint();
  final double lineWidth;
  final Animation<double> progress;
  final bool isRTL;
  final Color progressColor;
  final Color backgroundColor;
  final LinearStrokeCap? linearStrokeCap;
  final LinearGradient? linearGradient;
  final LinearGradient? linearGradientBackgroundColor;
  final MaskFilter? maskFilter;
  final bool clipLinearGradient;

  LinearPainter({
    required this.lineWidth,
    required this.progress,
    required this.isRTL,
    required this.progressColor,
    required this.backgroundColor,
    this.linearStrokeCap = LinearStrokeCap.butt,
    this.linearGradient,
    this.maskFilter,
    required this.clipLinearGradient,
    this.linearGradientBackgroundColor,
  }) {
    _paintBackground.color = backgroundColor;
    _paintBackground.style = PaintingStyle.stroke;
    _paintBackground.strokeWidth = lineWidth;

    _paintLine.color = progress.toString() == "0.0"
        ? progressColor.withOpacity(0.0)
        : progressColor;
    _paintLine.style = PaintingStyle.stroke;
    _paintLine.strokeWidth = lineWidth;

    if (linearStrokeCap == LinearStrokeCap.round) {
      _paintLine.strokeCap = StrokeCap.round;
    } else if (linearStrokeCap == LinearStrokeCap.butt) {
      _paintLine.strokeCap = StrokeCap.butt;
    } else {
      _paintLine.strokeCap = StrokeCap.round;
      _paintBackground.strokeCap = StrokeCap.round;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(0.0, size.height / 2);
    final end = Offset(size.width, size.height / 2);
    canvas.drawLine(start, end, _paintBackground);

    if (maskFilter != null) {
      _paintLine.maskFilter = maskFilter;
    }
    if (linearGradientBackgroundColor != null) {
      Offset shaderEndPoint =
          clipLinearGradient ? Offset.zero : Offset(size.width, size.height);
      _paintBackground.shader = linearGradientBackgroundColor
          ?.createShader(Rect.fromPoints(Offset.zero, shaderEndPoint));
    }

    if (isRTL) {
      final xProgress = size.width - size.width * progress.value;
      if (linearGradient != null) {
        _paintLine.shader = _createGradientShaderRightToLeft(size, xProgress);
      }
      canvas.drawLine(end, Offset(xProgress, size.height / 2), _paintLine);
    } else {
      final xProgress = size.width * progress.value;
      if (linearGradient != null) {
        _paintLine.shader = _createGradientShaderLeftToRight(size, xProgress);
      }
      canvas.drawLine(start, Offset(xProgress, size.height / 2), _paintLine);
    }
  }

  Shader _createGradientShaderRightToLeft(Size size, double xProgress) {
    Offset shaderEndPoint =
        clipLinearGradient ? Offset.zero : Offset(xProgress, size.height);
    return linearGradient!.createShader(
      Rect.fromPoints(
        Offset(size.width, size.height),
        shaderEndPoint,
      ),
    );
  }

  Shader _createGradientShaderLeftToRight(Size size, double xProgress) {
    Offset shaderEndPoint = clipLinearGradient
        ? Offset(size.width, size.height)
        : Offset(xProgress, size.height);
    return linearGradient!.createShader(
      Rect.fromPoints(
        Offset.zero,
        shaderEndPoint,
      ),
    );
  }

  @override
  bool shouldRepaint(LinearPainter oldDelegate) {
    return oldDelegate.progress.value != progress.value;
  }

  @override
  bool? hitTest(Offset position) => null;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;

  @override
  SemanticsBuilderCallback? get semanticsBuilder => null;
}