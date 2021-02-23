import 'package:cubetrainer/model/solveHistory.dart';
import 'package:flutter/foundation.dart';

import 'solve.dart';

class InMemorySolveHistoryImpl extends ChangeNotifier implements SolveHistory {
  List<Solve> solves = [
    // Solve([Duration(seconds: 30)], DateTime.now(), "ABCD")
  ];

  void add(Solve solve) {
    solves.insert(0, solve);
    notifyListeners();
  }
}
