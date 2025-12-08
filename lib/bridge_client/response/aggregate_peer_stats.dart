import 'package:freezed_annotation/freezed_annotation.dart';
part 'aggregate_peer_stats.freezed.dart';
part 'aggregate_peer_stats.g.dart';

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
