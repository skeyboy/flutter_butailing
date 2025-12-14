import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/api/rest_client.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:flutter_butailing/gen/assets.gen.dart';
import 'package:flutter_butailing/i18n/strings.g.dart';
import 'package:flutter_butailing/model/index.dart';
import 'package:flutter_butailing/model/response/src/ecca.dart';
import 'package:flutter_butailing/bridge_client/bridge_manager.dart';
import 'package:flutter_butailing/pages/src/search/search_result_screen.dart';
import 'package:flutter_butailing/route/app_router.gr.dart';
import 'package:flutter_butailing/utili/download_manager.dart';
import 'package:flutter_butailing/widgets/auto_height_age_view.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
class VideoDetailScreen extends StatefulWidget {
  final String idcode;
  const VideoDetailScreen({super.key, required this.idcode});

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  VideoDetail? videoDetail;
  CancelToken? cancelToken = CancelToken();
  late final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final result = await (await RestClient.client).getVideoDetail(
        idcode: widget.idcode,
        cancelToken: cancelToken,
      );
      logger.d('video detail : $result');
      setState(() {
        videoDetail = result.data;
      });
    });
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    cancelToken?.cancel();
    super.dispose();
  }

  Widget downloads({required String source, required List<Ecca> items}) {
    return Column(
      spacing: 0.1,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          source,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...items.map(
          (e) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              spacing: 0.1,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(e.zname, style: TextStyle(), textAlign: TextAlign.start),
                Row(
                  children: [
                    Text(e.zsize),
                    Spacer(),
                    InkWell(
                      child: Text('磁力链接'),
                      onTap: () async {
                        try {
                          await EasyLoading.show(status: 'loading...');
                          final result = await BridgeManager.manager.addTorrent(
                            magnet: e.zlink,
                          );
                          if (kDebugMode) {
                            print("addTorrent magnet result: $result");
                          }
                          await EasyLoading.dismiss();
                          await EasyLoading.showToast(
                            "action success",
                            toastPosition: EasyLoadingToastPosition.bottom,
                          );
                        } catch (e) {
                          if (kDebugMode) {
                            print("BridgeManager.manager.addTorrent error: $e");
                          }
                          await EasyLoading.dismiss();
                          await EasyLoading.showToast(
                            e.toString(),
                            toastPosition: EasyLoadingToastPosition.bottom,
                          );
                        }
                        logger.d(e.zlink);
                      },
                    ),
                    SizedBox(width: 16),
                    InkWell(
                      child: Text('种子文件'),
                      onTap: () async {
                        final result = await DownloadManager().download(
                          url: WEB_HOST + e.down,
                          fileName: '${e.zname}.torrent',
                          onProgress: (received, total) {
                            logger.d(
                              'DownloadManager percentage: ${(received / total * 100).toStringAsFixed(0)}%',
                            );
                            if (total <= 0) {
                              return;
                            }
                            logger.d(
                              'DownloadManager torrent : $received/$total',
                            );
                          },
                        );
                        if (result.success) {
                          try {
                            await EasyLoading.show(status: 'loading...');
                            final file = File(result.filePath!);

                            final torrentBytesContent = await file
                                .readAsBytes();
                            final torrentBs64Content = base64Encode(
                              torrentBytesContent,
                            );
                            final addResult = await BridgeManager.manager
                                .addTorrentFile(
                                  torrentContent: torrentBs64Content,
                                );
                            logger.d("添加种子文件结果: $addResult");
                            await EasyLoading.dismiss();
                            await EasyLoading.showToast(
                              "action success",
                              toastPosition: EasyLoadingToastPosition.bottom,
                            );
                          } catch (e) {
                            await EasyLoading.dismiss();
                            if (kDebugMode) {
                              print("addTorrentFile error: $e");
                            }
                            await EasyLoading.showToast(
                              e.toString(),
                              toastPosition: EasyLoadingToastPosition.bottom,
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool get isPC => Platform.isLinux || Platform.isMacOS || Platform.isWindows;
  Widget buildPC() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Placeholder(),
                      ),
                    ),
                    imageUrl: videoDetail?.image ?? "",
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                          ),
                        ),
                  ),
                ),
                SizedBox(width: 32),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        child: Text(
                          videoDetail?.title ?? "",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      _info(
                        title: t.video.director,
                        content: videoDetail?.director,
                      ),
                      Row(
                        children: [
                          Text('编剧'),
                          Spacer(),
                          if ((videoDetail?.bianji?.length ?? 0) > 0)
                            ...(videoDetail?.bianji ?? []).map(
                              (e) => InkWell(
                                child: Text(e),
                                onTap: () => context.router.push(
                                  SearchResultRoute(keyword: e),
                                ),
                              ),
                            ),
                          Spacer(),
                        ],
                      ),
                      Wrap(
                        children: [
                          ...(videoDetail?.performer.split(',') ?? []).map((e) {
                            return InkWell(
                              child: Text(e),
                              onTap: () => context.router.push(
                                SearchResultRoute(keyword: e),
                              ),
                            );
                          }),
                        ],
                      ),
                      _info(
                        title: '国家地区',
                        content: videoDetail?.productionArea,
                      ),
                      _info(title: "语言", content: videoDetail?.language),
                      _info(title: '上映日期', content: videoDetail?.updatedAt),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        child: Center(
                          child: Text("剧情简介", style: TextStyle(fontSize: 22)),
                        ),
                      ),
                      Text(videoDetail?.abstract ?? ''),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
            AutoHeightPageView(
              pageController: _pageController,
              children: [
                ...(videoDetail?.arrare.map((e) {
                      final items =
                          videoDetail?.ecca?[e] as List<dynamic>? ?? [];
                      final eccas = items
                          .map((item) => Ecca.fromJson(item))
                          .toList();
                      return downloads(source: e, items: eccas);
                    }) ??
                    []),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMobile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              errorWidget: (context, url, error) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Assets.images.placeHolder.image(),
                ),
              ),
              imageUrl: videoDetail?.image ?? "",
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(value: progress.progress),
              ),
            ),
            SizedBox(width: 32),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: Text(
                    videoDetail?.title ?? "",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Row(
                  children: [
                    Text(t.video.director),
                    SizedBox(width: 32),
                    if ((videoDetail?.director.isNotEmpty ?? false) == true)
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...videoDetail!.director
                                  .split(",")
                                  .map(
                                    (e) => InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(e),
                                      ),
                                      onTap: () => context.router.push(
                                        SearchResultRoute(keyword: e),
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                Row(
                  children: [
                    Text('编剧'),
                    SizedBox(width: 32),
                    if ((videoDetail?.bianji?.length ?? 0) > 0)
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...(videoDetail?.bianji ?? []).map(
                                (e) => InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(e),
                                  ),
                                  onTap: () => context.router.push(
                                    SearchResultRoute(keyword: e),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                Row(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("演员"),
                    Expanded(
                      child: Wrap(
                        spacing: 4,
                        children: [
                          ...(videoDetail?.performer.split(',') ?? []).map((e) {
                            return InkWell(
                              child: Text(e),
                              onTap: () => context.router.push(
                                SearchResultRoute(keyword: e),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
                _info(title: '国家地区', content: videoDetail?.productionArea),
                _info(title: "语言", content: videoDetail?.language),
                _info(title: '上映日期', content: videoDetail?.updatedAt),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  child: Center(
                    child: Text("剧情简介", style: TextStyle(fontSize: 22)),
                  ),
                ),
                Text(videoDetail?.abstract ?? ''),
                SizedBox(height: 32),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Text("影视资源列表：")],
            ),
            AutoHeightPageView(
              pageController: _pageController,
              children: [
                ...(videoDetail?.arrare.map((e) {
                      final items =
                          videoDetail?.ecca?[e] as List<dynamic>? ?? [];
                      final eccas = items
                          .map((item) => Ecca.fromJson(item))
                          .toList();
                      return downloads(source: e, items: eccas);
                    }) ??
                    []),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPCOrMobile() {
    return LayoutBuilder(
      builder: (context, _) {
        return isPC ? buildPC() : buildMobile();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final keywords = [
      ...videoDetail?.director.split(',') ?? [],
      ...videoDetail?.edit.split(',') ?? [],
      ...videoDetail?.performer.split(',') ?? [],
    ];

    return Scaffold(
      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: keywords.isNotEmpty
            ? PageView.builder(
                itemCount: keywords.length,
                itemBuilder: (context, index) =>
                    SearchResultScreen(keyword: keywords[index]),
              )
            : null /* ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Text('Drawer Header'),
                  ),
                  ...(videoDetail?.arrare.map((e) {
                        final items =
                            videoDetail?.ecca?[e] as List<dynamic>? ?? [];
                        final eccas = items
                            .map((item) => Ecca.fromJson(item))
                            .toList();
                        return downloads(source: e, items: eccas);
                      }) ??
                      []),
                ],
              )*/,
      ),
      appBar: AppBar(centerTitle: true, title: Text(videoDetail?.title ?? '')),
      body: SafeArea(
        child: videoDetail == null
            ? Center(child: CircularProgressIndicator())
            : buildPCOrMobile(),
      ),
    );
  }

  Widget _info({String? title, String? content}) {
    return Row(
      children: [
        if (title != null) Text(title),
        Spacer(),
        if (content != null) Text(content),
        Spacer(),
      ],
    );
  }
}
