import 'package:flutter/material.dart';
import 'package:flutter_butailing/i18n/strings.g.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

// ignore: non_constant_identifier_names
Widget AppRefreshConfig({required Widget child}) {
  return RefreshConfiguration(
    headerBuilder: () => ClassicHeader(
      idleText: t.refresh.pull_down.pull_to_refresh,
      refreshingText: t.refresh.pull_down.refreshing,
      completeText: t.refresh.pull_down.refresh_completed,
      releaseText: t.refresh.pull_down.release_to_refresh,
      failedText: t.refresh.pull_down.refresh_failed,
    ), // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
    footerBuilder: () => ClassicFooter(
      idleText: t.refresh.pull_up.pull_to_refresh,
      loadingText: t.refresh.pull_up.refreshing,
      canLoadingText: t.refresh.pull_up.release_to_refresh,
      failedText: t.refresh.pull_up.refresh_failed,
      noDataText: t.refresh.pull_up.no_more_data, //没有内容的文字
      // noMoreIcon: "没有内容的图标"
    ), // 配置默认底部指示器

    child: child,
  );
}
