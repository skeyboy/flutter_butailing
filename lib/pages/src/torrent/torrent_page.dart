import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_butailing/bridge_client/response/bridge_response.dart';
import 'package:flutter_butailing/route/app_router.gr.dart';
import 'package:flutter_butailing/src/bridge_manager.dart';

@RoutePage()
class TorrentPage extends StatefulWidget {
  const TorrentPage({super.key});

  @override
  State<TorrentPage> createState() => _TorrentPageState();
}

class _TorrentPageState extends State<TorrentPage> {
  List<TorrentDetailsResponse> torrents = List.empty(growable: true);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final torrentsist = await BridgeManager.manager.torrentsist();
      for (TorrentDetailsResponse torrent in torrentsist.torrents ?? []) {
        if (!torrents.contains(torrent)) {
          torrents.add(torrent);
        }
      }

      final stats = await BridgeManager.manager.stats();
      if (kDebugMode) {
        print("stats $stats  $torrents");
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          final item = torrents[index];
          return InkWell(
            onTap: () async {
              // final result = await BridgeManager.manager.torrentStats(
              //   infoHash: item['info_hash'],
              // );
              // if (kDebugMode) {
              //   print("torrentStats $result");
              // }
              context.router.push(
                PlayerRoute(
                  videoPath: item.outputFolder,
                  videoTitle: item.name ?? "",
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${item.id}"),
                Text('${item.name}'),
                TorrentState(infoHash: item.infoHash),
              ],
            ),
          );
        },
        itemCount: torrents.length,
      ),
      appBar: AppBar(title: Text("下载列表 ${torrents.length}"), centerTitle: true),
    );
  }
}

class TorrentState extends StatefulWidget {
  final String infoHash;
  const TorrentState({super.key, required this.infoHash});

  @override
  State<TorrentState> createState() => _TorrentStateState();
}

class _TorrentStateState extends State<TorrentState> {
  late num progress_bytes = 0;
  late num uploaded_bytes = 0;
  late num total_bytes = 1;
  bool finished = false;
  Timer? _timer;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Timer.periodic(Duration(seconds: 5), (timer) async {
        _timer = timer;
        if (context.mounted) {
          try {
            final torrentStats = await BridgeManager.manager.torrentStats(
              infoHash: widget.infoHash,
            );

            final data = torrentStats.ok;
            setState(() {
              progress_bytes = data.progress_bytes;
              uploaded_bytes = data.uploaded_bytes;
              total_bytes = data.total_bytes;
              finished = data.finished as bool? ?? false;
            });
          } catch (e) {
            if (kDebugMode) {
              print("error of  BridgeManager.manager.torrentStats $e");
            }
          }
        } else {
          _timer?.cancel();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return finished
        ? InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.play_arrow),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(
              value: progress_bytes.toDouble() / total_bytes.toDouble(),
              minHeight: 15,
            ),
          );
  }
}
