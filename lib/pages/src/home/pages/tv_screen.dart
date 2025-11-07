import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/widgets/video_refresh_widget.dart';

@RoutePage()
class TvScreen extends StatefulWidget with Sc {
  @override
  final int sc;
  const TvScreen({super.key, @pathParam required this.sc});

  @override
  State<TvScreen> createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(body: VideoRefreshWidget(scWidget: widget));
  }
}
