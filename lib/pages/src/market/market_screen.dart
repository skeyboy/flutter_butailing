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
  Map<String, MovieTvDrawer> drawerCache = {
    // t.wiki.movie: MovieTvDrawer(identifier: t.wiki.movie),
    // t.wiki.tv: MovieTvDrawer(identifier: t.wiki.tv),
    // t.wiki.latest: MovieTvDrawer(identifier: t.wiki.latest),
  };
  MovieTvDrawer? onMovieDrawerFiler({required int index}) {
    final identifier = [t.wiki.movie, t.wiki.tv][index];
    if (!drawerCache.containsKey(identifier)) {
      drawerCache[identifier] = MovieTvDrawer(identifier: identifier);
    }
    return drawerCache[identifier];
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
          endDrawer: tabsRouter.activeIndex < 2
              ? onMovieDrawerFiler(index: tabsRouter.activeIndex)
              : null,
          appBar: AppBar(
            // title: Text(context.topRoute.name),
            leading: AutoLeadingButton(),
            centerTitle: true,
            title: TabBar(
              controller: controller,
              tabs: [
                Tab(text: t.wiki.movie),
                Tab(text: t.wiki.tv),
                Tab(text: t.wiki.latest),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
