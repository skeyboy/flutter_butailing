import 'package:flutter_butailing/bridge_client/bridge_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'session_stats_snapshot.freezed.dart';
part 'session_stats_snapshot.g.dart';

@freezed
abstract class SessionStatsSnapshot with _$SessionStatsSnapshot {
  const factory SessionStatsSnapshot({
    @JsonKey(name: 'fetched_bytes') required num fetchedBytes,
    @JsonKey(name: 'uploaded_bytes') required num uploadedBytes,
    @JsonKey(name: 'download_speed') required DownloadSpeed downloadSpeed,
    @JsonKey(name: 'upload_speed') required UploadSpeed uploadSpeed,
    required PeerStats peers,
    @JsonKey(name: 'uptime_seconds') required num uptimeSeconds,
  }) = _SessionStatsSnapshot;

  factory SessionStatsSnapshot.fromJson(Map<String, dynamic> json) =>
      _$SessionStatsSnapshotFromJson(json);
}
