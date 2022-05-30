import 'dart:developer';

import 'package:get/get.dart';
import 'package:tiendaweb/api/api_service.dart';
import 'package:tiendaweb/api/app_constant.dart';
import 'package:tiendaweb/model/authModel/auth_model.dart';
import 'package:tiendaweb/model/authModel/user_info_model.dart';

class AuthRepo extends GetxService {
  ApiClient apiClient;
  AuthRepo({required this.apiClient});

  Future<UserModel> login(body) async {
    UserModel user = UserModel();
    try {
      Response response =
          await apiClient.postData(url: AppConstant.CUSTOMER_LOGIN, body: body);
      if (response.statusCode == 200) {
        user = UserModel.fromJson(response.body);
      } else {}
    } catch (e) {
      log("Error===>" + e.toString());
    }
    return user;
  }

  Future<SignUpModel> signUp(body) async {
    SignUpModel authModel = SignUpModel();
    try {
      Response response = await apiClient.postData(
          url: AppConstant.CUSTOMER_SIGNUP, body: body);
      if (response.statusCode == 200) {
        authModel = SignUpModel.fromJson(response.body);
      } else if (response.statusCode == 400) {
        authModel = SignUpModel.fromJson(response.body);
      } else {
        authModel = SignUpModel();
      }
    } catch (e) {
      log("Error===>" + e.toString());
    }
    return authModel;
  }

  Future<AuthModel> otp(body) async {
    AuthModel authModel = AuthModel();
    try {
      Response response =
          await apiClient.postData(url: AppConstant.OTP_VERIFY, body: body);
      if (response.statusCode == 200) {
        authModel = AuthModel.fromJson(response.body);
      } else {}
    } catch (e) {
      log("Error===>" + e.toString());
    }
    return authModel;
  }

  Future<UserDetailModel> getUserDetails() async {
    UserDetailModel userDetail = UserDetailModel();

    try {
      Response response = await apiClient.getData(url: AppConstant.USER_INFO);
      if (response.statusCode == 200) {
        userDetail = UserDetailModel.fromJson(response.body);
      } else {}
    } catch (e) {
      log("Error===>" + e.toString());
    }
    return userDetail;
  }
}
