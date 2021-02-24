import 'solve.dart';
import 'package:flutter/foundation.dart';

abstract class SolveHistoryInterface with ChangeNotifier {
  List<Solve> solves;
  void add(Solve solve);
}
