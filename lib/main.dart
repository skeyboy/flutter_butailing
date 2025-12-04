import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/src/bridge_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_butailing/app.dart';
import 'package:flutter_butailing/i18n/strings.g.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;

  if (Platform.isAndroid) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }
  await BridgeManager.manager.initBridge();
  runApp(TranslationProvider(child: ProviderScope(child: App())));
}
