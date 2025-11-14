// assuming this is the root widget of your App
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/config/app_refresh_config.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:flutter_butailing/i18n/strings.g.dart';
import 'package:flutter_butailing/route/app_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // make sure you don't initiate your router
  final _appRouter = AppRouter();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return AppRefreshConfig(
      child: MaterialApp.router(
        locale: TranslationProvider.of(context).flutterLocale, // use provider
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: [
          ...GlobalMaterialLocalizations.delegates,
          RefreshLocalizations.delegate,
        ],
        routerConfig: _appRouter.config(
          deepLinkBuilder: (deepLink) {
            logger.d('deepLinkBuilder: $deepLink');
            return DeepLink.path(deepLink.path);
            // if (deepLink.path.startsWith('/products')) {
            //   // continue with the platform link
            //   return deepLink;
            // } else {
            //   return DeepLink.defaultPath;
            //   // or DeepLink.path('/')
            //   // or DeepLink([HomeRoute()])
            // }
          },
        ),
        themeMode: ThemeMode.system,
        darkTheme: ThemeData.dark(),
      ),
    );
  }
}
