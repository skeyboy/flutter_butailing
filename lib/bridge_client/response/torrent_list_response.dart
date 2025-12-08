import 'package:flutter_butailing/bridge_client/response/torrent_details_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'torrent_list_response.freezed.dart';
part 'torrent_list_response.g.dart';

@freezed
abstract class TorrentListResponse with _$TorrentListResponse {
  factory TorrentListResponse({
    @Default([]) List<TorrentDetailsResponse>? torrents,
  }) = _TorrentListResponse;

  factory TorrentListResponse.fromJson(Map<String, dynamic> json) =>
      _$TorrentListResponseFromJson(json);
}
