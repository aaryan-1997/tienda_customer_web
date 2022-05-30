import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendaweb/controllers/home_controller.dart';
import 'package:tiendaweb/model/store/store_model.dart';
import 'package:tiendaweb/repository/store_repo.dart';
import 'package:tiendaweb/utils/constant.dart';
import 'package:tiendaweb/utils/custom_loader.dart';
import 'package:tiendaweb/utils/sp_function.dart';

class StoreController extends GetxController {
  StoreRepo storeRepo;
  StoreController({required this.storeRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  StoreDetail _storedetail = StoreDetail();
  StoreDetail get storedetail => _storedetail;

  List<StoreDetail> _storedetailList = [];
  List<StoreDetail> _nearbyStore = [];

  List<StoreDetail> get nearbyStore => _nearbyStore;
  List<StoreDetail> get storedetailList => _storedetailList;

  SPFunction spFunction = SPFunction();
  final HomeController _homeController = Get.find();

  TextEditingController shopIdController = TextEditingController();

  //======Add Shop
  Future<bool> addStore() async {
    bool isAdded = false;
    try {
      _isLoading = true;
      update();
      AddStoreResponse response =
          await storeRepo.addStore(shopIdController.text.trim());
      if (response.success != null && response.success == true) {
        //showSnackBar("Success", response.message.toString());
        getNearByShop();
        getshopList();
        _storedetail = response.shopDetail!;
        shopIdController.clear();
        isAdded = true;
      } else if (response.success != null && response.success == false) {
        isAdded = false;
        //showSnackBar("Error", response.message.toString());
      }
    } catch (e) {
      _isLoading = false;
      update();
      log("Add shop error ===>" + e.toString());
    }
    _isLoading = false;
    update();
    return isAdded;
  }

  //=====================shop List
  Future<void> getshopList() async {
    try {
      StoreResponse response = await storeRepo.shopList();
      if (response.result != null && response.result == true) {
        _storedetailList = response.shopDetail!;
      }
      update();
    } catch (e) {
      log("List shop error ===>" + e.toString());
    }
  }

  //== nearshop list
  Future<void> getNearByShop() async {
    var latitude = await spFunction.getString(ConstantKey.userLatitudeKey);
    var longitude = await spFunction.getString(ConstantKey.userLongitudeKey);

    var body = {
      "latitude": latitude,
      "longitude": longitude,
    };

    try {
      StoreResponse response = await storeRepo.nearShop(body);
      if (response.result != null && response.result == true) {
        _nearbyStore = response.shopDetail!;
      }
      update();
    } catch (e) {
      log("Nearby shop error ===>" + e.toString());
    }
  }

  Future<void> initalLoad(BuildContext context) async {
    showLoaderDialog(context);
    await _homeController.category();
    await _homeController.homeProduct();
    Navigator.pop(context);
  }
}
