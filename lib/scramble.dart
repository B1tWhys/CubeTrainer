import 'package:flutter/material.dart';

enum Face { L, R, U, D, F, B }

enum Rotation { CW, CCW, DOUBLE }

class ScrambleWidget extends StatelessWidget {
  static Set<String> _faces = Set.from(['L', 'R', 'U', 'D', 'F', 'B']);

  const ScrambleWidget({Key key}) : super(key: key);

  String randomAction({Face prevFace}) {}

  String generateScramble([int scrambleLen = 15]) {
    // Set<String> prev = Set();
    // List<String> scramble = [];
    // for (int i = 0; i < scrambleLen; i++) {}
    return "FU'LBDR2";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(generateScramble()),
    );
  }
}
