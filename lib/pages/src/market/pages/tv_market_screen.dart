import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/api/rest_client.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:flutter_butailing/gen/assets.gen.dart';
import 'package:flutter_butailing/model/index.dart';
import 'package:flutter_butailing/route/app_router.gr.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class TvMarketScreen extends StatefulWidget {
  final int sa;

  const TvMarketScreen({super.key, @QueryParam() this.sa = 2});

  @override
  State<TvMarketScreen> createState() => _TvMarketScreenState();
}

class _TvMarketScreenState extends State<TvMarketScreen> {
  List<MovieItem> movieItems = List.empty(growable: true);
  late final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  int page = 1;

  Future<SharedPreferences> get pref async =>
      await SharedPreferences.getInstance();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _onRefresh();
    });
  }

  Future<void> _onRefresh() async {
    final movieResult = await (await RestClient.client).getVideoMovieList(
      sa: widget.sa,
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
      sa: widget.sa,
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
    return Stack(
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
              return InkWell(
                onTap: () => context.router.push(
                  VideoDetailRoute(idcode: '${movie.doubId}'),
                ),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      errorWidget: (context, url, error) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Placeholder(color: Colors.grey),
                        ),
                      ),
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
                                    color: Colors.white.withValues(alpha: 0.8),
                                  ),
                                  TextSpan(
                                    children: [
                                      WidgetSpan(child: SizedBox(width: 3)),
                                      WidgetSpan(
                                        child: Text(
                                          '豆瓣',
                                          style: TextStyle(
                                            color: Colors.white.withValues(
                                              alpha: 0.8,
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
                                    color: Colors.white.withValues(alpha: 0.8),
                                  ),
                                  TextSpan(
                                    children: [
                                      WidgetSpan(child: SizedBox(width: 3)),
                                      WidgetSpan(
                                        child: Text(
                                          'iMDB',
                                          style: TextStyle(
                                            // ignore: deprecated_member_use
                                            color: Colors.white.withValues(
                                              alpha: 0.8,
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
    );
  }
}
