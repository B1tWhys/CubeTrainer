import 'package:cubetrainer/model/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cubetrainer/model/timerState.dart';
import 'package:cubetrainer/model/scrambler.dart';

class ScrambleWidget extends StatelessWidget {
  const ScrambleWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Setting scrambleLenSetting =
        Provider.of<Settings>(context).settings['scrambleLen'];
    return ChangeNotifierProvider.value(
      value: scrambleLenSetting,
      child: Consumer3<SolveState, Scrambler, Setting>(
          builder: (context, solveState, scrambler, scrambleLenSetting, _) {
        switch (solveState.currentStatus) {
          case CubeStatus.SCRAMBLING:
            scrambler.generateNewScramble(scrambleLenSetting.value);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                scrambler.currentScramble,
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            );
          default:
            return Container();
        }
      }),
    );
  }
}
