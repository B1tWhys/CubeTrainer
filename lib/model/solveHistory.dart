import 'package:flutter/foundation.dart';

import 'solve.dart';

class SolveHistory extends ChangeNotifier {
  List<Solve> solves = [
    // Solve([Duration(seconds: 30)], DateTime.now(), "ABCD")
  ];

  void add(Solve solve) {
    solves.add(solve);
    notifyListeners();
  }
}
