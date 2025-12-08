import 'dart:io';

import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:flutter/services.dart';

class VLCPlayerManager {
  static bool _initialized = false;

  static VlcPlayerController? vlcPlayerController;
  static Future<void> initialize({required String filePath}) async {
    if (_initialized) return;

    try {
      // 方法1：直接调用 VLC 初始化
      vlcPlayerController = VlcPlayerController.file(
        File(filePath),
        autoInitialize: true,
      );
      _initialized = true;
      print('VLC initialized successfully');
    } catch (e) {
      print('VLC initialization failed: $e');
      await _tryAlternativeInitialization();
    }
  }

  static Future<void> _tryAlternativeInitialization() async {
    try {
      // 方法2：通过 MethodChannel 初始化
      const channel = MethodChannel('flutter_vlc_player');
      await channel.invokeMethod('initialize');
      _initialized = true;
      print('VLC initialized via MethodChannel');
    } catch (e) {
      print('Alternative initialization also failed: $e');
      throw Exception('Failed to initialize VLC player: $e');
    }
  }

  static Future<VlcPlayerController> createController({
    required String url,
    bool autoPlay = true,
  }) async {
    await initialize(filePath: url);

    return VlcPlayerController.network(
      url,
      hwAcc: HwAcc.full,
      autoPlay: autoPlay,
      options: VlcPlayerOptions(
        advanced: VlcAdvancedOptions([
          // VlcAdvancedOptions.videoOnTop(false),
          // VlcAdvancedOptions.hwAcceleration(HwAcc.full.value),
        ]),
        // 添加 RTP/RTSP 支持
        rtp: VlcRtpOptions([VlcRtpOptions.rtpOverRtsp(true)]),
        // 添加字幕支持
        subtitle: VlcSubtitleOptions([
          // VlcSubtitleOptions.subsdecEncoding('UTF-8'),
        ]),
      ),
    );
  }
}
