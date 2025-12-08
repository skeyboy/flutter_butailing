import 'package:flutter_butailing/bridge_client/response/aggregate_peer_stats.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stats_snapshot.freezed.dart';
part 'stats_snapshot.g.dart';

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
