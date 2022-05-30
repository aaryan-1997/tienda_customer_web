import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendaweb/controllers/store_controller.dart';
import 'package:tiendaweb/model/authModel/auth_model.dart';
import 'package:tiendaweb/model/authModel/user_info_model.dart';
import 'package:tiendaweb/repository/auth_repo.dart';
import 'package:tiendaweb/routes/routes.dart';
import 'package:tiendaweb/utils/app_utils.dart';
import 'package:tiendaweb/utils/constant.dart';
import 'package:tiendaweb/utils/sp_function.dart';

class AuthController extends GetxController {
  AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  UserDetails _userModel = UserDetails();
  UserDetails get userDetail => _userModel;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  SPFunction spFunction = SPFunction();
  final StoreController _storeController = Get.find();
  String fcmToken = "";
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  Future<void> getFcmToken() async {
    _firebaseMessaging.getToken().then((String? token) {
      fcmToken = token.toString();
    });
    update([fcmToken]);
  }

//=====================Login
  Future<void> login() async {
    try {
      _isLoading = true;
      update();
      var body = {
        "username": mobileNumberController.text.trim(),
        "device_token": fcmToken
      };
      UserModel response = await authRepo.login(body);
      if ((response.result != null && response.result == true) &&
          (response.isExist != null && response.isExist == true)) {
        Get.offNamedUntil(
            Routes.getOtpRoute(mobileNumberController.text.trim()),
            (route) => false);
      } else {
        Get.offNamedUntil(Routes.getSignupRoute(), (route) => false);
      }
    } catch (e) {
      log("Login_error==>" + e.toString());
      _isLoading = false;
      update();
    }
    _isLoading = false;
    update();
  }

  //=====================SignUp
  Future<void> signUp() async {
    try {
      _isLoading = true;
      update();
      var body = {
        "user_mobile": mobileNumberController.text.trim(),
        "user_name": nameController.text.trim(),
        "device_token": fcmToken,
      };
      SignUpModel response = await authRepo.signUp(body);
      if (response.result != null && response.result == true) {
        Get.offNamedUntil(
            Routes.getOtpRoute(mobileNumberController.text.trim()),
            (route) => false);
      } else if (response.result != null && response.result == false) {
        AppUtils().showSnackBar(message: response.message.toString());
      }
    } catch (e) {
      _isLoading = false;
      update();
    }
    _isLoading = false;
    update();
  }

  ///===================otp
  Future<void> otp() async {
    try {
      _isLoading = true;
      update();
      var body = {"otp_text": otpController.text};
      AuthModel authModel = await authRepo.otp(body);
      if (authModel.result != null && authModel.result == true) {
        if (authModel.user != null) {
          spFunction.setString(
              ConstantKey.userIdKey, authModel.user!.id.toString());
          spFunction.setString(
              ConstantKey.accessTokenKey, authModel.accessToken.toString());

          getUserDetails();
          await _storeController.getshopList();
          await _storeController.getNearByShop();

          Get.offNamedUntil(Routes.getStoreRoute(), (route) => false);
        }
      } else if (authModel.result != null && authModel.result == false) {
        AppUtils().showSnackBar(message: authModel.message.toString());
      }
    } catch (e) {
      _isLoading = false;
      update();
    }
    _isLoading = false;
    update();
  }

  Future<void> getUserDetails() async {
    try {
      UserDetailModel response = await authRepo.getUserDetails();
      if (response.success != null && response.success == true) {
        _userModel = response.userDetails!;
      }
      update();
    } catch (e) {
      log("User Detail error" + e.toString());
    }
  }
}
