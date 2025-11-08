import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/model/response/src/routes_all.dart';
import 'package:flutter_butailing/route/app_router.gr.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RoutesAll> routesAll = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // final result = await (await RestClient.client).routesAll();

      // final videoList = await (await RestClient.client).getVideoList(sc: 1);
      // logger.d("routesAll $result");
    });
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: [
        MovieRoute(sc: 1),
        TvRoute(sc: 2),
        LatestRoute(sc: 3),
        WeekestRoute(sc: 4),
        MonthestRoute(sc: 5),
      ],
      builder: (context, child, controller) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          // appBar: AppBar(
          //   title: Text(context.topRoute.name),
          //   leading: AutoLeadingButton(),
          //   bottom: TabBar(
          //     isScrollable: false,
          //     controller: controller,
          //     tabs: const [
          //       Tab(text: '电影', icon: Icon(Icons.home)),
          //       Tab(text: '电视剧', icon: Icon(Icons.movie)),
          //       Tab(text: '今日热门', icon: Icon(Icons.movie)),
          //       Tab(text: '本周热门', icon: Icon(Icons.tv)),
          //       Tab(text: '本月热门', icon: Icon(Icons.tv)),
          //     ],
          //   ),
          // ),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.pinkAccent,
            unselectedItemColor: Colors.pinkAccent,
            unselectedLabelStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
            selectedLabelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(label: '电影', icon: Icon(Icons.home)),
              BottomNavigationBarItem(label: '电视剧', icon: Icon(Icons.tv)),
              BottomNavigationBarItem(
                label: '今日热门',
                icon: Icon(Icons.new_label),
              ),
              BottomNavigationBarItem(label: '本周热门', icon: Icon(Icons.weekend)),
              BottomNavigationBarItem(
                label: '本月热门',
                icon: Icon(Icons.monitor_sharp),
              ),
            ],
          ),
        );
      },
    );
  }
}
