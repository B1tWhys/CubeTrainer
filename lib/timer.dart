import 'dart:async';

import 'package:cubetrainer/timerState.dart';
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

enum SolvePhase { preSolve, pendingStart, solving, solveCompleted }

class _TimerWidgetState extends State<TimerWidget> {
  Timer _updateTimer;
  Stopwatch _stopwatch = Stopwatch();
  Duration _interval;
  String _displayedTime = "0.000";
  FocusNode _node;
  SolveState globalSolveState;
  Color textColor = Colors.black;

  SolvePhase _solvePhase$ = SolvePhase.preSolve;
  set _solvePhase(SolvePhase solvePhase) {
    print("solve phase transition: ${_solvePhase$} -> $solvePhase");
    _solvePhase$ = solvePhase;
  }

  SolvePhase get _solvePhase => _solvePhase$;

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

  void setTextColor(Color c) {
    setState(() => textColor = c);
  }

  void pendStart() async {
    _solvePhase = SolvePhase.pendingStart;
    setTextColor(Colors.red);
    _updateTimer = Timer(Duration(milliseconds: 250), () {
      // TODO: update global state
      print("pending start completed");
      setTextColor(Colors.green);
    });
  }

  void startSolve() {
    if (_updateTimer?.isActive ?? false) _updateTimer.cancel();
    _updateTimer = Timer.periodic(_interval, update);
    _solvePhase = SolvePhase.solving;
    _stopwatch.reset();
    _stopwatch.start();
  }

  void endSolve() {
    _stopwatch.stop();
    _updateTimer.cancel();
    update(null);
    _solvePhase = SolvePhase.solveCompleted;
    // TODO: update global state
  }

  void handleKeyPress(RawKeyEvent event) {
    switch (_solvePhase) {
      case SolvePhase.preSolve:
        if (event.logicalKey != LogicalKeyboardKey.space) return;
        pendStart();
        break;
      case SolvePhase.pendingStart:
        if (event.logicalKey != LogicalKeyboardKey.space ||
            event is! RawKeyUpEvent) return;
        if (textColor == Colors.red) {
          print("aborting solve due to premature space release");
          setTextColor(Colors.black);
          _solvePhase = SolvePhase.preSolve;
          _updateTimer?.cancel();
        } else {
          startSolve();
        }
        break;
      case SolvePhase.solving:
        endSolve();
        setTextColor(Colors.red);
        break;
      case SolvePhase.solveCompleted:
        if (event is RawKeyUpEvent) {
          setTextColor(Colors.black);
          _solvePhase = SolvePhase.preSolve;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      child: Text(
        _displayedTime,
        style: TextStyle(fontSize: 80, color: textColor),
      ),
      focusNode: _node,
      autofocus: true,
      onKey: handleKeyPress,
    );
  }
}
