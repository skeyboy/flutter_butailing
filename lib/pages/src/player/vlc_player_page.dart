// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';

// class VlcPlayerPage extends StatefulWidget {
//   final String videoPath;
//   final String videoTitle;
//   const VlcPlayerPage({
//     super.key,
//     required this.videoPath,
//     required this.videoTitle,
//   });

//   @override
//   State<VlcPlayerPage> createState() => _VlcPlayerPageState();
// }

// class _VlcPlayerPageState extends State<VlcPlayerPage> {
//   late final VlcPlayerController _videoPlayerController =
//       VlcPlayerController.file(
//         File.fromUri(Uri.parse(widget.videoPath)),
//         // 'https://media.w3.org/2010/05/sintel/trailer.mp4',
//         hwAcc: HwAcc.full,
//         autoPlay: false,
//         options: VlcPlayerOptions(),
//       );

//   Future<void> initializePlayer() async {}

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() async {
//     super.dispose();
//     await _videoPlayerController.stopRendererScanning();
//     await _videoPlayerController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: VlcPlayer(
//           controller: _videoPlayerController,
//           aspectRatio: 16 / 9,
//           placeholder: Center(child: CircularProgressIndicator()),
//         ),
//       ),
//     );
//   }
// }
