import 'package:flutter_comic/share/store/ccache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesWrapper implements LocalStore {
  SharedPreferences sharedPreferences;
  SharedPreferencesWrapper(this.sharedPreferences);

  int getInt(String key) => sharedPreferences.getInt(key);
  double getDouble(String key) => sharedPreferences.getDouble(key);
  String getString(String key) => sharedPreferences.getString(key);
  bool getBool(String key) => sharedPreferences.getBool(key);
  List<String> getStringList(String key) =>
      sharedPreferences.getStringList(key);

  Future<bool> setInt(String key, int value) =>
      sharedPreferences.setInt(key, value);
  Future<bool> setDouble(String key, double value) =>
      sharedPreferences.setDouble(key, value);
  Future<bool> setString(String key, String value) =>
      sharedPreferences.setString(key, value);
  Future<bool> setBool(String key, bool value) =>
      sharedPreferences.setBool(key, value);
  Future<bool> setStringList(String key, List<String> value) =>
      sharedPreferences.setStringList(key, value);
}
