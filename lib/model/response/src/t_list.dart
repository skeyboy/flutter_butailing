import 'package:freezed_annotation/freezed_annotation.dart';
part 't_list.freezed.dart';
part 't_list.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class TList with _$TList {
  const factory TList({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'aurl') required String aurl,
    @JsonKey(name: 'aurl1') required String aurl1,
    @JsonKey(name: 'pica') required String pica,
    @JsonKey(name: 'epic') required String epic,
    @JsonKey(name: 'zname') required String zname,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'daoyan') required String director,
    @JsonKey(name: 'bianji') required String editor,
    @JsonKey(name: 'yanyuan') required String actors,
    @JsonKey(name: 'conta') required String conta,
    @JsonKey(name: 'zsize') required String zsize,
    @JsonKey(name: 'eztime') required String eztime,
    @JsonKey(name: 'zlink') required String zlink,
    @JsonKey(name: 'down') required String down,
  }) = _TList;

  factory TList.fromJson(Map<String, Object?> json) => _$TListFromJson(json);
}
