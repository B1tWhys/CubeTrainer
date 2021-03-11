import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
part 'solve.g.dart';

@JsonSerializable()
class Solve {
  String id;
  List<Duration> splits;
  Duration get total => splits.length == 0
      ? Duration.zero
      : splits.reduce((value, element) => value += element);
  DateTime timestamp;
  String scramble;

  Solve(this.splits, this.timestamp, this.scramble, {String id}) {
    this.id = id ?? Uuid().v4().toString();
  }

  factory Solve.fromJson(Map<String, dynamic> json) => _$SolveFromJson(json);
  Map<String, dynamic> toJson() => _$SolveToJson(this);
}
