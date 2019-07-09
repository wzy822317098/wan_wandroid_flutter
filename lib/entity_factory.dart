import 'package:wan_wandroid/model/articles_model.dart';
import 'package:wan_wandroid/model/banner_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "ArticlesModelEntity") {
      return ArticlesModel.fromJson(json) as T;
    } else if (T.toString() == "HttpBannerEntity") {
      return HttpBannerEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
