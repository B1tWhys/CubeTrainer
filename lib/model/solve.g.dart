// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solve.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Solve _$SolveFromJson(Map<String, dynamic> json) {
  return Solve(
    (json['splits'] as List)
        ?.map((e) => e == null ? null : Duration(microseconds: e as int))
        ?.toList(),
    json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
    json['scramble'] as String,
  );
}

Map<String, dynamic> _$SolveToJson(Solve instance) => <String, dynamic>{
      'splits': instance.splits?.map((e) => e?.inMicroseconds)?.toList(),
      'timestamp': instance.timestamp?.toIso8601String(),
      'scramble': instance.scramble,
    };
