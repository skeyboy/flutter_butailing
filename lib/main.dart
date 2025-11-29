// The original content is temporarily commented out to allow generating a self-contained demo - feel free to uncomment later.

// import 'dart:io';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_butailing/app.dart';
// import 'package:flutter_butailing/i18n/strings.g.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
//
//   if (Platform.isAndroid) {
//     await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
//   }
//
//   runApp(TranslationProvider(child: ProviderScope(child: App())));
// }
//

import 'package:flutter/material.dart';
import 'package:flutter_butailing/src/rust/api/simple.dart';
import 'package:flutter_butailing/src/rust/frb_generated.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('flutter_rust_bridge quickstart')),
        body: Column(
          children: [
            Center(
              child: Text(
                'Action: Call Rust `greet("Tom")`\nResult: `${greet(name: "Tom")}`',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final result = hello(name: "HHHHH");
                print("$result");
              },
              child: Text("show"),
            ),
          ],
        ),
      ),
    );
  }
}
