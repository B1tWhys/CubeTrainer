import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// reference: https://medium.com/analytics-vidhya/build-a-simple-stopwatch-in-flutter-a1f21cfcd7a8
class TimerWidget extends StatefulWidget {
  final Duration interval;
  TimerWidget({
    this.interval = const Duration(milliseconds: 1),
  }) : super();

  @override
  _TimerWidgetState createState() => _TimerWidgetState(interval);
}

enum Status { paused, running }

class _TimerWidgetState extends State<TimerWidget> {
  Timer _updateTimer;
  Stopwatch _stopwatch = Stopwatch();
  Duration _interval;
  String _displayedTime = "0.000";
  FocusNode _node;
  Status status = Status.paused;

  _TimerWidgetState(this._interval);

  void update(_) {
    setState(() {
      _displayedTime = formatDuration(_stopwatch.elapsed);
    });
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _node = FocusNode(debugLabel: "Timer");
  }

  String formatDuration(Duration d) {
    int sec = d.inSeconds;
    String ms = d.inMilliseconds.remainder(1000).toString().padLeft(3, "0");
    return "$sec.$ms";
  }

  void startTimer() {
    _stopwatch.reset();
    _stopwatch.start();
    _updateTimer = Timer.periodic(_interval, update);
    status = Status.running;
  }

  void pauseTimer() {
    _updateTimer.cancel();
    status = Status.paused;
    _stopwatch.stop();
  }

  void resetTimer() {
    _stopwatch.reset();
  }

  void handleKeyPress(RawKeyEvent event) {
    if (!(event is RawKeyUpEvent)) return;

    switch (status) {
      case Status.paused:
        {
          resetTimer();
          startTimer();
        }
        break;
      case Status.running:
        {
          pauseTimer();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RawKeyboardListener(
        child: Text(
          _displayedTime,
          style: TextStyle(fontSize: 20),
        ),
        focusNode: _node,
        autofocus: true,
        onKey: handleKeyPress,
      ),
    );
  }
}
