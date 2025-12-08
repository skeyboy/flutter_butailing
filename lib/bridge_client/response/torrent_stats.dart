import 'package:flutter_butailing/bridge_client/response/live_stats.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'torrent_stats.freezed.dart';
part 'torrent_stats.g.dart';

@Freezed(genericArgumentFactories: true)
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
