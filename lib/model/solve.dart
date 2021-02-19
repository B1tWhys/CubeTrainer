class Solve {
  List<Duration> splits;
  get total => splits.reduce((value, element) => value += element);
  DateTime timestamp;
  String scramble;

  Solve(this.splits, this.timestamp, this.scramble);
}
