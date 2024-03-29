import 'package:flutter/material.dart';
import 'package:wan_wandroid/network/network_utils.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wan_wandroid/widgets/item_article.dart';
import 'package:wan_wandroid/model/article_model.dart';
import 'package:wan_wandroid/utils/refresh_utils.dart';
import 'package:wan_wandroid/utils/colors_utils.dart';

///@description 搜索结果页面
///
///@created by wangzhouyao on 2019-07-11
class SearchResultPage extends StatefulWidget {
  final String _searchKey;
  SearchResultPage(this._searchKey);
  @override
  State<StatefulWidget> createState() => SearchResultState();
}

class SearchResultState extends State<SearchResultPage> {
  final List<ArticleEntity> _rsList = List();
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
    return Scaffold(
      backgroundColor: ColorsUtils.color_bg,
        appBar: AppBar(
          leading: BackButton(
            color: ColorsUtils.color_title,
          ),
          title: Text(
            widget._searchKey,
            style: TextStyle(fontSize: 16, color: ColorsUtils.color_title),
          ),
        ),
        body: Center(
          child: EasyRefresh(
            key: _easyRefreshKey,
            autoControl: false,
            refreshHeader: RefreshUtils.getHeader(_headerKey),
            refreshFooter: RefreshUtils.getFooter(_footerKey),
            firstRefresh: true,
            child: ListView(
              semanticChildCount: _rsList.length,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: _rsList != null
                      ? ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext contenxt, int index) {
                            return ItemArticle(articleEntity: _rsList[index]);
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(height: 0,),
                          itemCount: _rsList.length)
                      : Container(),
                ),
              ],
            ),
            onRefresh: () async {
              _currentPage = 0;
              _rsList.clear();
              _doSearch(_currentPage);
            },
            loadMore: () async {
              // ignore: unnecessary_statements
              _currentPage += 1;
              if (_loadMore) {
                _doSearch(_currentPage);
              } else {
                setState(() {
                  _easyRefreshKey.currentState.callLoadMoreFinish();
                });
              }
            },
            autoLoad: false,
          ),
        ));
  }

  void _doSearch(int page) {
    NetworkUtils.instance.search(page, widget._searchKey).then((it) {
      _rsList.addAll(it.datas);
      setState(() {
        if (page == 0) {
          _easyRefreshKey.currentState.callRefreshFinish();
        } else {
          _easyRefreshKey.currentState.callLoadMoreFinish();
        }
        _easyRefreshKey.currentState.waitState(() {
          if (it.pageCount <= _currentPage + 1) {
            _loadMore = false;
          } else {
            _loadMore = true;
          }
        });
      });
    });
  }
}
