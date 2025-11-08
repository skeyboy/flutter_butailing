import 'package:freezed_annotation/freezed_annotation.dart';
part 'video_detail.freezed.dart';
part 'video_detail.g.dart';

@freezed
abstract class VideoDetail with _$VideoDetail {
  const factory VideoDetail({
    @JsonKey(name: 'is_vip') required int isVip,
    required int id,
    required String idcode,
    required int type,
    required String title,
    required String otitle,
    required String alias,
    required String image,
    @JsonKey(name: "is_local_img") required int isLocalImg,
    @JsonKey(name: "doub_id") required int doubId,
    @JsonKey(name: "doub_score") required String? doubScore,
    @JsonKey(name: "doub_score_peo_num") int? doubScorePeoNum,
    @JsonKey(name: "IMDB_number") required String iMDBNumber,
    @JsonKey(name: "IMDB_score") required String iMDBScore,
    @JsonKey(name: "IMDB_score_peo_num") int? iMDBScorePeoNum,
    required String quality,
    required String years,
    required String release,
    @JsonKey(name: "class") required String classify,
    @JsonKey(name: "production_area") required String productionArea,
    required String episodes,
    @JsonKey(name: "long_time") required String longTime,
    required String language,
    required String tags,
    required String director,
    required String edit,
    required String performer,
    required String abstract,
    @JsonKey(name: "is_top") required int isTop,
    @JsonKey(name: "top_at") @Default(false) bool? topAt,
    @JsonKey(name: "show_number") String? showNumber,
    @JsonKey(name: "is_show_seed") required int isShowSeed,
    @JsonKey(name: "created_by") String? createdBy,
    @JsonKey(name: "updated_by") String? updatedBy,
    @JsonKey(name: "seed_updated_at") required String seedUpdatedAt,
    @JsonKey(name: "created_at") required String createdAt,
    @JsonKey(name: "updated_at") required String updatedAt,
    @JsonKey(name: "deleted_at") String? deletedAt,
    String? remark,
    required String definition,
    required int tp,
    @JsonKey(name: "movies_id_count") int? moviesIdCount,
    required int znum,
    String? ejs,
    List<String>? bianji,
    required List<String> biaoqian,
    required List<String> arrare,
    @Default({}) Map<String, dynamic>? ecca,
  }) = _VideoDetail;

  factory VideoDetail.fromJson(Map<String, Object?> json) =>
      _$VideoDetailFromJson(json);
}
