import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/api/rest_client.dart';
import 'package:flutter_butailing/i18n/strings.g.dart';
import 'package:flutter_butailing/model/index.dart';
import 'package:flutter_butailing/route/app_router.gr.dart';

@RoutePage()
class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
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
    return AutoTabsRouter.tabBar(
      routes: [
        MovieMarketRoute(sa: 1),
        TvMarketRoute(sa: 2),
        LatestMarketRoute(),
      ],
      builder: (context, child, controller) {
        // ignore: unused_local_variable
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          endDrawer: Drawer(
            child: SafeArea(
              child: SingleChildScrollView(
                child: videoType != null
                    ? VideoTypeContainer(videoType: videoType)
                    : Center(child: Text("black")),
              ),
            ),
          ),
          appBar: AppBar(
            title: Text(context.topRoute.name),
            leading: AutoLeadingButton(),
            centerTitle: true,
            bottom: TabBar(
              controller: controller,
              tabs: [
                Tab(text: t.wiki.movie, icon: Icon(Icons.abc)),
                Tab(text: t.wiki.tv, icon: Icon(Icons.abc)),
                Tab(text: t.wiki.latest, icon: Icon(Icons.abc)),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
