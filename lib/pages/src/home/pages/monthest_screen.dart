import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_butailing/api/rest_client.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:flutter_butailing/widgets/video_refresh_widget.dart';

@RoutePage()
class MonthestScreen extends StatefulWidget with Sc {
  @override
  final int sc;
  const MonthestScreen({super.key, @pathParam required this.sc});

  @override
  State<MonthestScreen> createState() => _MonthestScreenState();
}

class _MonthestScreenState extends State<MonthestScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  CancelToken? cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final videoList = await (await RestClient.client).getVideoList(
        sc: widget.sc,
        cancelToken: cancelToken,
      );
      logger.d("routesAll $videoList");
    });
  }

  @override
  void dispose() {
    cancelToken?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(body: VideoRefreshWidget(scWidget: widget));
  }
}
