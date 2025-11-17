// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/material.dart' as _i17;
import 'package:flutter_butailing/pages/src/auth/auth_screen.dart' as _i1;
import 'package:flutter_butailing/pages/src/home/home_screen.dart' as _i2;
import 'package:flutter_butailing/pages/src/home/pages/latest_screen.dart'
    as _i5;
import 'package:flutter_butailing/pages/src/home/pages/monthest_screen.dart'
    as _i7;
import 'package:flutter_butailing/pages/src/home/pages/movie_screen.dart'
    as _i9;
import 'package:flutter_butailing/pages/src/home/pages/tv_screen.dart' as _i12;
import 'package:flutter_butailing/pages/src/home/pages/weekest_screen.dart'
    as _i15;
import 'package:flutter_butailing/pages/src/home/video_screen.dart' as _i14;
import 'package:flutter_butailing/pages/src/market/market_screen.dart' as _i6;
import 'package:flutter_butailing/pages/src/market/pages/latest/latest_detail_screen.dart'
    as _i3;
import 'package:flutter_butailing/pages/src/market/pages/latest_market_screen.dart'
    as _i4;
import 'package:flutter_butailing/pages/src/market/pages/movie_market_screen.dart'
    as _i8;
import 'package:flutter_butailing/pages/src/market/pages/tv_market_screen.dart'
    as _i11;
import 'package:flutter_butailing/pages/src/search/search_result_screen.dart'
    as _i10;
import 'package:flutter_butailing/pages/src/video_detail/video_detail_screen.dart'
    as _i13;

/// generated route for
/// [_i1.AuthScreen]
class AuthRoute extends _i16.PageRouteInfo<void> {
  const AuthRoute({List<_i16.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthScreen();
    },
  );
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i16.PageRouteInfo<void> {
  const HomeRoute({List<_i16.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.LatestDetailScreen]
class LatestDetailRoute extends _i16.PageRouteInfo<LatestDetailRouteArgs> {
  LatestDetailRoute({
    _i17.Key? key,
    required int sc,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         LatestDetailRoute.name,
         args: LatestDetailRouteArgs(key: key, sc: sc),
         rawPathParams: {'sc': sc},
         initialChildren: children,
       );

  static const String name = 'LatestDetailRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<LatestDetailRouteArgs>(
        orElse: () => LatestDetailRouteArgs(sc: pathParams.getInt('sc')),
      );
      return _i3.LatestDetailScreen(key: args.key, sc: args.sc);
    },
  );
}

class LatestDetailRouteArgs {
  const LatestDetailRouteArgs({this.key, required this.sc});

  final _i17.Key? key;

  final int sc;

  @override
  String toString() {
    return 'LatestDetailRouteArgs{key: $key, sc: $sc}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LatestDetailRouteArgs) return false;
    return key == other.key && sc == other.sc;
  }

  @override
  int get hashCode => key.hashCode ^ sc.hashCode;
}

/// generated route for
/// [_i4.LatestMarketScreen]
class LatestMarketRoute extends _i16.PageRouteInfo<void> {
  const LatestMarketRoute({List<_i16.PageRouteInfo>? children})
    : super(LatestMarketRoute.name, initialChildren: children);

  static const String name = 'LatestMarketRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i4.LatestMarketScreen();
    },
  );
}

/// generated route for
/// [_i5.LatestScreen]
class LatestRoute extends _i16.PageRouteInfo<LatestRouteArgs> {
  LatestRoute({
    _i17.Key? key,
    required int sc,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         LatestRoute.name,
         args: LatestRouteArgs(key: key, sc: sc),
         rawPathParams: {'sc': sc},
         initialChildren: children,
       );

  static const String name = 'LatestRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<LatestRouteArgs>(
        orElse: () => LatestRouteArgs(sc: pathParams.getInt('sc')),
      );
      return _i5.LatestScreen(key: args.key, sc: args.sc);
    },
  );
}

class LatestRouteArgs {
  const LatestRouteArgs({this.key, required this.sc});

  final _i17.Key? key;

  final int sc;

  @override
  String toString() {
    return 'LatestRouteArgs{key: $key, sc: $sc}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LatestRouteArgs) return false;
    return key == other.key && sc == other.sc;
  }

  @override
  int get hashCode => key.hashCode ^ sc.hashCode;
}

/// generated route for
/// [_i6.MarketScreen]
class MarketRoute extends _i16.PageRouteInfo<void> {
  const MarketRoute({List<_i16.PageRouteInfo>? children})
    : super(MarketRoute.name, initialChildren: children);

  static const String name = 'MarketRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i6.MarketScreen();
    },
  );
}

