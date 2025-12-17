import 'package:freezed_annotation/freezed_annotation.dart';
part 'movies_online_seed_type.freezed.dart';
part 'movies_online_seed_type.g.dart';

@freezed
abstract class MoviesOnlineSeedType with _$MoviesOnlineSeedType {
  const factory MoviesOnlineSeedType({
    required String label,
    required String value,
  }) = _MoviesOnlineSeedType;

  factory MoviesOnlineSeedType.fromJson(Map<String, Object?> json) =>
      _$MoviesOnlineSeedTypeFromJson(json);
}
