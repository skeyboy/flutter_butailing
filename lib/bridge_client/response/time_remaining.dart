import 'package:flutter_butailing/bridge_client/response/t_duration.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'time_remaining.freezed.dart';
part 'time_remaining.g.dart';

@freezed
abstract class TimeRemaining with _$TimeRemaining {
  const factory TimeRemaining({
    TDuration? duration,
    @JsonKey(name: 'human_readable') String? humanReadable,
  }) = _TimeRemaining;

  factory TimeRemaining.fromJson(Map<String, dynamic> json) =>
      _$TimeRemainingFromJson(json);
}
