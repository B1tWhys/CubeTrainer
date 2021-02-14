import 'package:flutter/material.dart';

enum CubeStatus {
  SCRAMBLING,
  SOLVING,
}

class SolveState extends ChangeNotifier {
  CubeStatus _status;

  SolveState({CubeStatus status = CubeStatus.SCRAMBLING}) {
    this._status = status;
  }

  CubeStatus currentStatus() {
    return _status;
  }

  void setSolved() {
    _status = CubeStatus.SCRAMBLING;
    print("Solve State transitioned to: $_status"); // TODO: DRY with a setter
    notifyListeners();
  }

  void setSolving() {
    _status = CubeStatus.SOLVING;
    print("Solve State transitioned to: $_status");
    notifyListeners();
  }
}
