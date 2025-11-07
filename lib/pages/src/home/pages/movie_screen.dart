import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/widgets/video_refresh_widget.dart';

@RoutePage()
class MovieScreen extends StatefulWidget with Sc {
  @override
  final int sc;
  const MovieScreen({super.key, @pathParam required this.sc});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(body: VideoRefreshWidget(scWidget: widget));
  }
}
