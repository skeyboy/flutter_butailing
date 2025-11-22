import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/i18n/strings.g.dart';
import 'package:flutter_butailing/model/index.dart';
import 'package:flutter_butailing/providers/index.dart';
import 'package:flutter_butailing/route/app_router.gr.dart';
import 'package:flutter_butailing/widgets/user_info_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<RoutesAll> routesAll = List.empty(growable: true);
  Future<SharedPreferences> get pref async =>
      await SharedPreferences.getInstance();
  VideoType? videoType;
  TextEditingController searchController = TextEditingController();

  bool isLogined = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      searchController.addListener(() {
        final keyword = searchController.text;
        if (keyword.isNotEmpty) {
          // context.router.push(SearchResultRoute(keyword: keyword));
        }
      });
      ref.listenManual(localeLanguageProvider, (pre, next) {
        if (pre?.value?.languageCode != next.value?.languageCode ||
            pre?.value?.countryCode != next.value?.countryCode) {
          setState(() {});
        }
      });
      LocaleSettings.instance.setLocale(
        ref.read(localeLanguageProvider.notifier).currentLocale,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final localeLanguageRef = ref.watch(localeLanguageProvider.notifier);
    return AutoTabsRouter.tabBar(
      routes: [
        MovieRoute(sc: 1),
        MovieRoute(sc: 2),
        MovieRoute(sc: 3),
        MovieRoute(sc: 4),
        MovieRoute(sc: 5),
      ],
      builder: (context, child, controller) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Container(
              constraints: BoxConstraints(minHeight: 10, maxHeight: 24),
              child: TextField(
                controller: searchController,
                onSubmitted: (value) => {
                  if (value.isNotEmpty)
                    {context.router.push(SearchResultRoute(keyword: value))},
                },
                maxLines: 1,
                // minLines: 1,
                // style: TextStyle(fontSize: 7),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 1),
                  isCollapsed: true,
                  filled: true,

                  suffix: Icon(Icons.search, size: 14),
                  prefixIconConstraints: BoxConstraints(),
                  hintText: '输入想要的影视资源',
                  // hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
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
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Column(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(t.config.theme.title),
                            ToggleSwitch(
                              totalSwitches: 3,
                              customTextStyles: [
                                TextStyle(fontSize: 10),
                                TextStyle(fontSize: 10),
                                TextStyle(fontSize: 10),
                              ],
                              // minWidth: 90.0,
                              labels: [
                                t.config.theme.light,
                                t.config.theme.dark,
                                t.config.theme.system,
                              ],
                              initialLabelIndex:
                                  [
                                    ThemeMode.light,
                                    ThemeMode.dark,
                                    ThemeMode.system,
                                  ].indexOf(
                                    ref.watch(themeConfigProvider).value ??
                                        ThemeMode.system,
                                  ),
                              onToggle: (index) {
                                if (index == 0) {
                                  ref
                                      .read(themeConfigProvider.notifier)
                                      .switchTheme(ThemeMode.light);
                                } else if (index == 1) {
                                  ref
                                      .read(themeConfigProvider.notifier)
                                      .switchTheme(ThemeMode.dark);
                                } else if (index == 2) {
                                  ref
                                      .read(themeConfigProvider.notifier)
                                      .switchTheme(ThemeMode.system);
                                }
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(t.config.language.title),
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
                              initialLabelIndex: LocaleSettings
                                  .instance
                                  .supportedLocales
                                  .map((e) => e.languageCode)
                                  .toList()
                                  .indexOf(
                                    localeLanguageRef
                                        .currentLocale
                                        .languageCode,
                                  ),
                              totalSwitches: LocaleSettings
                                  .instance
                                  .supportedLocales
                                  .length,
                              labels: LocaleSettings.instance.supportedLocales
                                  .map(
                                    (e) =>
                                        Translations.of(
                                              context,
                                            )['config.language.${e.languageCode}']
                                            as String,
                                  )
                                  .toList(),
                              radiusStyle: true,
                              onToggle: (index) async {
                                final languageCode = LocaleSettings
                                    .instance
                                    .supportedLocales
                                    .map((e) => e.languageCode)
                                    .toList()[index ?? 0];
                                await localeLanguageRef.changeLanguageCode(
                                  languageCode: languageCode,
                                );
                                ref.invalidate(localeLanguageProvider);
                              },
                            ),
                          ],
                        ),

                        Spacer(),
                        UserInfoView(),
                        SizedBox(height: 200),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.pink,
            unselectedItemColor: Colors.pinkAccent.withValues(alpha: 0.5),
            showUnselectedLabels: true,
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
