import 'dart:async';

class ComplexTimer implements Timer {
  final Zone _zone;
  Stopwatch _activeTimer = Stopwatch();
  Timer? _timer;
  final Duration _originalDuration;
  void Function(ComplexTimer)? _onTimeout;
  int _tick = 0;

  ComplexTimer(Duration duration)
      : _originalDuration = duration,
        _zone = Zone.current {
    // _startTimer();
  }

  set onTimeout(void Function(ComplexTimer)? callback) {
    _onTimeout = callback == null ? null : _zone.bindUnaryCallback(callback);
  }

  int get tick => _tick;

  // Whether the timer is actively counting.
  bool get isActive => _timer?.isActive ?? false;

  // Whether the timer is started, but not currently actively counting.
  bool get isPaused {
    var timer = _timer;
    return timer != null && !timer.isActive;
  }

  // Whether the timer has expired.
  bool get isExpired => _timer == null;

  /// Pauses an active timer.
  ///
  /// Nothing happens if the timer is already paused or expired.
  void pause() {
    _pauseTimer();
  }

  /// Resumes counting when paused.
  ///
  /// Nothing happens if the timer is active or expired.
  void resume() {
    var timer = _timer;
    if (timer == null || timer.isActive) return;
    _startTimer();
  }

  /// Resets the timer.
  ///
  /// Sets the timer to its original duration.
  /// Does not change whether the timer is active, paused or expired.
  void reset() {
    var timer = _timer;
    if (timer == null) return; // is expired.
    _activeTimer
      ..stop()
      ..reset();
    if (timer.isActive) {
      timer.cancel();
      _startTimer();
    }
  }

  /// Restarts the timer.
  ///
  /// Starts counting for the original duration.
  /// Works whether the timer is active, paused or expired.
  void restart() {
    _timer?.cancel();
    _activeTimer
      ..stop()
      ..reset();
    _startTimer();
  }

  /// Stops and expires the current timer.
  ///
  /// Nothing happens if the timer is already expired.
  void cancel() {
    _timer?.cancel();
    _expireTimer();
  }

  void _startTimer() {
    var elapsed = _activeTimer.elapsedMilliseconds;
    var duration = _originalDuration;
    if (elapsed > 0) {
      duration =
          Duration(milliseconds: _originalDuration.inMilliseconds - elapsed);
    }
    _timer = _zone.createTimer(duration, _onTick);
    _activeTimer.start();
  }

  void _expireTimer() {
    _timer = null;
    _activeTimer
      ..stop()
      ..reset();
  }

  void _pauseTimer() {
    _timer?.cancel();
    _activeTimer..stop();
  }

  void _onTick() {
    _tick++;
    _expireTimer();
    var callback = _onTimeout;
    if (callback != null) {
      _zone.runUnary(callback, this);
    }
  }
}

void main() {
  var timer = ComplexTimer(Duration(milliseconds: 2000));
  timer.onTimeout = (x) {
    print(x.tick);
  };
  timer._startTimer();
}
