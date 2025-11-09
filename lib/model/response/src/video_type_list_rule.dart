import 'package:freezed_annotation/freezed_annotation.dart';
part 'video_type_list_rule.freezed.dart';
part 'video_type_list_rule.g.dart';

@freezed
abstract class VideoTypeListRule with _$VideoTypeListRule {
  const factory VideoTypeListRule({
    required String key,
    required String value,
  }) = _VideoTypeListRule;

  factory VideoTypeListRule.fromJson(Map<String, Object?> json) =>
      _$VideoTypeListRuleFromJson(json);
}
