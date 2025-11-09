import 'package:flutter_butailing/model/response/src/video_type_list_rule.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'video_type_list.freezed.dart';
part 'video_type_list.g.dart';

@freezed
abstract class VideoTypeList with _$VideoTypeList {
  const factory VideoTypeList({
    required int id,
    required String idcode,
    required String type,
    required String title,
    String? thesaurus,
    required List<VideoTypeListRule> rules,
    required dynamic relationship,
    required int weight,
    @JsonKey(name: "created_by") int? createdBy,
    @JsonKey(name: "updated_by") int? updatedBy,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(name: "updated_at") String? updatedAt,
    String? remark,
  }) = _VideoTypeList;

  factory VideoTypeList.fromJson(Map<String, Object?> json) =>
      _$VideoTypeListFromJson(json);
}
