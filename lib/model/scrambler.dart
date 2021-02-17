import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';

enum Face { L, R, U, D, F, B }

enum Rotation { CW, CCW, DOUBLE }

class Move {
  Face face;
  Rotation rotation;

  Move(this.face, this.rotation);

  @override
  String toString() {
    String rot;
    switch (rotation) {
      case Rotation.CW:
        rot = "";
        break;
      case Rotation.CCW:
        rot = "'";
        break;
      case Rotation.DOUBLE:
        rot = "2";
        break;
    }

    return "${face.toString().split('.').last}$rot";
  }
}

class Scrambler extends ChangeNotifier {
  String _currentScramble = _genScramble(15);
  String get currentScramble => _currentScramble;
  String _prevScramble;
  String get prevScramble => _prevScramble;

  static Iterable<String> _randomMoves() sync* {
    Random random = Random();
    Set<Face> prevFace = Set.identity();
    while (true) {
      Set<Face> possibleFaces = Set.of(Face.values).difference(prevFace);
      Face faceChoice =
          possibleFaces.elementAt(random.nextInt(possibleFaces.length));
      Rotation rotChoice =
          Rotation.values[random.nextInt(Rotation.values.length)];
      prevFace = Set.of([faceChoice]);
      yield Move(faceChoice, rotChoice).toString();
    }
  }

  static String _genScramble(int scrambleLen) {
    return _randomMoves().take(scrambleLen).join(" ");
  }

  void generateNewScramble([int scrambleLen = 15]) {
    _prevScramble = _currentScramble;
    _currentScramble = _genScramble(scrambleLen);
    notifyListeners();
  }
}
