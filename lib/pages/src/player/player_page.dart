import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_butailing/pages/src/player/media_player_page.dart';
import 'package:flutter_butailing/pages/src/player/vlc_player_page.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:media_kit/media_kit.dart'; // Provides [Player], [Media], [Playlist] etc.
import 'package:media_kit_video/media_kit_video.dart'; // Provides [VideoController] & [Video] etc.

@RoutePage()
class PlayerPage extends StatefulWidget {
  final String videoPath;
  final String videoTitle;
  const PlayerPage({
    super.key,
    required this.videoPath,
    required this.videoTitle,
  });

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late VlcPlayerController vlcPlayerController = VlcPlayerController.file(
    File.fromUri(Uri.file(widget.videoPath)),
  );
  @override
  Widget build(BuildContext context) {
    return MediaPlayerPage(
      videoPath: widget.videoPath,
      videoTitle: widget.videoTitle,
    );
    // return VlcPlayerPage(
    //   videoPath: widget.videoPath,
    //   videoTitle: widget.videoTitle,
    //   controller: vlcPlayerController,
    // );
  }
}
