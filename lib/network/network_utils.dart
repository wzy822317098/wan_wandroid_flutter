import 'package:dio/dio.dart';
import 'api.dart';
import 'package:wan_wandroid/model/article_model.dart';
import 'package:wan_wandroid/model/articles_model.dart';
import 'package:wan_wandroid/model/banner_entity.dart';
import 'package:wan_wandroid/model/hot_key_model.dart';
import 'package:wan_wandroid/model/system_model.dart';
import 'package:wan_wandroid/model/project_category_model.dart';
///@description 网络请求工具
///
///@created by wangzhouyao on 2019-07-10
class NetworkUtils {
  static const _baseUrl = "https://www.wanandroid.com";

  factory NetworkUtils() => _getInstance();

  static NetworkUtils get instance => _getInstance();

  static NetworkUtils _instance;

  static NetworkUtils _getInstance() {
    if (_instance == null) {
      _instance = new NetworkUtils._internal();
    }
    return _instance;
  }

  Dio _dio;

  NetworkUtils._internal() {
    _dio = Dio();
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = 90000;
    _dio.options.receiveTimeout = 90000;
    _dio.options.responseType = ResponseType.json;
    _dio.interceptors.add(LogInterceptor(responseBody: true,requestBody: true));
  }

  //获取轮播信息
  Future<List<BannerEntity>> getBanner() async {
    return await _dio.get(Api.banner).then((response) {
      return HttpBannerEntity.fromJson(response.data).data;
    });
  }

  //获取置顶文章
  Future<List<ArticleEntity>> getTopArtics() async {
    return await _dio.get(Api.topArticle).then((response) {
      return ArticleModel.fromJson(response.data).data;
    });
  }

  //分页获取文章列表
  Future<ArticlesModelData> getArticles(int pageNum) async {
    return await _dio.get(Api.pageArticles + "$pageNum/json").then((response) {
      return ArticlesModel.fromJson(response.data).data;
    });
  }

  //获取热搜词汇
  Future<List<HotKeyEntity>> getHotKey() async {
    return await _dio.get(Api.hotkey).then((response) {
      return HotKeyModel.fromJson(response.data).data;
    });
  }

  //搜索
  Future<ArticlesModelData> search(int pageNum, String key) async {
    FormData params =FormData.from({
      "k": key
    });
    return await _dio
        .post(Api.search + "$pageNum/json", data: params).then((response) {
      return ArticlesModel.fromJson(response.data).data;
    });
  }

  //获取体系
  Future<SystemModel> getSystem() async{
    return await _dio.get(Api.tree).then((response){
      return SystemModel.fromJson(response.data);
    });
  }


  //分页获取文章列表
  Future<ArticlesModelData> getArticlesByCid(int pageNum,int cid) async {
    Map<String,dynamic> _params =new Map();
    _params["cid"] =cid;
    return await _dio.get(Api.pageArticles + "$pageNum/json",queryParameters: _params).then((response) {
      return ArticlesModel.fromJson(response.data).data;
    });
  }

  //获取公众号列表
  Future<SystemModel> getWechatPubAcct() async{
    return await _dio.get(Api.wechatPubAcct).then((response){
      return SystemModel.fromJson(response.data);
    });
  }
  
  Future<ArticlesModelData> getWxArticles(int pageMun,int cid) async{
    return await _dio.get(Api.wxArticles+"$cid/$pageMun/json").then((response){
      return ArticlesModel.fromJson(response.data).data;
    });
  }

  //获取项目分类
  Future<ProjectCategoryModel> getProjectCategory() async{
    return await _dio.get(Api.projectCategory).then((response){
      return ProjectCategoryModel.fromJson(response.data);
    });
  }
  
  Future<ArticlesModelData> getProjectArticles(int pageNum,int cid) async{
    Map<String,dynamic> _params =new Map();
    _params["cid"] =cid;
    return await _dio.get(Api.projectArticles+"$pageNum/json",queryParameters: _params).then((response){
      return ArticlesModel.fromJson(response.data).data;
    });
  }
}
