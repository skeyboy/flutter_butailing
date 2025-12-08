import 'package:flutter_butailing/bridge_client/response/average_piece_download_time.dart';
import 'package:flutter_butailing/bridge_client/response/download_speed.dart';
import 'package:flutter_butailing/bridge_client/response/stats_snapshot.dart';
import 'package:flutter_butailing/bridge_client/response/time_remaining.dart';
import 'package:flutter_butailing/bridge_client/response/upload_speed.dart';
import 'package:flutter_butailing/convert/safe_map_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'live_stats.freezed.dart';
part 'live_stats.g.dart';

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
