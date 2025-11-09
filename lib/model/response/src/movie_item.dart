import 'package:freezed_annotation/freezed_annotation.dart';
part 'movie_item.freezed.dart';
part 'movie_item.g.dart';

@freezed
abstract class MovieItem with _$MovieItem {
  const factory MovieItem({
    @JsonKey(name: 'doub_id') required int doubId,
    required int id,
    required String aurl,
    required String epic,
    required String title,
    required String ejs,
    required String eqxd,
    required String niandai,
    required String ecc,
    required String edbf,
    required String imdbf,
    required String alias,
    @JsonKey(name: 'class') required String classfy,
    @JsonKey(name: 'long_time') String? longTime,
    @JsonKey(name: 'production_area') required String productionArea,
  }) = _MovieItem;

  factory MovieItem.fromJson(Map<String, Object?> json) =>
      _$MovieItemFromJson(json);
}
