import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class MediaPlayerPage extends StatefulWidget {
  final String videoPath;
  final String videoTitle;
  const MediaPlayerPage({
    super.key,
    required this.videoPath,
    required this.videoTitle,
  });

  @override
  State<MediaPlayerPage> createState() => _MediaPlayerPageState();
}

class _MediaPlayerPageState extends State<MediaPlayerPage> {
  late final configuration = const VideoControllerConfiguration(
    // PLEASE USE auto-safe IN PRODUCTION.
    hwdec: 'auto',
    enableHardwareAcceleration: true,
  );
  // Create a [Player] to control playback.
  late final player = Player(
    configuration: PlayerConfiguration(
      // Supply your options:
      title: widget.videoTitle,
      ready: () {
        print('The initialization is complete.');
      },
    ),
  );
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player, configuration: configuration);

  @override
  void initState() {
    super.initState();
    // Play a [Media] or [Playlist].
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      player.setAudioTrack(AudioTrack.no());
      player.setPlaylistMode(PlaylistMode.loop);
      player.stream.error.listen((error) => debugPrint(error));
      player.open(Media(widget.videoPath));
      await player.setVolume(50.0);
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 9.0 / 16.0,
          // Use [Video] widget to display video output.
          child: Video(
            controls: (state) => MaterialVideoControls(state),
            subtitleViewConfiguration: const SubtitleViewConfiguration(
              style: TextStyle(
                height: 1.4,
                fontSize: 24.0,
                letterSpacing: 0.0,
                wordSpacing: 0.0,
                // color: Color(0xffffffff),
                fontWeight: FontWeight.normal,
                backgroundColor: Color(0xaa000000),
              ),
              textAlign: TextAlign.center,
              padding: EdgeInsets.all(24.0),
            ),
            controller: controller,
          ),
        ),
      ),
    );
  }
}
