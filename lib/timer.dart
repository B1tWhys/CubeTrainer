import 'dart:async';

import 'package:flutter/material.dart';

// reference: https://medium.com/analytics-vidhya/build-a-simple-stopwatch-in-flutter-a1f21cfcd7a8
class TimerWidget extends StatefulWidget {
  final Duration interval;
  TimerWidget({
    this.interval = const Duration(milliseconds: 1),
  }) : super();

  @override
  _TimerWidgetState createState() => _TimerWidgetState(interval);
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer _updateTimer;
  Stopwatch _stopwatch;
  Duration _interval;
  String _displayedTime;

  _TimerWidgetState(this._interval);

  void startTimer() {
    _stopwatch = Stopwatch();
    _updateTimer = Timer.periodic(_interval, update);
  }

  void stopTimer() {
    _updateTimer.cancel();
  }

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

  String formatDuration(Duration d) {
    int sec = d.inSeconds;
    String ms = d.inMilliseconds.remainder(1000).toString().padLeft(3, "0");
    return "$sec.$ms";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(_displayedTime),
    );
  }
}
