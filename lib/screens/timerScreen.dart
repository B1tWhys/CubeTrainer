import 'package:cubetrainer/widgets/scrambleWidget.dart';
import 'package:cubetrainer/widgets/solveHistoryWidget.dart';
import 'package:cubetrainer/widgets/timerWidget.dart';
import 'package:flutter/material.dart';
import 'package:cubetrainer/widgets/catPictureWidget.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CatPictureWidget(),
          ScrambleWidget(),
          TimerWidget(),
          SolveHistoryWidget(),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
