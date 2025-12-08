import 'package:freezed_annotation/freezed_annotation.dart';
part 't_duration.freezed.dart';
part 't_duration.g.dart';

@freezed
abstract class TDuration with _$TDuration {
  const factory TDuration({int? secs, int? nanos}) = _TDuration;

  factory TDuration.fromJson(Map<String, dynamic> json) =>
      _$TDurationFromJson(json);
}
