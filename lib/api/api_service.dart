import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constant.dart';

class ApiClient {
  late String token;
  /*final String appBaseUrl;
  late Map<String, String> mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = AppConstant.ACCESS_TOKEN;
    mainHeaders = {
      'Contect-type': 'application/json;charset-UTF-8',
      'Authorization': 'Bearer $token'
    };
  }
*/
  Future<http.Response> getData({required Uri uri}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accessToken = prefs.getString(accessTokenKey).toString();
      final response = await http.get(uri, headers: {
        'Contect-type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });
      log('Response__GET___====>>${response.body.toString()}');
      return response;
    } catch (e) {
      return http.Response(e.toString(), 1);
    }
  }

  Future<http.Response> postData({required Uri url, required Map body}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accessToken = prefs.getString(accessTokenKey).toString();
      log('Response__POST___====>>$accessToken');
      final response = await http.post(url, body: body, headers: {
        'Contect-type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });
      log('Response__POST___====>>${response.body.toString()}');
      return response;
    } catch (e) {
      return http.Response(e.toString(), 1);
    }
  }

  Future<http.Response> login({required Uri url, required Map body}) async {
    try {
      var headers = {'Contect-type': 'application/json;charset-UTF-8'};
      debugPrint('BODY___====>>$body');
      final response = await http.post(url, body: body, headers: headers);
      debugPrint('Response__Status___====>>${response.statusCode.toString()}');
      debugPrint('Response___====>>${response.body.toString()}');
      return response;
    } catch (e) {
      return http.Response(e.toString(), 1);
    }
  }
}
