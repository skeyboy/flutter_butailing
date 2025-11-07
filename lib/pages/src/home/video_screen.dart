import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class VideoScreen extends StatefulWidget {
  final int sc;
  const VideoScreen({super.key, required this.sc});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
