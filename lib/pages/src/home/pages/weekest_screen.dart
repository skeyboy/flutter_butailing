import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_butailing/api/rest_client.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:flutter_butailing/widgets/video_refresh_widget.dart';

@RoutePage()
class WeekestScreen extends StatefulWidget with Sc {
  @override
  final int sc;
  const WeekestScreen({super.key, @pathParam required this.sc});

  @override
  State<WeekestScreen> createState() => _WeekestScreenState();
}

class _WeekestScreenState extends State<WeekestScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final videoList = await (await RestClient.client).getVideoList(
        sc: widget.sc,
      );
      logger.d("routesAll $videoList");
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(body: VideoRefreshWidget(scWidget: widget));
  }
}
