import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'movie_filter.g.dart';

class MovieFilerInfo {
  String sd = ""; //制片区域
  String sc = ""; //影视类型
  String se = ""; // 上映年份
  String sf = ''; //画质
}

@Riverpod(keepAlive: false)
class MovieFilter extends _$MovieFilter {
  @override
  MovieFilerInfo build() {
    state = MovieFilerInfo();
    return state;
  }

  String get sd => state.sd;
  String get sc => state.sc;
  String get se => state.se;
  String get sf => state.sf;

  /// 改变制片区域
  void changeSd(String sd) {
    state.sd = sd;
    state = MovieFilerInfo()
      ..sc = state.sc
      ..sf = state.sf
      ..se = state.se
      ..sd = sd;
  }

  /// 改变影视类型
  void changeSc(String sc) {
    state.sc = sc;
    state = MovieFilerInfo()
      ..sc = sc
      ..sf = state.sf
      ..se = state.se
      ..sd = state.sd;
  }

  /// 改变上映年份
  void changeSe(String se) {
    state.se = se;
    state = MovieFilerInfo()
      ..sc = state.sc
      ..sf = state.sf
      ..sd = state.sd
      ..se = se;
  }

  /// 改变画质
  void changeSf(String sf) {
    state.sf = sf;
    state = MovieFilerInfo()
      ..sc = state.sc
      ..se = state.se
      ..sd = state.sd
      ..sf = sf;
  }
}
