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
  Stream<Duration> _timeStream;

  _TimerWidgetState(Duration interval) {
    StreamController<Duration> streamController;
    Timer timer;
    Stopwatch stopwatch;

    void sendTime(_) {
      streamController.add(stopwatch.elapsed);
    }

    void startTimer() {
      timer = Timer.periodic(interval, sendTime);
    }

    void stopTimer() {
      timer.cancel();
    }

    void resetTimer() {
      stopwatch = Stopwatch();
      stopwatch.start();
      sendTime(stopwatch.elapsed);
    }

    streamController = StreamController(
      onListen: () {
        resetTimer();
        startTimer();
      },
      onPause: stopTimer,
      onResume: startTimer,
      onCancel: resetTimer,
    );

    _timeStream = streamController.stream;
  }

  String formatDuration(Duration d) {
    int sec = d.inSeconds;
    String ms = d.inMilliseconds.remainder(1000).toString().padLeft(3, "0");
    return "$sec.$ms";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: _timeStream,
          initialData: Duration.zero,
          builder: (BuildContext context, AsyncSnapshot<Duration> snapshot) {
            return Text(formatDuration(snapshot.data));
          }),
    );
  }
}
