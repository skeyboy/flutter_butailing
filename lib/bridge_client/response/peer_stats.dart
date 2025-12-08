import 'package:freezed_annotation/freezed_annotation.dart';
part 'peer_stats.freezed.dart';
part 'peer_stats.g.dart';

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
