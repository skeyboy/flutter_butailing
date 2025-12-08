import 'package:freezed_annotation/freezed_annotation.dart';
part 'download_speed.freezed.dart';
part 'download_speed.g.dart';

@freezed
abstract class DownloadSpeed with _$DownloadSpeed {
  const factory DownloadSpeed({
    int? mbps,
    @JsonKey(name: 'human_readable') String? humanReadable,
  }) = _DownloadSpeed;

  factory DownloadSpeed.fromJson(Map<String, dynamic> json) =>
      _$DownloadSpeedFromJson(json);
}
