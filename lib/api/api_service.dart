import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiendaweb/api/app_constant.dart';

import '../utils/constant.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    token = AppConstant.ACCESS_TOKEN;
    timeout = const Duration(seconds: 30);
    mainHeaders = {
      'Contect-type': 'application/json;charset-UTF-8',
    };
  }

  Future<Response> getData({required String url}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accessToken = prefs.getString(ConstantKey.accessTokenKey).toString();
      Response response = await get(url, headers: {
        'Contect-type': 'application/json;charset-UTF-8',
        'Authorization': 'Bearer $accessToken'
      });
      log(response.statusText.toString());
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData({required String url, body}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accessToken = prefs.getString(ConstantKey.accessTokenKey).toString();
      Response response = await post(url, body, headers: {
        'Contect-type': 'application/json;charset-UTF-16',
        'Authorization': 'Bearer $accessToken'
      });
      log(response.statusText.toString());
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
