import 'package:flutter/material.dart';
import 'package:flutter_butailing/api/rest_client.dart';
import 'package:flutter_butailing/model/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieTvDrawer extends ConsumerStatefulWidget {
  const MovieTvDrawer({super.key});

  @override
  ConsumerState<MovieTvDrawer> createState() => _MovieTvDrawerState();
}

class _MovieTvDrawerState extends ConsumerState<MovieTvDrawer> {
  VideoType? videoType;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final client = await RestClient.client;
      final result = await client.getVideoTypeList();
      if (context.mounted) {
        setState(() {
          final data = result.data;
          if (data != null) {
            videoType = data;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: videoType != null
              ? VideoTypeContainer(videoType: videoType)
              // ignore: sized_box_for_whitespace
              : Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator()),
                ),
        ),
      ),
    );
  }
}