/// generated route for
/// [_i7.MonthestScreen]
class MonthestRoute extends _i16.PageRouteInfo<MonthestRouteArgs> {
  MonthestRoute({
    _i17.Key? key,
    required int sc,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         MonthestRoute.name,
         args: MonthestRouteArgs(key: key, sc: sc),
         rawPathParams: {'sc': sc},
         initialChildren: children,
       );

  static const String name = 'MonthestRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MonthestRouteArgs>(
        orElse: () => MonthestRouteArgs(sc: pathParams.getInt('sc')),
      );
      return _i7.MonthestScreen(key: args.key, sc: args.sc);
    },
  );
}

class MonthestRouteArgs {
  const MonthestRouteArgs({this.key, required this.sc});

  final _i17.Key? key;

  final int sc;

  @override
  String toString() {
    return 'MonthestRouteArgs{key: $key, sc: $sc}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MonthestRouteArgs) return false;
    return key == other.key && sc == other.sc;
  }

  @override
  int get hashCode => key.hashCode ^ sc.hashCode;
}

/// generated route for
/// [_i8.MovieMarketScreen]
class MovieMarketRoute extends _i16.PageRouteInfo<MovieMarketRouteArgs> {
  MovieMarketRoute({
    _i17.Key? key,
    int sa = 2,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         MovieMarketRoute.name,
         args: MovieMarketRouteArgs(key: key, sa: sa),
         rawQueryParams: {'sa': sa},
         initialChildren: children,
       );

  static const String name = 'MovieMarketRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<MovieMarketRouteArgs>(
        orElse: () => MovieMarketRouteArgs(sa: queryParams.getInt('sa', 2)),
      );
      return _i8.MovieMarketScreen(key: args.key, sa: args.sa);
    },
  );
}

class MovieMarketRouteArgs {
  const MovieMarketRouteArgs({this.key, this.sa = 2});

  final _i17.Key? key;

  final int sa;

  @override
  String toString() {
    return 'MovieMarketRouteArgs{key: $key, sa: $sa}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MovieMarketRouteArgs) return false;
    return key == other.key && sa == other.sa;
  }

  @override
  int get hashCode => key.hashCode ^ sa.hashCode;
}

/// generated route for
/// [_i9.MovieScreen]
class MovieRoute extends _i16.PageRouteInfo<MovieRouteArgs> {
  MovieRoute({
    _i17.Key? key,
    required int sc,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         MovieRoute.name,
         args: MovieRouteArgs(key: key, sc: sc),
         rawPathParams: {'sc': sc},
         initialChildren: children,
       );

  static const String name = 'MovieRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MovieRouteArgs>(
        orElse: () => MovieRouteArgs(sc: pathParams.getInt('sc')),
      );
      return _i9.MovieScreen(key: args.key, sc: args.sc);
    },
  );
}

class MovieRouteArgs {
  const MovieRouteArgs({this.key, required this.sc});

  final _i17.Key? key;

  final int sc;

  @override
  String toString() {
    return 'MovieRouteArgs{key: $key, sc: $sc}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MovieRouteArgs) return false;
    return key == other.key && sc == other.sc;
  }

  @override
  int get hashCode => key.hashCode ^ sc.hashCode;
}

/// generated route for
/// [_i10.SearchResultScreen]
class SearchResultRoute extends _i16.PageRouteInfo<SearchResultRouteArgs> {
  SearchResultRoute({
    _i17.Key? key,
    required String keyword,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         SearchResultRoute.name,
         args: SearchResultRouteArgs(key: key, keyword: keyword),
         initialChildren: children,
       );

  static const String name = 'SearchResultRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SearchResultRouteArgs>();
      return _i10.SearchResultScreen(key: args.key, keyword: args.keyword);
    },
  );
}

class SearchResultRouteArgs {
  const SearchResultRouteArgs({this.key, required this.keyword});

  final _i17.Key? key;

  final String keyword;

  @override
  String toString() {
    return 'SearchResultRouteArgs{key: $key, keyword: $keyword}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SearchResultRouteArgs) return false;
    return key == other.key && keyword == other.keyword;
  }

  @override
  int get hashCode => key.hashCode ^ keyword.hashCode;
}

/// generated route for
/// [_i11.TvMarketScreen]
class TvMarketRoute extends _i16.PageRouteInfo<TvMarketRouteArgs> {
  TvMarketRoute({_i17.Key? key, int sa = 2, List<_i16.PageRouteInfo>? children})
    : super(
        TvMarketRoute.name,
        args: TvMarketRouteArgs(key: key, sa: sa),
        rawQueryParams: {'sa': sa},
        initialChildren: children,
      );

