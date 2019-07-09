import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wan_wandroid/network/NetworkUtil.dart';
import 'package:wan_wandroid/model/banner_entity.dart';
import 'package:wan_wandroid/model/article_model.dart';
import 'package:wan_wandroid/widgets/item_article.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wan_wandroid/page/WebPage.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  List<BannerEntity> _bannerList;
  List<ArticleEntity> _topArticle;
  List<ArticleEntity> _articles = List();
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  bool _loadMore = false;
  int _currentPage = 0;
  int _totalCount =0;

  void _initData(){
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
        appBar: AppBar(
          title: Text('首页'),
          actions: <Widget>[
            new IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: null)
          ],
        ),
        body: Center(
          child: EasyRefresh(
            key: _easyRefreshKey,
            autoControl: false,
            refreshHeader: ClassicsHeader(
              key: _headerKey,
              refreshText: "下拉刷新",
              refreshReadyText: "释放刷新",
              refreshingText: "正在刷新",
              refreshedText: "刷新成功",
              moreInfo: "上次刷新 %T",
              showMore: true,
            ),
            refreshFooter: ClassicsFooter(
              key: _footerKey,
              loadText: "上拉加载更多",
              loadReadyText: "释放加载更多",
              loadingText: "正在加载",
              loadedText: "加载成功",
              moreInfo: "上次加载 %T",
              showMore: true,
            ),
            firstRefresh: true,
            child: ListView(
              semanticChildCount: _articles.length,
              children: <Widget>[
                _swiperView(),
                _topArticle != null
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
                            Divider(),
                        itemCount: _topArticle.length)
                    : Container(),
                Container(
                  margin:EdgeInsets.only(top: 8) ,
                  child: _articles != null
                      ? ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext contenxt, int index) {
                        return ItemArticle(
                            articleEntity: _articles[index]
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemCount: _articles.length)
                      : Container(),
                ),

              ],
            ),
            onRefresh: () async {
              _currentPage =0;
              _articles.clear();
              _initData();
            },
            loadMore: () async{
              // ignore: unnecessary_statements
              _currentPage +=1;
              _loadMore?_loadArticles(_currentPage):null;
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
              pagination: new SwiperPagination(),
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
          if (it.pageCount <= _currentPage) {
            _loadMore = false;
          } else {
            _loadMore = true;
          }
        });
      });
    });
  }

  void _onSwiperTapped(int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return WebPage(_bannerList[index].title,_bannerList[index].url);
    }));
  }
}
