import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/api/rest_client.dart';
import 'package:flutter_butailing/config/app_inject.dart';
import 'package:flutter_butailing/gen/assets.gen.dart';
import 'package:flutter_butailing/model/index.dart';
import 'package:flutter_butailing/route/app_router.gr.dart';
import 'package:fluttertoast/fluttertoast.dart';

@RoutePage()
class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> with AppInject {
  late List<MovieItem> movies = List.empty(growable: true);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadData();
    });
    super.initState();
  }

  Future<void> loadData() async {
    final result = await getIt<RestClient>().getCollectVideoMovieList();
    setState(() {
      movies = result.data?.data ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("收藏")),
      body: SingleChildScrollView(
        child: Wrap(
          direction: Axis.horizontal,
          children: [
            ...(movies.map((video) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2 * 16 / 9,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      context.router.push(
                        VideoDetailRoute(idcode: "${video.doubId}"),
                      );
                    },
                    child: Stack(
                      // alignment: .bottomCenter,
                      children: [
                        CachedNetworkImage(
                          errorWidget: (context, url, error) => Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Assets.images.placeHolder.image(),
                            ),
                          ),
                          progressIndicatorBuilder: (context, url, progress) =>
                              Center(
                                child: CircularProgressIndicator(
                                  value: progress.progress,
                                ),
                              ),
                          imageUrl: video.epic,
                        ),
                        Positioned(bottom: 16, child: Text(video.title)),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: InkWell(
                            onTap: () async {
                              try {
                                final result = await getIt<RestClient>()
                                    .removeCollect(moviceId: "${video.doubId}");
                                await Fluttertoast.showToast(
                                  msg: result.message,
                                );
                              } catch (e) {
                                await Fluttertoast.showToast(msg: e.toString());
                              }
                            },
                            child: Icon(Icons.favorite_border_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })),
          ],
        ),
      ),
    );
  }
}
