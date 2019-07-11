import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wan_wandroid/network/NetworkUtil.dart';
import 'package:wan_wandroid/model/banner_entity.dart';
import 'package:wan_wandroid/model/article_model.dart';
import 'package:wan_wandroid/widgets/item_article.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wan_wandroid/page/web_page.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:wan_wandroid/page/search_page.dart';
import 'package:wan_wandroid/utils/refresh_utils.dart';
import 'package:wan_wandroid/utils/colors_utils.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<BannerEntity> _bannerList;
  List<ArticleEntity> _topArticle;
  List<ArticleEntity> _articles = List();
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  bool _loadMore = false;
  int _currentPage = 0;

  void _initData() {
    NetworkUtils.instance.getBanner().then((it) {
      _bannerList = it;
      return NetworkUtils.instance.getTopArtics().then((it) {
        _topArticle = it;
        return _loadArticles(_currentPage);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: ColorsUtils.color_bg,
        appBar: AppBar(
          title: Text(
            '首页',
            style: TextStyle(fontSize: 16, color: ColorsUtils.color_title),
          ),
          actions: <Widget>[
            new IconButton(
                icon: Icon(
                  Icons.search,
                  color: ColorsUtils.color_title,
                ),
                onPressed: _toSearch)
          ],
        ),
        body: Center(
          child: EasyRefresh(
            key: _easyRefreshKey,
            autoControl: false,
            refreshHeader: RefreshUtils.getHeader(),
            refreshFooter: RefreshUtils.getFooter(),
            firstRefresh: true,
            child: ListView(
              semanticChildCount: _articles.length,
              children: <Widget>[
                _swiperView(),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: _topArticle != null
                      ? ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext contenxt, int index) {
                        return ItemArticle(
                          articleEntity: _topArticle[index],
                          articleTag: "置顶",
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                            height: 8,
                          ),
                      itemCount: _topArticle.length)
                      : Container(),
                )
                ,
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: _articles != null
                      ? ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext contenxt, int index) {
                            return ItemArticle(articleEntity: _articles[index]);
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                                color: ColorsUtils.color_bg,
                                height: 8,
                              ),
                          itemCount: _articles.length)
                      : Container(),
                )
              ],
            ),
            onRefresh: () async {
              _currentPage = 0;
              _articles.clear();
              _initData();
            },
            loadMore: () async {
              // ignore: unnecessary_statements
              _currentPage += 1;
              if (_loadMore) {
                _loadArticles(_currentPage);
              } else {
                _easyRefreshKey.currentState.callLoadMoreFinish();
              }
            },
            autoLoad: false,
          ),
        ));
  }

  Widget _swiperView() {
    return _bannerList != null
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: 240,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new Image.network(
                  _bannerList[index].imagePath,
                  fit: BoxFit.cover,
                );
              },
              itemCount: _bannerList.length,
              pagination: new SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                      color: ColorsUtils.color_bg,
                      activeColor: ColorsUtils.color_content)),
              indicatorLayout: PageIndicatorLayout.SCALE,
              onTap: _onSwiperTapped,
            ),
          )
        : Container();
  }

  void _loadArticles(int page) {
    NetworkUtils.instance.getArticles(page).then((it) {
//      _totalCount =it.total;
      _articles.addAll(it.datas);
      setState(() {
        _easyRefreshKey.currentState.callLoadMoreFinish();
        _easyRefreshKey.currentState.callRefreshFinish();
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

  void _onSwiperTapped(int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return WebPage(
          title: _bannerList[index].title, url: _bannerList[index].url);
    }));
  }

  void _toSearch() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SearchPage();
    }));
  }
}
