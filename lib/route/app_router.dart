import 'package:auto_route/auto_route.dart';
import 'package:flutter_butailing/config/oauth.dart';
import 'package:flutter_butailing/route/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
    // HomeScreen is generated as HomeRoute because
    // of the replaceInRouteName property
    AutoRoute(page: AuthRoute.page, initial: true),
    AutoRoute(
      // path: "/home",
      page: HomeRoute.page,
      initial: false,
      children: [
        RedirectRoute(path: '', redirectTo: 'movie'),
        AutoRoute(page: MovieRoute.page, path: "movie/:sc"),
        AutoRoute(page: TvRoute.page, path: "tv/:sc"),
        AutoRoute(page: LatestRoute.page, path: "latest/:sc"),
        AutoRoute(page: WeekestRoute.page, path: "weekest/:sc"),
        AutoRoute(page: MonthestRoute.page, path: "monthes/:sc"),
      ],
    ),
  ];

  @override
  List<AutoRouteGuard> get guards => [OAuthGuard()];
}

class OAuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    if (router.stack.isEmpty || router.isRoot) {
      resolver.next(true);
    } else {
      resolver.next(await Oauth.oauthed);
    }
  }
}
