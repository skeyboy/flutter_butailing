import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/api/rest_client.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:flutter_butailing/gen/assets.gen.dart';
import 'package:flutter_butailing/model/response/src/video_list.dart';
import 'package:flutter_butailing/route/app_router.gr.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

mixin Sc {
  int get sc;
}

class VideoRefreshWidget<T extends Sc> extends StatefulWidget {
  final T scWidget;
  const VideoRefreshWidget({super.key, required this.scWidget});

  @override
  State<VideoRefreshWidget> createState() => _VideoRefreshWidgetState();
}

class _VideoRefreshWidgetState extends State<VideoRefreshWidget> {
  List<VideoList> videos = List.empty(growable: true);
  late final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _onRefresh();
    });
  }

  Future<void> _onRefresh() async {
    final videoList = await (await RestClient.client).getVideoList(
      sc: widget.scWidget.sc,
    );
    logger.d("routesAll $videoList");
    setState(() {
      videos.addAll(videoList.data?.data ?? []);
    });
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: WaterDropHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            addAutomaticKeepAlives: true,
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              // return InkResponse(
              return InkWell(
                // behavior: HitTestBehavior.opaque,
                onTap: () =>
                    context.router.push(VideoDetailRoute(idcode: video.idcode)),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      errorWidget: (context, url, error) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Assets.images.placeHolder.image(),
                        ),
                      ),
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                      imageUrl: video.image,
                    ),
                    Positioned(right: 8, top: 8, child: Text(video.zqxd)),
                    Positioned(
                      bottom: 8,
                      left: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              child: Text(
                                [
                                  video.years,
                                  video.classify,
                                  video.productionArea,
                                ].join(" / "),
                                // softWrap: true,
                                // maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  // ignore: deprecated_member_use
                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 16,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, 15.0),
                                    blurRadius: 15.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    video.title,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Row(
                                      spacing: 4,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(4),
                                            ),
                                            border: Border(
                                              left: BorderSide(
                                                color: Colors.green,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text.rich(
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black.withValues(
                                                  alpha: 0.8,
                                                ),
                                              ),
                                              TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                    child: SizedBox(width: 3),
                                                  ),
                                                  WidgetSpan(
                                                    child: Text(
                                                      '豆瓣',
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withValues(
                                                              alpha: 0.8,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  WidgetSpan(
                                                    child: SizedBox(width: 3),
                                                  ),
                                                ],
                                                text: video.doubScore,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                            border: Border(
                                              left: BorderSide(
                                                color: Colors.yellow,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text.rich(
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black.withValues(
                                                  alpha: 0.8,
                                                ),
                                              ),
                                              TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                    child: SizedBox(width: 3),
                                                  ),
                                                  WidgetSpan(
                                                    child: Text(
                                                      'iMDB',
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withValues(
                                                              alpha: 0.8,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  WidgetSpan(
                                                    child: SizedBox(width: 3),
                                                  ),
                                                ],
                                                text: video.iMDBScore,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        if (videos.isEmpty) Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
