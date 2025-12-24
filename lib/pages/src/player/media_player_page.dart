import 'package:flutter/foundation.dart';
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
    hwdec: 'auto',
    enableHardwareAcceleration: true,
  );
  late final player = Player(
    configuration: PlayerConfiguration(
      title: widget.videoTitle,
      ready: () {
        if (kDebugMode) {
          print('The initialization is complete.');
        }
      },
    ),
  );

  late final controller = VideoController(player, configuration: configuration);

  List<VideoTrack> videos = List.empty(growable: true);
  List<AudioTrack> audios = List.empty(growable: true);
  List<SubtitleTrack> subtitles = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      player.setAudioTrack(AudioTrack.auto());
      player.setPlaylistMode(PlaylistMode.single);
      player.stream.error.listen((error) => debugPrint(error));
      player.open(Media(widget.videoPath));
      await player.setVolume(50.0);
      player.stream.tracks.listen((event) {
        setState(() {
          videos = event.video;
          audios = event.audio;
          subtitles = event.subtitle;
        });
      });
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
          child: Stack(
            children: [
              Video(
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
            ],
          ),
        ),
      ),
    );
  }
}
