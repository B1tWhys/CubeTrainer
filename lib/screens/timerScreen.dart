import 'package:cubetrainer/widgets/scrambleWidget.dart';
import 'package:cubetrainer/widgets/solveHistoryWidget.dart';
import 'package:cubetrainer/widgets/timerWidget.dart';
import 'package:flutter/material.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key key}) : super(key: key);

  Widget _warning() => Text(
        "CAUTION:\nsolve history is not currently saved between reloads!\n(i'll be adding that tomorrowish :)",
        style: TextStyle(fontSize: 30, color: Colors.red),
        textAlign: TextAlign.center,
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          _warning(),
          Spacer(),
          ScrambleWidget(),
          TimerWidget(),
          SolveHistoryWidget(),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
