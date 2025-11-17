import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
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
  CancelToken? cancelToken = CancelToken();

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
