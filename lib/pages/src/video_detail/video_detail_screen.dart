import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/api/rest_client.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:flutter_butailing/model/index.dart';
import 'package:flutter_butailing/model/response/src/ecca.dart';

@RoutePage()
class VideoDetailScreen extends StatefulWidget {
  final String idcode;
  const VideoDetailScreen({super.key, required this.idcode});

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  VideoDetail? videoDetail;
  bool showResources = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final result = await (await RestClient.client).getVideoDetail(
        idcode: widget.idcode,
      );
      logger.d('video detail : $result');
      setState(() {
        videoDetail = result.data;
      });
    });
  }

  Widget downloads({required String source, required List<Ecca> items}) {
    return MouseRegion(
      onEnter: (event) => logger.d('onEnter'),
      onExit: (event) => logger.d('onExit'),
      onHover: (event) => logger.d('onHover'),
      child: Column(
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
                      GestureDetector(
                        child: Text('磁力链接'),
                        onTap: () => logger.d(e.zlink),
                      ),
                      SizedBox(width: 16),
                      GestureDetector(
                        child: Text('种子文件'),
                        onTap: () => logger.d(WEB_HOST + e.down),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
                      _info(title: '导演', content: videoDetail?.director),
                      _info(
                        title: '编剧',
                        content: videoDetail?.bianji?.join(' / '),
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
            Column(
              mainAxisSize: MainAxisSize.min,
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
                _info(title: '导演', content: videoDetail?.director),
                _info(title: '编剧', content: videoDetail?.bianji?.join(' / ')),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() {
                    showResources = !showResources;
                  }),
                  child: Text(showResources ? "隐藏资源" : "显示资源"),
                ),
              ],
            ),
            !showResources
                ? Container()
                : Column(
                    mainAxisSize: MainAxisSize.min,
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
    return Scaffold(
      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header'),
            ),
            ...(videoDetail?.arrare.map((e) {
                  final items = videoDetail?.ecca?[e] as List<dynamic>? ?? [];
                  final eccas = items
                      .map((item) => Ecca.fromJson(item))
                      .toList();
                  return downloads(source: e, items: eccas);
                }) ??
                []),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(videoDetail?.title ?? ''),
        // actions: [
        //   IconButton(
        //     icon: Text(showResources ? "隐藏资源" : "显示资源"),
        //     tooltip: 'Open shopping cart',
        //     onPressed: () {
        //       setState(() {
        //         showResources = !showResources;
        //       });
        //     },
        //   ),
        // ],
      ),
      body: videoDetail == null
          ? Center(child: CircularProgressIndicator())
          : buildPCOrMobile(),
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
