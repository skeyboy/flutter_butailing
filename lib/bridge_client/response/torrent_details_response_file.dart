import 'package:flutter_butailing/bridge_client/response/file_details_attrs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'torrent_details_response_file.freezed.dart';
part 'torrent_details_response_file.g.dart';

@freezed
abstract class TorrentDetailsResponseFile with _$TorrentDetailsResponseFile {
  const factory TorrentDetailsResponseFile({
    String? name,
    @Default([]) List<String>? components,
    required num length,
    @Default(false) bool? included,
    required FileDetailsAttrs attributes,
  }) = _TorrentDetailsResponseFile;

  factory TorrentDetailsResponseFile.fromJson(Map<String, dynamic> json) =>
      _$TorrentDetailsResponseFileFromJson(json);
}
