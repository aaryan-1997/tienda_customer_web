import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiendaweb/utils/constant.dart';

class LocalDbController extends GetxController {
  bool _isUserIdContaines = false;
  bool get isUserIdContaines => _isUserIdContaines;

  String _userId = "";
  String get userId => _userId;

  String _appName = "";
  String get appName => _appName;

  String _packageName = "";
  String get packageName => _packageName;

  String _appVersion = "";
  String get appVersion => _appVersion;

  String _appBuildNumber = "";
  String get appBuildNumber => _appBuildNumber;

  // Future<void> getAppDetails() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   _appName = packageInfo.appName;
  //   _packageName = packageInfo.packageName;
  //   _appVersion = packageInfo.version;
  //   _appBuildNumber = packageInfo.buildNumber;
  // }

  Future<void> userIdContains() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isUserIdContaines = prefs.containsKey(ConstantKey.userIdKey);
  }

  Future<void> getuserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString(ConstantKey.userIdKey).toString();
  }

  Future<bool> getAccessToken() async {
    bool hasAccessToken = false;
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(ConstantKey.accessTokenKey).toString();
      if (token.isNotEmpty) {
        hasAccessToken = true;
      }
      log(token);
    } catch (e) {
      log("Error_while_get_access_token===>" + e.toString());
    }
    return hasAccessToken;
  }

  // Future<void> getGstUpdate() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _skipGst = prefs.getBool(SpKey.skipGst) ?? false;

  //   update();
  // }

  Future<void> clearLocalDb() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
