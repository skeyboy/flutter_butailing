import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/api/rest_client.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:flutter_butailing/model/index.dart';
import 'package:flutter_butailing/route/app_router.gr.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

@RoutePage()
class LatestDetailScreen extends StatefulWidget {
  final int sc;
  const LatestDetailScreen({super.key, @pathParam required this.sc});

  @override
  State<LatestDetailScreen> createState() => _LatestDetailScreenState();
}

class _LatestDetailScreenState extends State<LatestDetailScreen> {
  int page = 1;
  int currentIndex = 1;
  int get sc => widget.sc;
  List<TList> tList = List.empty(growable: true);
  late final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _refresh();
    });
  }

  Future<void> _refresh() async {
    RestClient.client.then((client) async {
      final tListResult = await client.getTList(sc: sc, page: 1);
      logger.d("tList $tListResult");
      setState(() {
        page = (tListResult.data?.page ?? 1);
        if (tListResult.data?.data.isNotEmpty ?? false) {
          tList.clear();
        }
        tList.addAll(tListResult.data?.data ?? []);
      });
      _refreshController.refreshCompleted(resetFooterState: true);
    });
  }

  void _loadMore() {
    RestClient.client.then((client) async {
      final tListResult = await client.getTList(sc: sc, page: page + 1);
      logger.d("tList $tListResult");
      setState(() {
        page = (tListResult.data?.page ?? 1);
        tList.addAll(tListResult.data?.data ?? []);
      });
      _refreshController.refreshCompleted(resetFooterState: true);
      _refreshController.loadComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: _refreshController,
      onRefresh: _refresh,
      onLoading: _loadMore,
      child: ListView.builder(
        itemCount: tList.length,
        itemBuilder: (context, index) {
          final item = tList[index];
          return InkWell(
            onTap: () => context.router.push(
              VideoDetailRoute(idcode: item.aurl1.split('/').last),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 150,
                    margin: EdgeInsets.all(8),
                    child: CachedNetworkImage(
                      imageUrl: item.pica,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(item.zname),
                        AutoSizeText(item.title),
                        AutoSizeText('导演：${item.director}'),
                        AutoSizeText('编剧${item.director}'),
                        Flexible(
                          child: Text(
                            '简介：${item.conta}',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
