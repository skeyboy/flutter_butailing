// assuming this is the root widget of your App
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_butailing/config/app_refresh_config.dart';
import 'package:flutter_butailing/config/config.dart';
import 'package:flutter_butailing/i18n/strings.g.dart';
import 'package:flutter_butailing/route/app_router.dart';
import 'package:flutter_butailing/bridge_client/bridge_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'providers/index.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  ThemeData themeData = ThemeData.dark();
  // make sure you don't initiate your router
  late final AppRouter _appRouter = AppRouter();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await BridgeManager.manager.startBridgeServe();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeConfigProviderRef = ref.watch(themeConfigProvider);
    return AppRefreshConfig(
      child: MaterialApp.router(
        builder: EasyLoading.init(),
        themeMode: themeConfigProviderRef.value,
        darkTheme: ThemeData.dark(),
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
      ),
    );
  }
}
