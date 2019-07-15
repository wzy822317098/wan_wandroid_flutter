import 'package:shared_preferences/shared_preferences.dart';
///@description 缓存工具类
///
///@created by wangzhouyao on 2019-07-10
class SharedPreferencsUtils {
  static const KEY_SEARCH_KEY_HISTORY = 'key_search_key_history';

  static SharedPreferencsUtils _instance;

  static SharedPreferencsUtils getInstance() {
    if (_instance == null) {
      _instance = SharedPreferencsUtils();
    }
    return _instance;
  }

  ///存储String类型数据
  void saveString(String key, String value) async {
    final spf = await SharedPreferences.getInstance();
    spf.setString(key, value);
  }

  ///获取String类型数据
  Future<String> getString(String key) async {
    final spf = await SharedPreferences.getInstance();
    return spf.get(key);
  }

  ///存储String到List
  void saveStringToList(String key, String value,{int limit=-1}) async {
    final spf = await SharedPreferences.getInstance();
    List<String> cache = spf.getStringList(key);
    if (cache == null) {
      cache = List<String>();
    }
    if(cache.contains(value)){
      cache.remove(value);
    }
    cache.add(value);

    if(limit>0 && cache.length >limit){
      cache.removeAt(0);
    }
    spf.setStringList(key, cache);
  }

  ///获取StringList
  Future<List<String>>  getSytringList(String key) async{
    final spf =await SharedPreferences.getInstance();
    return spf.getStringList(key);
  }

  Future<bool> removeStringFromList(String key,String value) async{
    final spf =await SharedPreferences.getInstance();
    List<String> cache =spf.getStringList(key);
    if(cache !=null && cache.contains(value)){
     return cache.remove(value);
    }
    return false;
  }

  ///移除对应数据
  Future<bool> remove(String key) async{
    final spf =await SharedPreferences.getInstance();
    return spf.remove(key);
  }
}
