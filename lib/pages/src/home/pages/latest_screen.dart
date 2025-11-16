import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/api/rest_client.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:flutter_butailing/widgets/video_refresh_widget.dart';

@RoutePage()
class LatestScreen extends StatefulWidget with Sc {
  @override
  final int sc;
  const LatestScreen({super.key, @pathParam required this.sc});

  @override
  State<LatestScreen> createState() => _LatestScreenState();
}

class _LatestScreenState extends State<LatestScreen>
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
