import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Solve {
  List<Duration> splits;
  Duration get total => splits.reduce((value, element) => value += element);
  DateTime timestamp;
  String scramble;

  Solve(this.splits, this.timestamp, this.scramble);
}
