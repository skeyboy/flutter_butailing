import 'package:flutter_butailing/bridge_client/response/peer_stats.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'snapshot.freezed.dart';
part 'snapshot.g.dart';

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
