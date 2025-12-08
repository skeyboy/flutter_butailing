import 'package:freezed_annotation/freezed_annotation.dart';
part 'file_details_attrs.freezed.dart';
part 'file_details_attrs.g.dart';

@freezed
abstract class FileDetailsAttrs with _$FileDetailsAttrs {
  const factory FileDetailsAttrs({
    @Default(false) bool? symlink,
    @Default(false) bool? hidden,
    @Default(false) bool? padding,
    @Default(false) bool? executable,
  }) = _FileDetailsAttrs;

  factory FileDetailsAttrs.fromJson(Map<String, dynamic> json) =>
      _$FileDetailsAttrsFromJson(json);
}
