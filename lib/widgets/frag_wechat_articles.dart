import 'package:flutter/material.dart';
import 'package:wan_wandroid/model/system_model.dart';
import 'package:wan_wandroid/model/article_model.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wan_wandroid/network/network_utils.dart';
import 'package:wan_wandroid/utils/refresh_utils.dart';
import 'item_article.dart';
///@description
///
///@created by wangzhouyao on 2019-07-16
class FragWechatArticles extends StatefulWidget{
  final SystemModelEntity _entity;

  const FragWechatArticles(this._entity);

  @override
  State<StatefulWidget> createState() =>FragWechatArticlesState();
}

class FragWechatArticlesState extends State<FragWechatArticles> with AutomaticKeepAliveClientMixin{
  final List<ArticleEntity> _articleList = List();
  int _currentPage = 0;
  GlobalKey<EasyRefreshState> _easyRefreshKey =
  new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
  new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
  new GlobalKey<RefreshFooterState>();
  bool _loadMore = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: EasyRefresh(
        key: _easyRefreshKey,
        autoControl: false,
//            emptyWidget: RefreshUtils.getEmptyWidget(),
        refreshHeader: RefreshUtils.getHeader(_headerKey),
        refreshFooter: RefreshUtils.getFooter(_footerKey),
        firstRefresh: true,
        child: ListView(
          semanticChildCount: _articleList.length,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 8),
              child: _articleList != null
                  ? ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext contenxt, int index) {
                    return ItemArticle(articleEntity: _articleList[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(height: 0,),
                  itemCount: _articleList.length)
                  : Container(),
            ),
          ],
        ),
        onRefresh: () async {
          _currentPage = 0;
          _articleList.clear();
          _doLoadArticles(_currentPage);
        },
        loadMore: () async {
          // ignore: unnecessary_statements
          _currentPage += 1;
          if (_loadMore) {
            _doLoadArticles(_currentPage);
          } else {
            setState(() {
              _easyRefreshKey.currentState.callLoadMoreFinish();
            });
          }
        },
        autoLoad: false,
      ),
    );
  }
  void _doLoadArticles(int page) {
    NetworkUtils.instance
        .getArticlesByCid(page, widget._entity.id)
        .then((data) {
      _articleList.addAll(data.datas);
      setState(() {
        if (page == 0) {
          _easyRefreshKey.currentState.callRefreshFinish();
        } else {
          _easyRefreshKey.currentState.callLoadMoreFinish();
        }
        _easyRefreshKey.currentState.waitState(() {
          if (data.pageCount <= _currentPage + 1) {
            _loadMore = false;
          } else {
            _loadMore = true;
          }
        });
      });
    });
  }

  @override
  bool get wantKeepAlive => true;
}