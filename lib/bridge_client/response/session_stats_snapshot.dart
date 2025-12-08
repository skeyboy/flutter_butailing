import 'package:freezed_annotation/freezed_annotation.dart';
part 'session_stats_snapshot.freezed.dart';
part 'session_stats_snapshot.g.dart';

@freezed
abstract class SessionStatsSnapshot with _$SessionStatsSnapshot {
  const factory SessionStatsSnapshot({
    required num fetched_bytes,
    required num uploaded_bytes,
    required dynamic download_speed,
    required dynamic upload_speed,
    required dynamic peers,
    required num uptime_seconds,
  }) = _SessionStatsSnapshot;

  factory SessionStatsSnapshot.fromJson(Map<String, dynamic> json) =>
      _$SessionStatsSnapshotFromJson(json);
}
