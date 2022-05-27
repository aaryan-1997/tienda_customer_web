import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiendaweb/api/api_service.dart';
import 'package:tiendaweb/model/authModel/auth_model.dart';
import 'package:tiendaweb/model/authModel/user_info_model.dart';

import '../../api/api_url.dart';
import '../../utils/constant.dart';

class AuthProvider with ChangeNotifier {
  CheckAuthModel? _checkAuthModel;

  CheckAuthModel? get checkAuthModel => _checkAuthModel;


  AuthUserModel? _authModel;

  AuthUserModel? get authModel => _authModel;

  UserInfoModel? _userInfo;

  UserInfoModel? get userInfo => _userInfo;

  Future login({required BuildContext context, required Map data}) async {
    var url = Uri.parse(Url.CUSTOMER_LOGIN);

    debugPrint('Data-==>  $url');
    // debugPrint('Data-==>  $data');
    var _body = jsonEncode(data);
    // debugPrint('Data==1>  $_body');
    final response = await ApiClient().login(url: url, body: data);
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _checkAuthModel=null;
      _checkAuthModel = CheckAuthModel.fromJson(result);
      log('data===>>  ${_checkAuthModel!.isExist}');
      notifyListeners();
    }
  }

  Future signUp({required BuildContext context, required Map data}) async {
    var url = Uri.parse(Url.CUSTOMER_SIGNUP);

    debugPrint('Data-==>  $url');
    // debugPrint('Data-==>  $data');
    var _body = jsonEncode(data);
    final response = await ApiClient().login(url: url, body: data);
    var result = jsonDecode(response.body);
    debugPrint('Data==1>  $result');

    if (response.statusCode == 200) {
      // _checkAuthModel = CheckAuthModel.fromJson(result);
      // log('data===>>  ${_checkAuthModel!.isExist}');
      notifyListeners();
    }
  }
  Future otp({required BuildContext context, required Map data}) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var url = Uri.parse(Url.OTP_VERIFY);

    debugPrint('Data-==>  $url');
    debugPrint('Data-==>  $data');
    final response = await ApiClient().login(url: url, body: data);
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _authModel=null;
      _authModel = AuthUserModel.fromJson(result);
      _pref.setBool(isUserLoginKey, true);
      _pref.setString(accessTokenKey, _authModel!.accessToken);
      _pref.setString(userIdKey, _authModel!.user.id.toString());
      _pref.setString(userNameKey, _authModel!.user.name);
      _pref.setString(userPhoneKey, _authModel!.user.phone);
      _pref.setString(userTypeKey, _authModel!.user.type);
      log('data===User>>  ${_authModel!.user.name}');
      notifyListeners();
    }
  }


  Future fetchUserInfo({required BuildContext context}) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var url = Uri.parse(Url.USER_INFO);

    debugPrint('Data-==>  $url');

    final response = await ApiClient().getData(uri: url);
    var result = jsonDecode(response.body);

    debugPrint('Data-==>  ${response.body}');
    if (response.statusCode == 200) {
      _userInfo=null;
      _userInfo = UserInfoModel.fromJson(result);

      log('data===User>>  ${_userInfo!.name}');
      notifyListeners();
    }
  }
}
