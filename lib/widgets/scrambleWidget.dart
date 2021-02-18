import 'package:cubetrainer/model/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cubetrainer/model/timerState.dart';
import 'package:cubetrainer/model/scrambler.dart';

class ScrambleWidget extends StatelessWidget {
  const ScrambleWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Scrambler scrambler = Provider.of<Scrambler>(context);
    Settings settings = Provider.of<Settings>(context);
    return Consumer<SolveState>(builder: (context, solveState, _) {
      switch (solveState.currentStatus) {
        case CubeStatus.SCRAMBLING:
          scrambler.generateNewScramble(settings["scrambleLen"].value);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              scrambler.currentScramble,
              style: TextStyle(fontSize: 30),
            ),
          );
        default:
          return Container();
      }
    });
  }
}
