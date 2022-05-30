import 'package:shared_preferences/shared_preferences.dart';

class SPFunction {
  /// Adding a string value
  //set data into shared preferences like this
  Future<void> setString(String key, value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<void> setBool(String key, value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  Future<bool?> getBool(key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  /// Adding a string value
  //set data into shared preferences like this
  Future<void> setInt(String key, value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  /// Get string value
  Future<String> getString(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var result = pref.getString(key).toString();
    return result;
  }

  Future<int> getInt(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var result = pref.getInt(key)!.toInt();
    return result;
  }

  static Future<bool> contains(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.containsKey(key);
    return result;
  }

  void saveUserNameInSharedPrefrence(String userId) {}
}
