import 'package:auto_route/auto_route.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/route/app_router.gr.dart';

@RoutePage()
class LatestMarketScreen extends StatefulWidget {
  const LatestMarketScreen({super.key});

  @override
  State<LatestMarketScreen> createState() => LatestMarketScreenState();
}

class LatestMarketScreenState extends State<LatestMarketScreen> {
  int currentIndex = 1;
  int get sc => currentIndex;

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      routes: [
        LatestDetailRoute(sc: 1),
        LatestDetailRoute(sc: 2),
        LatestDetailRoute(sc: 3),
        LatestDetailRoute(sc: 4),
        LatestDetailRoute(sc: 5),
      ],
      builder: (context, child, pageController) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: CustomSlidingSegmentedControl<int>(
                initialValue: tabsRouter.activeIndex + 1,
                children: {
                  1: Text('电影'),
                  2: Text('电视剧'),
                  3: Text('近日热门'),
                  4: Text('本周热门'),
                  5: Text('本月热门'),
                },
                decoration: BoxDecoration(
                  color: CupertinoColors.lightBackgroundGray,
                  borderRadius: BorderRadius.circular(8),
                ),
                thumbDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInToLinear,
                onValueChanged: (v) async {
                  // currentIndex = v;
                  // await _refresh(needRefresh: false);
                  // setState(() {});
                  tabsRouter.setActiveIndex(v - 1);
                },
              ),
            ),
            primary: false,
          ),
          body: child,
        );
      },
    );
  }
}
