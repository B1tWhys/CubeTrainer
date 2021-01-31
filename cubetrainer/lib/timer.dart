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
  StreamController<Duration> _streamController;
  FocusNode _node;
  Timer _timer;
  bool isRunning;

  _TimerWidgetState(Duration interval) {
    Stopwatch stopwatch;

    void sendTime(_) {
      _streamController.add(stopwatch.elapsed);
    }

    void startTimer() {
      _timer = Timer.periodic(interval, sendTime);
    }

    void stopTimer() {
      _timer.cancel();
    }

    void resetTimer() {
      stopwatch = Stopwatch();
      stopwatch.start();
      sendTime(stopwatch.elapsed);
    }

    _streamController = StreamController(
      onListen: () {
        resetTimer();
        startTimer();
      },
      onPause: stopTimer,
      onResume: startTimer,
      onCancel: resetTimer,
    );

    _timeStream = _streamController.stream;
  }

  String formatDuration(Duration d) {
    int sec = d.inSeconds;
    String ms = d.inMilliseconds.remainder(1000).toString().padLeft(3, "0");
    return "$sec.$ms";
  }

  void handleKeyPress(RawKeyEvent event) {
    print("Raw key event: $event");
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    _node = FocusNode(debugLabel: 'Timer');
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RawKeyboardListener(
        child: StreamBuilder(
          stream: _timeStream,
          initialData: Duration.zero,
          builder: (BuildContext context, AsyncSnapshot<Duration> snapshot) {
            return Text(
              formatDuration(snapshot.data),
              style: TextStyle(fontSize: 30),
            );
          },
        ),
        focusNode: _node,
        autofocus: true,
        onKey: handleKeyPress,
      ),
    );
  }
}
