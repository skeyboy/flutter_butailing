// assuming this is the root widget of your App
import 'package:flutter/material.dart';
import 'package:flutter_butailing/route/app_router.dart';

class App extends StatelessWidget {
  // make sure you don't initiate your router
  // inside of the build function.
  final _appRouter = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
    );
  }
}
