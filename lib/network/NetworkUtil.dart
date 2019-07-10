import 'package:dio/dio.dart';
import 'Api.dart';
import 'package:wan_wandroid/model/article_model.dart';
import 'package:wan_wandroid/model/articles_model.dart';
import 'package:wan_wandroid/model/banner_entity.dart';
import 'package:wan_wandroid/model/hot_key_model.dart';

class NetworkUtils {
  static const baseUrl = "https://www.wanandroid.com";

  factory NetworkUtils() => _getInstance();

  static NetworkUtils get instance=>_getInstance();

  static NetworkUtils _instance;

  static NetworkUtils _getInstance() {
    if (_instance == null) {
      _instance = new NetworkUtils._internal();
    }
    return _instance;
  }

  Dio dio;

  NetworkUtils._internal() {
    dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = 90000;
    dio.options.receiveTimeout = 90000;
    dio.options.responseType =ResponseType.json;
  }

  //获取轮播信息
  Future<List<BannerEntity>> getBanner() async {
    return await dio.get(Api.banner).then((response){
      return HttpBannerEntity.fromJson(response.data).data;
    });
  }

  //获取置顶文章
  Future<List<ArticleEntity>> getTopArtics() async{
    return await dio.get(Api.topArticle).then((response){
      return ArticleModel.fromJson(response.data).data;
    });
  }

  //分页获取文章列表
  Future<ArticlesModelData> getArticles(int pageNum) async{
    return await dio.get(Api.pageArticles+"$pageNum/json").then((response){
      return ArticlesModel.fromJson(response.data).data;
    });
  }

  //获取热搜词汇
  Future<List<HotKeyEntity>> getHotKey() async{
    return await dio.get(Api.hotkey).then((response){
      return HotKeyModel.fromJson(response.data).data;
    });
  }
}
