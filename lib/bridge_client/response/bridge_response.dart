import 'package:flutter_butailing/convert/safe_map_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'bridge_response.freezed.dart';
part 'bridge_response.g.dart';

@freezed
abstract class TorrentListResponse with _$TorrentListResponse {
  factory TorrentListResponse({
    @Default([]) List<TorrentDetailsResponse>? torrents,
  }) = _TorrentListResponse;

  factory TorrentListResponse.fromJson(Map<String, dynamic> json) =>
      _$TorrentListResponseFromJson(json);
}

@freezed
abstract class TorrentDetailsResponse with _$TorrentDetailsResponse {
  const factory TorrentDetailsResponse({
    required int id,
    String? name,
    @Default([]) List? files,
    @JsonKey(name: "info_hash") required String infoHash,
    @JsonKey(name: "output_folder") required String outputFolder,
    @Default([]) List? stats,
  }) = _TorrentDetailsResponse;

  factory TorrentDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$TorrentDetailsResponseFromJson(json);
}

@freezed
abstract class TorrentDetailsResponseFile with _$TorrentDetailsResponseFile {
  const factory TorrentDetailsResponseFile({
    String? name,
    @Default([]) List<String>? components,
    required num length,
    @Default(false) bool? included,
    required FileDetailsAttrs attributes,
  }) = _TorrentDetailsResponseFile;

  factory TorrentDetailsResponseFile.fromJson(Map<String, dynamic> json) =>
      _$TorrentDetailsResponseFileFromJson(json);
}

@freezed
abstract class FileDetailsAttrs with _$FileDetailsAttrs {
  const factory FileDetailsAttrs({
    @Default(false) bool? symlink,
    @Default(false) bool? hidden,
    @Default(false) bool? padding,
    @Default(false) bool? executable,
  }) = _FileDetailsAttrs;

  factory FileDetailsAttrs.fromJson(Map<String, dynamic> json) =>
      _$FileDetailsAttrsFromJson(json);
}

@freezed
abstract class ApiAddTorrentResponse with _$ApiAddTorrentResponse {
  const factory ApiAddTorrentResponse({
    required num id,
    required TorrentDetailsResponse details,
    @JsonKey(name: "output_folder") required String outputFolder,

    @Default([]) @JsonKey(name: 'seen_peers') List<dynamic>? seenPeers,
  }) = _ApiAddTorrentResponse;

  factory ApiAddTorrentResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiAddTorrentResponseFromJson(json);
}

@freezed
abstract class TorrentStats with _$TorrentStats {
  const factory TorrentStats({
    String? state,
    @JsonKey(name: 'file_progress') List<int?>? fileProgress,
    String? error,
    @JsonKey(name: 'progress_bytes') int? progressBytes,
    @JsonKey(name: 'uploaded_bytes') int? uploadedBytes,
    @JsonKey(name: 'total_bytes') int? totalBytes,
    bool? finished,
    LiveStats? live,
  }) = _TorrentStats;

  factory TorrentStats.fromJson(Map<String, dynamic> json) =>
      _$TorrentStatsFromJson(json);
}

@freezed
abstract class LiveStats with _$LiveStats {
  const factory LiveStats({
    StatsSnapshot? snapshot,
    @JsonKey(name: 'download_speed') DownloadSpeed? downloadSpeed,
    @JsonKey(name: 'upload_speed') UploadSpeed? uploadSpeed,
    @JsonKey(name: 'time_remaining') TimeRemaining? timeRemaining,
    @SafeMapConverter()
    @JsonKey(name: 'average_piece_download_time')
    AveragePieceDownloadTime? averagePieceDownloadTime,
  }) = _LiveStats;

  factory LiveStats.fromJson(Map<String, dynamic> json) =>
      _$LiveStatsFromJson(json);
}

@freezed
abstract class TimeRemaining with _$TimeRemaining {
  const factory TimeRemaining({
    TDuration? duration,
    @JsonKey(name: 'human_readable') String? humanReadable,
  }) = _TimeRemaining;

