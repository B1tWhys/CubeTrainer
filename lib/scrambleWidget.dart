import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cubetrainer/scrambler.dart';

class ScrambleWidget extends StatelessWidget {
  const ScrambleWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ScrambleGenerator>(
      builder: (context, scrambler, _) => Text(scrambler.currentScramble),
    );
  }
}
