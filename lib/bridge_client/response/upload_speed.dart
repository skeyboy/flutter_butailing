import 'package:freezed_annotation/freezed_annotation.dart';
part 'upload_speed.freezed.dart';
part 'upload_speed.g.dart';

@freezed
abstract class UploadSpeed with _$UploadSpeed {
  const factory UploadSpeed({
    int? mbps,
    @JsonKey(name: 'human_readable') String? humanReadable,
  }) = _UploadSpeed;

  factory UploadSpeed.fromJson(Map<String, dynamic> json) =>
      _$UploadSpeedFromJson(json);
}
