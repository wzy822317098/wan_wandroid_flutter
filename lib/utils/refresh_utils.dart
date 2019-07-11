import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wan_wandroid/utils/colors_utils.dart';

///@description
///
///@created by wangzhouyao on 2019-07-11

class RefreshUtils {
  static RefreshHeader getHeader() {
    GlobalKey<RefreshHeaderState> _headerKey =
        new GlobalKey<RefreshHeaderState>();
    return ClassicsHeader(
      key: _headerKey,
      refreshText: "下拉刷新",
      bgColor: Colors.white,
      textColor: ColorsUtils.color_title,
      refreshReadyText: "释放刷新",
      refreshingText: "正在刷新",
      refreshedText: "刷新成功",
      moreInfo: "上次刷新 %T",
      moreInfoColor: ColorsUtils.color_title,
      showMore: true,
    );
  }

  static RefreshFooter getFooter() {
    GlobalKey<RefreshFooterState> _footerKey =
        new GlobalKey<RefreshFooterState>();
    return ClassicsFooter(
      key: _footerKey,
      bgColor: Colors.white,
      textColor: ColorsUtils.color_title,
      loadText: "上拉加载更多",
      loadReadyText: "释放加载更多",
      loadingText: "正在加载",
      loadedText: "加载成功",
      moreInfo: "上次加载 %T",
      showMore: true,
    );
  }
}
