import 'article_model.dart';

class ArticlesModel {
  ArticlesModelData data;
  int errorCode;
  String errorMsg;

  ArticlesModel({this.data, this.errorCode, this.errorMsg});

  ArticlesModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new ArticlesModelData.fromJson(json['data'])
        : null;
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}

class ArticlesModelData {
  bool over;
  int pageCount;
  int total;
  int curPage;
  int offset;
  int size;
  List<ArticleEntity> datas;

  ArticlesModelData(
      {this.over,
      this.pageCount,
      this.total,
      this.curPage,
      this.offset,
      this.size,
      this.datas});

  ArticlesModelData.fromJson(Map<String, dynamic> json) {
    over = json['over'];
    pageCount = json['pageCount'];
    total = json['total'];
    curPage = json['curPage'];
    offset = json['offset'];
    size = json['size'];
    datas = (json['datas'] as List)
        ?.map((e) => e == null
            ? null
            : ArticleEntity.fromJson(e as Map<String, dynamic>))
        ?.toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['over'] = this.over;
    data['pageCount'] = this.pageCount;
    data['total'] = this.total;
    data['curPage'] = this.curPage;
    data['offset'] = this.offset;
    data['size'] = this.size;
    data['datas'] = this.datas;
    return data;
  }
}