  factory TimeRemaining.fromJson(Map<String, dynamic> json) =>
      _$TimeRemainingFromJson(json);
}

@freezed
abstract class TDuration with _$TDuration {
  const factory TDuration({int? secs, int? nanos}) = _TDuration;

  factory TDuration.fromJson(Map<String, dynamic> json) =>
      _$TDurationFromJson(json);
}

@freezed
abstract class AveragePieceDownloadTime with _$AveragePieceDownloadTime {
  const factory AveragePieceDownloadTime({int? secs, int? nanos}) =
      _AveragePieceDownloadTime;

  factory AveragePieceDownloadTime.fromJson(Map<String, dynamic> json) =>
      _$AveragePieceDownloadTimeFromJson(json);
}

@freezed
abstract class StatsSnapshot with _$StatsSnapshot {
  const factory StatsSnapshot({
    @JsonKey(name: 'downloaded_and_checked_bytes')
    int? downloadedAndCheckedBytes,
    @JsonKey(name: 'fetched_bytes') int? fetchedBytes,
    @JsonKey(name: 'uploaded_bytes') int? uploadedBytes,
    @JsonKey(name: 'downloaded_and_checked_pieces')
    int? downloadedAndCheckedPieces,
    @JsonKey(name: 'total_piece_download_ms') int? totalPieceDownloadMs,
    @JsonKey(name: 'peer_stats') required AggregatePeerStats peerStats,
  }) = _StatsSnapshot;

  factory StatsSnapshot.fromJson(Map<String, dynamic> json) =>
      _$StatsSnapshotFromJson(json);
}

@freezed
abstract class AggregatePeerStats with _$AggregatePeerStats {
  const factory AggregatePeerStats({
    int? queued,
    int? connecting,
    int? live,
    int? seen,
    int? dead,
    @JsonKey(name: 'not_needed') int? notNeeded,
    int? steals,
  }) = _AggregatePeerStats;

  factory AggregatePeerStats.fromJson(Map<String, dynamic> json) =>
      _$AggregatePeerStatsFromJson(json);
}

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

@freezed
abstract class PeerStats with _$PeerStats {
  const factory PeerStats({
    int? queued,
    int? connecting,
    int? live,
    int? seen,
    int? dead,
    @JsonKey(name: 'not_needed') int? notNeeded,
    int? steals,
  }) = _PeerStats;

  factory PeerStats.fromJson(Map<String, dynamic> json) =>
      _$PeerStatsFromJson(json);
}

@freezed
abstract class Snapshot with _$Snapshot {
  const factory Snapshot({
    @JsonKey(name: 'downloaded_and_checked_bytes')
    int? downloadedAndCheckedBytes,
    @JsonKey(name: 'fetched_bytes') int? fetchedBytes,
    @JsonKey(name: 'uploaded_bytes') int? uploadedBytes,
    @JsonKey(name: 'downloaded_and_checked_pieces')
    int? downloadedAndCheckedPieces,
    @JsonKey(name: 'total_piece_download_ms') int? totalPieceDownloadMs,
    @JsonKey(name: 'peer_stats') PeerStats? peerStats,
  }) = _Snapshot;

  factory Snapshot.fromJson(Map<String, dynamic> json) =>
      _$SnapshotFromJson(json);
}

@freezed
abstract class DownloadSpeed with _$DownloadSpeed {
  const factory DownloadSpeed({
    int? mbps,
    @JsonKey(name: 'human_readable') String? humanReadable,
  }) = _DownloadSpeed;

  factory DownloadSpeed.fromJson(Map<String, dynamic> json) =>
      _$DownloadSpeedFromJson(json);
}

@freezed
abstract class UploadSpeed with _$UploadSpeed {
  const factory UploadSpeed({
    int? mbps,
    @JsonKey(name: 'human_readable') String? humanReadable,
  }) = _UploadSpeed;

  factory UploadSpeed.fromJson(Map<String, dynamic> json) =>
      _$UploadSpeedFromJson(json);
}
