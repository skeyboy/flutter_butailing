import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'movie_filter.g.dart';

class MovieFilerInfo {
  String sd = ""; //制片区域
  String sc = ""; //影视类型
  String se = ""; // 上映年份
  String sf = ''; //画质
  String sg = ''; //影视标签
  String status = ''; // 剧集状态

  Future<void> persist({required String identifier}) async {
    (await pref).setStringList('movie_filter_$identifier', [
      sd,
      sc,
      se,
      sf,
      sg,
      status,
    ]);
  }

  Future<SharedPreferences> get pref async =>
      await SharedPreferences.getInstance();
  Future<void> restore({required String identifier}) async {
    final list = (await pref).getStringList('movie_filter_$identifier');
    if (list != null && list.length == 6) {
      sd = list[0];
      sc = list[1];
      se = list[2];
      sf = list[3];
      sg = list[4];
      status = list[5];
    }
  }
}

@Riverpod(keepAlive: true)
class MovieFilter extends _$MovieFilter {
  @override
  Future<MovieFilerInfo> build({required String identifier}) async {
    final value = MovieFilerInfo();
    await value.restore(identifier: identifier);
    state = AsyncData(value);
    return Future.value(value);
  }

  String get sd => state.value!.sd;
  String get sc => state.value!.sc;
  String get se => state.value!.se;
  String get sf => state.value!.sf;
  String get sg => state.value!.sg;
  String get status => state.value!.status;

  /// 改变制片区域
  Future<void> changeSd(String sd) async {
    state.value?.sd = sd;
    final value = MovieFilerInfo()
      ..sc = state.value!.sc
      ..sf = state.value!.sf
      ..se = state.value!.se
      ..sd = sd
      ..sg = state.value!.sg
      ..status = state.value!.status;
    await value.persist(identifier: identifier);
    state = AsyncData(value);
  }

  /// 改变影视类型
  Future<void> changeSc(String sc) async {
    state.value?.sc = sc;
    final value = MovieFilerInfo()
      ..sc = state.value!.sc
      ..sf = state.value!.sf
      ..se = state.value!.se
      ..sd = state.value!.sd
      ..sg = state.value!.sg
      ..status = state.value!.status;
    await value.persist(identifier: identifier);
    state = AsyncData(value);
  }

  /// 改变上映年份
  Future<void> changeSe(String se) async {
    state.value?.se = se;
    final value = MovieFilerInfo()
      ..sc = state.value!.sc
      ..sf = state.value!.sf
      ..sd = state.value!.sd
      ..se = se
      ..sg = state.value!.sg
      ..status = state.value!.status;
    await value.persist(identifier: identifier);
    state = AsyncData(value);
  }

  /// 改变画质
  Future<void> changeSf(String sf) async {
    state.value?.sf = sf;
    final value = MovieFilerInfo()
      ..sc = state.value!.sc
      ..se = state.value!.se
      ..sd = state.value!.sd
      ..sf = sf
      ..sg = state.value!.sg
      ..status = state.value!.status;
    await value.persist(identifier: identifier);
    state = AsyncData(value);
  }

  Future<void> changeSg(String sg) async {
    state.value?.sg = sg;
    final value = MovieFilerInfo()
      ..sc = state.value!.sc
      ..se = state.value!.se
      ..sd = state.value!.sd
      ..sf = state.value!.sf
      ..sg = sg
      ..status = state.value!.status;
    await value.persist(identifier: identifier);
    state = AsyncData(value);
  }

  Future<void> changeStatus(String status) async {
    state.value?.status = status;
    final value = MovieFilerInfo()
      ..sc = state.value!.sc
      ..se = state.value!.se
      ..sd = state.value!.sd
      ..sf = state.value!.sf
      ..sg = state.value!.sg
      ..status = status;
    await value.persist(identifier: identifier);
    state = AsyncData(value);
  }
}
