import 'package:flutter_butailing/bridge_client/response/torrent_details_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'api_add_torrent_response.freezed.dart';
part 'api_add_torrent_response.g.dart';

@freezed
abstract class ApiAddTorrentResponse with _$ApiAddTorrentResponse {
  const factory ApiAddTorrentResponse({
    required num id,
    required TorrentDetailsResponse details,
    @JsonKey(name: "output_folder") required String outputFolder,

    @Default([]) @JsonKey(name: 'seen_peers') List<dynamic>? seenPeers,
  }) = _ApiAddTorrentResponse;

  factory ApiAddTorrentResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiAddTorrentResponseFromJson(json);
}
