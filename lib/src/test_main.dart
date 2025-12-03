import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/bridge_client/bridge_rest_client.dart';
import 'package:flutter_butailing/src/rust/api/simple.dart';
import 'package:path_provider/path_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ArcSession session;
  late ArcApi api;
  bool finished = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('flutter_rust_bridge quickstart')),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  final response = await BridgeRestClient.client.addTorrent(
                    magnet:
                        "magnet:?xt=urn:btih:AF27E4C739EE7FCDAC0663A276DD7BE10599CACE",
                  );
                  if (kDebugMode) {
                    print("add_torrent $response");
                  }
                } catch (e) {
                  if (kDebugMode) {
                    print("add_torrent error $e");
                  }
                }
              },
              child: Text("测试API /api/v1/add_torrent"),
            ),

            ElevatedButton(
              onPressed: () async {
                try {
                  final hash = "af27e4c739ee7fcdac0663a276dd7be10599cace";

                  final response = await BridgeRestClient.client.torrentStats(
                    infoHash: hash,
                  );

                  print("stats/<info_hash> $response");

                  print(await await BridgeRestClient.client.stats());
                  final torrents = await BridgeRestClient.client.torrentsist();
                  print(torrents);
                } catch (e) {
                  print("Error $e");
                }
              },
              child: Text("测试API /api/v1/stats?id=xxx&hash=xxx"),
            ),
            ElevatedButton(
              onPressed: () async {
                final response = await BridgeRestClient.client.hello();
                print("hello  ${response} ");
              },
              child: Text("Hello"),
            ),
            ElevatedButton(
              onPressed: () async {
                final docDir = await getApplicationDocumentsDirectory();
                print("config  ${docDir.path} ");

                await config(destDir: docDir.path);
                print("config  ${docDir.path} ");
              },
              child: Text("启动服务"),
            ),
            ElevatedButton(
              onPressed: () async {
                final stateResult = await sessionStats(api: api);
                print(stateResult);
              },
              child: Text("State"),
            ),
            ElevatedButton(
              onPressed: () async {
                // magnet:?xt=urn:btih:cab507494d02ebb1178b38f2e9d7be299c86b862
                final destDir = (await getApplicationDocumentsDirectory()).path;
                final magnet =
                    "magnet:?xt=urn:btih:FEBB66FA953E4DB089031965E9FC9464B267E619";
                if (kDebugMode) {
                  print(
                    "destDir = $destDir       magnet:?xt=urn:btih:cab507494d02ebb1178b38f2e9d7be299c86b862",
                  );
                }
                final addResult = await addMagnet(api: api, magnet: magnet);
                final detailResult = torrentDetails(
                  api: api,
                  addTorrent: addResult,
                );

                print("${addResult} $detailResult");
              },
              child: Text("Download"),
            ),
            Center(
              child: Text(
                'Action: Call Rust `greet("Tom")`\nResult: `${greet(name: "Tom")}`',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
