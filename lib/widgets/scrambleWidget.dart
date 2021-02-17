import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cubetrainer/model/timerState.dart';
import 'package:cubetrainer/model/scrambler.dart';

class ScrambleWidget extends StatelessWidget {
  const ScrambleWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Scrambler>(
      builder: (context, scrambler, _) {
        return Consumer<SolveState>(builder: (context, solveState, _) {
          switch (solveState.currentStatus) {
            case CubeStatus.SCRAMBLING:
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  scrambler.currentScramble,
                  style: TextStyle(fontSize: 30),
                ),
              );

            case CubeStatus.SOLVING:
              return Container();
          }
          return Container();
        });
      },
    );
  }
}
