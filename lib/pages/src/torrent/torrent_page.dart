import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/bridge_client/bridge_response.dart';
import 'package:flutter_butailing/bridge_client/bridge_rest_client.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:flutter_butailing/route/app_router.gr.dart';
import 'package:flutter_butailing/bridge_client/bridge_manager.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

@RoutePage()
class TorrentPage extends StatefulWidget {
  const TorrentPage({super.key});

  @override
  State<TorrentPage> createState() => _TorrentPageState();
}

class _TorrentPageState extends State<TorrentPage>
    with TickerProviderStateMixin {
  List<TorrentDetailsResponse> torrents = List.empty(growable: true);
  late final controller = SlidableController(this);
  Timer? statsTimer;
  String? downloadSpeed;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final [torrentList, stats] = await Future.wait([
        _refreshTorrents(),
        BridgeManager.manager.stats(),
      ]);

      // await _refreshTorrents();
      // final stats = await BridgeManager.manager.stats();
      if (kDebugMode) {
        print("stats $stats  $torrents");
      }
      setState(() {});
      Timer.periodic(Duration(milliseconds: 500), (timer) async {
        if (context.mounted) {
          statsTimer = timer;
          final result = await BridgeManager.manager.stats();
          final stats = result.ok;
          if (context.mounted) {
            if (kDebugMode) {
              print("stats $stats  $torrents");
            }
            setState(() {
              downloadSpeed = stats?.downloadSpeed.humanReadable;
            });
          }
        }
      });
    });
    super.initState();
  }

  Future<List<TorrentDetailsResponse>> _refreshTorrents() async {
    final torrentsist = await BridgeManager.manager.torrentsist();
    for (TorrentDetailsResponse torrent in torrentsist.torrents ?? []) {
      if (!torrents.contains(torrent)) {
        torrents.add(torrent);
      }
    }
    return torrents;
  }

  @override
  void dispose() {
    statsTimer?.cancel();
    statsTimer = null;
    super.dispose();
  }

  void doNothing(BuildContext context) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            ListView(
              children: torrents.map((item) {
                return GestureDetector(
                  onLongPress: () async {
                    final result = await BridgeManager.manager.torrentDetail(
                      id: item.id,
                      infoHash: item.infoHash,
                    );
                    logger.d("torrentDetail $result");
                    showDialog(
                      context: context,
                      builder: (BuildContext bContext) {
                        return Stack(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  ...(result.ok?.files ?? []).map((file) {
                                    return Text("data");
                                  }),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Slidable(
                      // controller: controller,
                      key: ValueKey(item.infoHash),

                      // // The start action pane is the one at the left or the top side.
                      // startActionPane: ActionPane(
                      //   // A motion is a widget used to control how the pane animates.
                      //   motion: const ScrollMotion(),

                      //   // A pane can dismiss the Slidable.
                      //   dismissible: DismissiblePane(onDismissed: () {}),

                      //   // All actions are defined in the children parameter.
                      //   children: [],
                      // ),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            flex: 1,
                            onPressed: (_) async => await BridgeRestClient
                                .client
                                .startTorrent(infoHash: item.infoHash),
                            backgroundColor: const Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.archive,
                            label: 'Start',
                          ),
                          SlidableAction(
                            flex: 1,
                            onPressed: (_) async => await BridgeRestClient
                                .client
                                .pauseTorrent(infoHash: item.infoHash),
                            backgroundColor: const Color(0xFF0392CF),
                            foregroundColor: Colors.white,
                            icon: Icons.save,
                            label: 'Pause',
                          ), // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            flex: 1,
                            onPressed: (_) async {
                              final result = await BridgeManager.manager
                                  .deleteTorrent(
                                    id: item.id,
                                    infoHash: item.infoHash,
                                  );
                              if (kDebugMode) {
                                print("deleteTorrent result $result");
                              }
                              await _refreshTorrents();
                            },
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: InkWell(
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
                          crossAxisAlignment: .start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Text("${item.id}"),
                            Flexible(
                              child: Text(
                                '${item.name}',
                                maxLines: 2,
                                overflow: .fade,
                              ),
                            ),
                            TorrentState(infoHash: item.infoHash),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            if (downloadSpeed?.isNotEmpty ?? false)
              Positioned(
                bottom: 50,
                right: 50,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 150,
                    minWidth: 50,
                    maxWidth: 150,
                    minHeight: 50,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.greenAccent, width: 10),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          child: Flexible(
                            child: Text(
                              downloadSpeed ?? '',
                              overflow: .ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
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
  late int? progressBytes = 0;
  late int? uploadedBytes = 0;
  late int? totalBytes = 1;
  bool finished = false;
  Timer? _timer;

  TorrentStats? torrentStats;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Timer.periodic(Duration(milliseconds: max(500, Random().nextInt(5000))), (
        timer,
      ) async {
        if (context.mounted) {
          _timer = timer;
          try {
            final torrentStats = await BridgeManager.manager.torrentStats(
              infoHash: widget.infoHash,
            );

            final data = torrentStats.ok;
            setState(() {
              progressBytes = data?.progressBytes;
              uploadedBytes = data?.uploadedBytes;
              totalBytes = data?.totalBytes;
              finished = data?.finished ?? false;
              this.torrentStats = data;
            });
          } catch (e) {
            if (kDebugMode) {
              print("error of  BridgeManager.manager.torrentStats $e");
            }
          }
        } else {
          _timer?.cancel();
          _timer = null;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if ((totalBytes ?? 1) <= 1) {
      return SizedBox();
    }
    return finished
        ? InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.play_arrow),
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (torrentStats != null &&
                  torrentStats?.live?.downloadSpeed?.humanReadable != null)
                Row(
                  children: [
                    Text(
                      "下载速度:${torrentStats?.live?.downloadSpeed?.humanReadable}",
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearProgressIndicator(
                  value: (progressBytes ?? 0) / (totalBytes ?? 1),
                  minHeight: 15,
                ),
              ),
            ],
          );
  }
}
