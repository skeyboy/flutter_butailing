import 'package:flutter_butailing/bridge_client/response/torrent_details_response_file.dart';
import 'package:flutter_butailing/bridge_client/response/torrent_stats.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'torrent_details_response.freezed.dart';
part 'torrent_details_response.g.dart';

@freezed
abstract class TorrentDetailsResponse with _$TorrentDetailsResponse {
  const factory TorrentDetailsResponse({
    required int id,
    String? name,
    @Default([]) List<TorrentDetailsResponseFile>? files,
    @JsonKey(name: "info_hash") required String infoHash,
    @JsonKey(name: "output_folder") required String outputFolder,
    @Default([]) List<TorrentStats>? stats,
  }) = _TorrentDetailsResponse;

  factory TorrentDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$TorrentDetailsResponseFromJson(json);
}
