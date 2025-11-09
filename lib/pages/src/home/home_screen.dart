import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/i18n/strings.g.dart';
import 'package:flutter_butailing/model/index.dart';
import 'package:flutter_butailing/route/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RoutesAll> routesAll = List.empty(growable: true);
  Future<SharedPreferences> get pref async =>
      await SharedPreferences.getInstance();
  VideoType? videoType;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final languageCode =
          (await pref).getString('languageCode') ??
          LocaleSettings.instance.currentLocale.languageCode;
      await _changeLanguageCode(languageCode: languageCode);
    });
  }

  Future<void> _changeLanguageCode({required String languageCode}) async {
    final index = LocaleSettings.instance.supportedLocales
        .map((e) => e.languageCode)
        .toList()
        .indexOf(languageCode);
    final locale = LocaleSettings.instance.supportedLocales[index];
    (await pref).setString('languageCode', locale.languageCode);
    final appLocale = AppLocaleUtils.parseLocaleParts(
      languageCode: locale.languageCode,
      countryCode: locale.countryCode,
      scriptCode: locale.scriptCode,
    );
    LocaleSettings.instance.setLocale(appLocale);
    setState(() {});
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
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.app_registration_rounded),
                tooltip: 'Open market',
                onPressed: () {
                  context.router.push(MarketRoute());
                },
              ),
            ],
          ),
          drawer: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ToggleSwitch(
                    minWidth: 90.0,
                    cornerRadius: 20.0,
                    activeBgColors: [
                      [Colors.green[800]!],
                      [Colors.red[800]!],
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: LocaleSettings.instance.supportedLocales
                        .map((e) => e.languageCode)
                        .toList()
                        .indexOf(
                          LocaleSettings.instance.currentLocale.languageCode,
                        ),
                    totalSwitches:
                        LocaleSettings.instance.supportedLocales.length,
                    labels: LocaleSettings.instance.supportedLocales
                        .map((e) => e.languageCode)
                        .toList(),
                    radiusStyle: true,
                    onToggle: (index) async {
                      final languageCode = LocaleSettings
                          .instance
                          .supportedLocales
                          .map((e) => e.languageCode)
                          .toList()[index ?? 0];
                      await _changeLanguageCode(languageCode: languageCode);
                    },
                  ),
                ],
              ),
            ),
          ),
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
              BottomNavigationBarItem(label: t.movie, icon: Icon(Icons.home)),
              BottomNavigationBarItem(label: t.tv, icon: Icon(Icons.tv)),
              BottomNavigationBarItem(
                label: t.today_hot,
                icon: Icon(Icons.new_label),
              ),
              BottomNavigationBarItem(
                label: t.week_hot,
                icon: Icon(Icons.weekend),
              ),
              BottomNavigationBarItem(
                label: t.month_hot,
                icon: Icon(Icons.monitor_sharp),
              ),
            ],
          ),
        );
      },
    );
  }
}
