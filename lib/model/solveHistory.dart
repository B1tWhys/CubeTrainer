import 'solve.dart';

abstract class SolveHistory {
  List<Solve> solves;
  void add(Solve solve);
}
