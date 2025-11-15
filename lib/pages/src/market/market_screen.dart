import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/i18n/strings.g.dart';
import 'package:flutter_butailing/route/app_router.gr.dart';
import 'package:flutter_butailing/widgets/movie_tv_drawer.dart';

@RoutePage()
class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
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
          endDrawer: MovieTvDrawer(),
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