  static const String name = 'TvMarketRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<TvMarketRouteArgs>(
        orElse: () => TvMarketRouteArgs(sa: queryParams.getInt('sa', 2)),
      );
      return _i11.TvMarketScreen(key: args.key, sa: args.sa);
    },
  );
}

class TvMarketRouteArgs {
  const TvMarketRouteArgs({this.key, this.sa = 2});

  final _i17.Key? key;

  final int sa;

  @override
  String toString() {
    return 'TvMarketRouteArgs{key: $key, sa: $sa}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TvMarketRouteArgs) return false;
    return key == other.key && sa == other.sa;
  }

  @override
  int get hashCode => key.hashCode ^ sa.hashCode;
}

/// generated route for
/// [_i12.TvScreen]
class TvRoute extends _i16.PageRouteInfo<TvRouteArgs> {
  TvRoute({_i17.Key? key, required int sc, List<_i16.PageRouteInfo>? children})
    : super(
        TvRoute.name,
        args: TvRouteArgs(key: key, sc: sc),
        rawPathParams: {'sc': sc},
        initialChildren: children,
      );

  static const String name = 'TvRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TvRouteArgs>(
        orElse: () => TvRouteArgs(sc: pathParams.getInt('sc')),
      );
      return _i12.TvScreen(key: args.key, sc: args.sc);
    },
  );
}

class TvRouteArgs {
  const TvRouteArgs({this.key, required this.sc});

  final _i17.Key? key;

  final int sc;

  @override
  String toString() {
    return 'TvRouteArgs{key: $key, sc: $sc}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TvRouteArgs) return false;
    return key == other.key && sc == other.sc;
  }

  @override
  int get hashCode => key.hashCode ^ sc.hashCode;
}

/// generated route for
/// [_i13.VideoDetailScreen]
class VideoDetailRoute extends _i16.PageRouteInfo<VideoDetailRouteArgs> {
  VideoDetailRoute({
    _i17.Key? key,
    required String idcode,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         VideoDetailRoute.name,
         args: VideoDetailRouteArgs(key: key, idcode: idcode),
         initialChildren: children,
       );

  static const String name = 'VideoDetailRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VideoDetailRouteArgs>();
      return _i13.VideoDetailScreen(key: args.key, idcode: args.idcode);
    },
  );
}

class VideoDetailRouteArgs {
  const VideoDetailRouteArgs({this.key, required this.idcode});

  final _i17.Key? key;

  final String idcode;

  @override
  String toString() {
    return 'VideoDetailRouteArgs{key: $key, idcode: $idcode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VideoDetailRouteArgs) return false;
    return key == other.key && idcode == other.idcode;
  }

  @override
  int get hashCode => key.hashCode ^ idcode.hashCode;
}

/// generated route for
/// [_i14.VideoScreen]
class VideoRoute extends _i16.PageRouteInfo<VideoRouteArgs> {
  VideoRoute({
    _i17.Key? key,
    required int sc,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         VideoRoute.name,
         args: VideoRouteArgs(key: key, sc: sc),
         initialChildren: children,
       );

  static const String name = 'VideoRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VideoRouteArgs>();
      return _i14.VideoScreen(key: args.key, sc: args.sc);
    },
  );
}

class VideoRouteArgs {
  const VideoRouteArgs({this.key, required this.sc});

  final _i17.Key? key;

  final int sc;

  @override
  String toString() {
    return 'VideoRouteArgs{key: $key, sc: $sc}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VideoRouteArgs) return false;
    return key == other.key && sc == other.sc;
  }

  @override
  int get hashCode => key.hashCode ^ sc.hashCode;
}

/// generated route for
/// [_i15.WeekestScreen]
class WeekestRoute extends _i16.PageRouteInfo<WeekestRouteArgs> {
  WeekestRoute({
    _i17.Key? key,
    required int sc,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         WeekestRoute.name,
         args: WeekestRouteArgs(key: key, sc: sc),
         rawPathParams: {'sc': sc},
         initialChildren: children,
       );

  static const String name = 'WeekestRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<WeekestRouteArgs>(
        orElse: () => WeekestRouteArgs(sc: pathParams.getInt('sc')),
      );
      return _i15.WeekestScreen(key: args.key, sc: args.sc);
    },
  );
}

class WeekestRouteArgs {
  const WeekestRouteArgs({this.key, required this.sc});

  final _i17.Key? key;

  final int sc;

  @override
  String toString() {
    return 'WeekestRouteArgs{key: $key, sc: $sc}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WeekestRouteArgs) return false;
    return key == other.key && sc == other.sc;
  }

  @override
  int get hashCode => key.hashCode ^ sc.hashCode;
}
