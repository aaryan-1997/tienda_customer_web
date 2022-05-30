import 'dart:developer';

import 'package:get/get.dart';
import 'package:tiendaweb/api/api_service.dart';
import 'package:tiendaweb/api/app_constant.dart';
import 'package:tiendaweb/model/store/store_model.dart';

class StoreRepo extends GetxService {
  ApiClient apiClient;
  StoreRepo({required this.apiClient});

  Future<AddStoreResponse> addStore(key) async {
    AddStoreResponse addShop = AddStoreResponse();

    try {
      Response response =
          await apiClient.getData(url: AppConstant.QRCODE + key);
      if (response.statusCode == 200) {
        addShop = AddStoreResponse.fromJson(response.body);
      } else if (response.statusCode == 400) {
        addShop = AddStoreResponse.fromJson(response.body);
      }
    } catch (e) {
      log("Error===>" + e.toString());
    }
    return addShop;
  }

  Future<StoreResponse> shopList() async {
    StoreResponse shopList = StoreResponse();

    try {
      Response response = await apiClient.getData(url: AppConstant.SHOPLIST);
      if (response.statusCode == 200) {
        shopList = StoreResponse.fromJson(response.body);
      } else {}
    } catch (e) {
      log("Error===>" + e.toString());
    }
    return shopList;
  }

  //==nearShop Repo
  Future<StoreResponse> nearShop(body) async {
    StoreResponse shopList = StoreResponse();

    try {
      Response response =
          await apiClient.postData(url: AppConstant.NEARSHOP, body: body);
      if (response.statusCode == 200) {
        shopList = StoreResponse.fromJson(response.body);
      } else {}
    } catch (e) {
      log("Error===>" + e.toString());
    }
    return shopList;
  }
}
