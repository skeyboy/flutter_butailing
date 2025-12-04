import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    // Play a [Media] or [Playlist].
    player.open(Media(widget.videoPath));
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
