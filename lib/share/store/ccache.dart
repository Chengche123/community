import 'package:flutter_comic/store/impl/shared-preferences/wrap.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStore {
  int getInt(String key);
  double getDouble(String key);
  String getString(String key);
  bool getBool(String key);
  List<String> getStringList(String key);

  Future<bool> setInt(String key, int value);
  Future<bool> setDouble(String key, double value);
  Future<bool> setString(String key, String value);
  Future<bool> setBool(String key, bool value);
  Future<bool> setStringList(String key, List<String> value);
}

class CCache {
  LocalStore _store;
  // 私有构造函数?
  CCache._(this._store);

  static CCache aCCache;
  static Future<void> preinit() async {
    if (aCCache == null) {
      var prefs = await SharedPreferences.getInstance();
      var wrapper = SharedPreferencesWrapper(prefs);
      aCCache = CCache._(wrapper);
      print("CCache: inited");
    }
  }

  final String _configPrefix = "comic.config.";

  Future<bool> setConfig(String key, String value) {
    return _store.setString(_configPrefix + key, value);
  }

  String getConfig(String key) {
    return _store.getString(_configPrefix + key);
  }

  final String _cookiePrefix = "comic.cookie.";

  Future<bool> setCookie(String key, String value) {
    return _store.setString(_cookiePrefix + key, value);
  }

  String getCookie(String key) {
    return _store.getString(_cookiePrefix + key);
  }
}
