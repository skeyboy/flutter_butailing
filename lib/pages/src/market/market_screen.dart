import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/api/rest_client.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:flutter_butailing/model/index.dart';
import 'package:flutter_butailing/route/app_router.gr.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  List<MovieItem> movieItems = List.empty(growable: true);
  late final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  int page = 1;

  VideoType? videoType;
  Future<SharedPreferences> get pref async =>
      await SharedPreferences.getInstance();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final client = await RestClient.client;
      final [result as ApiResponse<VideoType>, _] = await Future.wait([
        client.getVideoTypeList(),
        _onRefresh(),
      ]);
      setState(() {
        final data = result.data;
        if (data != null) {
          videoType = data;
        }
      });
      // await _onRefresh();
    });
  }

  Future<void> _onRefresh() async {
    final movieResult = await (await RestClient.client).getVideoMovieList(
      page: page,
    );
    logger.d("routesAll $movieResult");
    if (movieResult.data?.page == 1) {
      movieItems.clear();
    }
    setState(() {
      page = movieResult.data?.page ?? page;
      movieItems.addAll(movieResult.data?.data ?? []);
    });
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  void _onLoading() async {
    final movieResult = await (await RestClient.client).getVideoMovieList(
      page: page + 1,
    );
    logger.d("routesAll $movieResult");
    if (movieResult.data?.page == 1) {
      movieItems.clear();
    }
    setState(() {
      page = movieResult.data?.page ?? page;
      movieItems.addAll(movieResult.data?.data ?? []);
    });
    _refreshController.refreshCompleted(resetFooterState: true);

    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    // Center(
    //     child: ToggleSwitch(
    //       minWidth: 90.0,
    //       cornerRadius: 20.0,
    //       activeBgColors: [
    //         [Colors.green[800]!],
    //         [Colors.red[800]!],
    //       ],
    //       activeFgColor: Colors.white,
    //       inactiveBgColor: Colors.grey,
    //       inactiveFgColor: Colors.white,
    //       initialLabelIndex: 0,
    //       // totalSwitches: ["电影大全", "电视剧大全", "最新资源列表"].length,
    //       labels: ["电影大全", "电视剧大全", "最新资源列表"],
    //       // radiusStyle: true,
    //       onToggle: (index) {},
    //     ),
    //   );
    return Scaffold(
      appBar: AppBar(title: Text('电影大全'), centerTitle: true),
      body: Stack(
        children: [
          SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount: movieItems.length,
              itemBuilder: (context, index) {
                final movie = movieItems[index];
                return GestureDetector(
                  onTap: () => context.router.push(
                    VideoDetailRoute(idcode: '${movie.doubId}'),
                  ),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                              ),
                            ),
                        imageUrl: movie.epic,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                movie.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                              Row(
                                spacing: 3,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text.rich(
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    TextSpan(
                                      children: [
                                        WidgetSpan(child: SizedBox(width: 3)),
                                        WidgetSpan(
                                          child: Text(
                                            '豆瓣',
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(
                                                0.8,
                                              ),
                                            ),
                                          ),
                                        ),
                                        WidgetSpan(child: SizedBox(width: 3)),
                                      ],
                                      text: "movie.doubScore",
                                    ),
                                  ),
                                  Text.rich(
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    TextSpan(
                                      children: [
                                        WidgetSpan(child: SizedBox(width: 3)),
                                        WidgetSpan(
                                          child: Text(
                                            'iMDB',
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(
                                                0.8,
                                              ),
                                            ),
                                          ),
                                        ),
                                        WidgetSpan(child: SizedBox(width: 3)),
                                      ],
                                      text: "movie.iMDBScore",
                                    ),
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
              },
            ),
          ),
          if (movieItems.isEmpty) Center(child: CircularProgressIndicator()),
        ],
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: videoType != null
                ? VideoTypeContainer(videoType: videoType)
                : Center(child: Text("black")),
          ),
        ),
      ),
    );
  }
}
