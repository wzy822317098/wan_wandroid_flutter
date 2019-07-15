import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wan_wandroid/utils/colors_utils.dart';

///@description 刷新工具类，统一管理header，footer
///
///@created by wangzhouyao on 2019-07-11

class RefreshUtils {

  //获取公告header
  static RefreshHeader getHeader(GlobalKey<RefreshHeaderState> key) {
    return ClassicsHeader(
      key: key,
      refreshText: "下拉刷新",
      bgColor: ColorsUtils.color_bg,
      textColor: ColorsUtils.color_title,
      refreshReadyText: "释放刷新",
      refreshingText: "正在刷新",
      refreshedText: "刷新成功",
      moreInfo: "上次刷新 %T",
      moreInfoColor: ColorsUtils.color_title,
      showMore: true,
    );
  }

  //获取公告footer
  static RefreshFooter getFooter(GlobalKey<RefreshFooterState> key) {
    return ClassicsFooter(
      key: key,
      bgColor: ColorsUtils.color_bg,
      textColor: ColorsUtils.color_title,
      loadText: "上拉加载更多",
      loadReadyText: "释放加载更多",
      loadingText: "正在加载",
      loadedText: "加载成功",
      moreInfo: "上次加载 %T",
      noMoreText: "已加载全部数据",
      moreInfoColor: ColorsUtils.color_title,
      showMore: true,
    );
  }

  //获取公告的空白页面
  static Widget getEmptyWidget(){
    return Container(
      child: Text("暂无数据"),
    );
  }
}
