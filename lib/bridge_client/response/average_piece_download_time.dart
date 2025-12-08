import 'package:freezed_annotation/freezed_annotation.dart';
part 'average_piece_download_time.freezed.dart';
part 'average_piece_download_time.g.dart';

@freezed
abstract class AveragePieceDownloadTime with _$AveragePieceDownloadTime {
  const factory AveragePieceDownloadTime({int? secs, int? nanos}) =
      _AveragePieceDownloadTime;

  factory AveragePieceDownloadTime.fromJson(Map<String, dynamic> json) =>
      _$AveragePieceDownloadTimeFromJson(json);
}
