// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:flutter_butailing/pages/src/auth/auth_screen.dart' as _i1;
import 'package:flutter_butailing/pages/src/home/home_screen.dart' as _i2;
import 'package:flutter_butailing/pages/src/home/pages/latest_screen.dart'
    as _i3;
import 'package:flutter_butailing/pages/src/home/pages/monthest_screen.dart'
    as _i4;
import 'package:flutter_butailing/pages/src/home/pages/movie_screen.dart'
    as _i5;
import 'package:flutter_butailing/pages/src/home/pages/tv_screen.dart' as _i6;
import 'package:flutter_butailing/pages/src/home/pages/weekest_screen.dart'
    as _i8;
import 'package:flutter_butailing/pages/src/home/video_screen.dart' as _i7;

/// generated route for
/// [_i1.AuthScreen]
class AuthRoute extends _i9.PageRouteInfo<void> {
  const AuthRoute({List<_i9.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthScreen();
    },
  );
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.LatestScreen]
class LatestRoute extends _i9.PageRouteInfo<LatestRouteArgs> {
  LatestRoute({
    _i10.Key? key,
    required int sc,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         LatestRoute.name,
         args: LatestRouteArgs(key: key, sc: sc),
         rawPathParams: {'sc': sc},
         initialChildren: children,
       );

  static const String name = 'LatestRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<LatestRouteArgs>(
        orElse: () => LatestRouteArgs(sc: pathParams.getInt('sc')),
      );
      return _i3.LatestScreen(key: args.key, sc: args.sc);
    },
  );
}

class LatestRouteArgs {
  const LatestRouteArgs({this.key, required this.sc});

  final _i10.Key? key;

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
/// [_i4.MonthestScreen]
class MonthestRoute extends _i9.PageRouteInfo<MonthestRouteArgs> {
  MonthestRoute({
    _i10.Key? key,
    required int sc,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         MonthestRoute.name,
         args: MonthestRouteArgs(key: key, sc: sc),
         rawPathParams: {'sc': sc},
         initialChildren: children,
       );

  static const String name = 'MonthestRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MonthestRouteArgs>(
        orElse: () => MonthestRouteArgs(sc: pathParams.getInt('sc')),
      );
      return _i4.MonthestScreen(key: args.key, sc: args.sc);
    },
  );
}

class MonthestRouteArgs {
  const MonthestRouteArgs({this.key, required this.sc});

  final _i10.Key? key;

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
/// [_i5.MovieScreen]
class MovieRoute extends _i9.PageRouteInfo<MovieRouteArgs> {
  MovieRoute({
    _i10.Key? key,
    required int sc,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         MovieRoute.name,
         args: MovieRouteArgs(key: key, sc: sc),
         rawPathParams: {'sc': sc},
         initialChildren: children,
       );

  static const String name = 'MovieRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MovieRouteArgs>(
        orElse: () => MovieRouteArgs(sc: pathParams.getInt('sc')),
      );
      return _i5.MovieScreen(key: args.key, sc: args.sc);
    },
  );
}

class MovieRouteArgs {
  const MovieRouteArgs({this.key, required this.sc});

  final _i10.Key? key;

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
/// [_i6.TvScreen]
class TvRoute extends _i9.PageRouteInfo<TvRouteArgs> {
  TvRoute({_i10.Key? key, required int sc, List<_i9.PageRouteInfo>? children})
    : super(
        TvRoute.name,
        args: TvRouteArgs(key: key, sc: sc),
        rawPathParams: {'sc': sc},
        initialChildren: children,
      );

  static const String name = 'TvRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TvRouteArgs>(
        orElse: () => TvRouteArgs(sc: pathParams.getInt('sc')),
      );
      return _i6.TvScreen(key: args.key, sc: args.sc);
    },
  );
}

class TvRouteArgs {
  const TvRouteArgs({this.key, required this.sc});

  final _i10.Key? key;

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
/// [_i7.VideoScreen]
class VideoRoute extends _i9.PageRouteInfo<VideoRouteArgs> {
  VideoRoute({
    _i10.Key? key,
    required int sc,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         VideoRoute.name,
         args: VideoRouteArgs(key: key, sc: sc),
         initialChildren: children,
       );

  static const String name = 'VideoRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VideoRouteArgs>();
      return _i7.VideoScreen(key: args.key, sc: args.sc);
    },
  );
}

class VideoRouteArgs {
  const VideoRouteArgs({this.key, required this.sc});

  final _i10.Key? key;

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
/// [_i8.WeekestScreen]
class WeekestRoute extends _i9.PageRouteInfo<WeekestRouteArgs> {
  WeekestRoute({
    _i10.Key? key,
    required int sc,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         WeekestRoute.name,
         args: WeekestRouteArgs(key: key, sc: sc),
         rawPathParams: {'sc': sc},
         initialChildren: children,
       );

  static const String name = 'WeekestRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<WeekestRouteArgs>(
        orElse: () => WeekestRouteArgs(sc: pathParams.getInt('sc')),
      );
      return _i8.WeekestScreen(key: args.key, sc: args.sc);
    },
  );
}

class WeekestRouteArgs {
  const WeekestRouteArgs({this.key, required this.sc});

  final _i10.Key? key;

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
