import 'package:json_annotation/json_annotation.dart';

part 'solve.g.dart';

@JsonSerializable()
class Solve {
  List<Duration> splits;
  Duration get total => splits.reduce((value, element) => value += element);
  DateTime timestamp;
  String scramble;

  Solve(this.splits, this.timestamp, this.scramble);

  factory Solve.fromJson(Map<String, dynamic> json) => _$SolveFromJson(json);
  Map<String, dynamic> toJson() => _$SolveToJson(this);
}
