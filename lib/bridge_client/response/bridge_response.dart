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
    required dynamic state,
    required num file_progress,
    String? error,
    required num progress_bytes,
    required num uploaded_bytes,
    required num total_bytes,
    required bool finished,
    LiveStats? live,
  }) = _TorrentStats;

  factory TorrentStats.fromJson(Map<String, dynamic> json) =>
      _$TorrentStatsFromJson(json);
}

@freezed
abstract class LiveStats with _$LiveStats {
  const factory LiveStats({
    StatsSnapshot? snapshot,
    num? average_piece_download_time,
    dynamic download_speed,
    dynamic upload_speed,
    dynamic time_remaining,
  }) = _LiveStats;

  factory LiveStats.fromJson(Map<String, dynamic> json) =>
      _$LiveStatsFromJson(json);
}

@freezed
abstract class StatsSnapshot with _$StatsSnapshot {
  const factory StatsSnapshot({
    required num downloaded_and_checked_bytes,
    required num fetched_bytes,
    required num downloaded_and_checked_pieces,
    required num total_piece_download_ms,
    required AggregatePeerStats peer_stats,
  }) = _StatsSnapshot;

  factory StatsSnapshot.fromJson(Map<String, dynamic> json) =>
      _$StatsSnapshotFromJson(json);
}

@freezed
abstract class AggregatePeerStats with _$AggregatePeerStats {
  const factory AggregatePeerStats({
    num? queued,
    num? connecting,
    num? live,
    num? seen,
    num? dead,
    num? not_needed,
    num? steals,
  }) = _AggregatePeerStats;

  factory AggregatePeerStats.fromJson(Map<String, dynamic> json) =>
      _$AggregatePeerStatsFromJson(json);
}
