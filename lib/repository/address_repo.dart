import 'dart:developer';

import 'package:get/get.dart';
import 'package:tiendaweb/api/api_service.dart';

import '../api/app_constant.dart';
import '../model/address/address_response_model.dart';
import '../model/address/city_response_model.dart';
import '../model/address/state_response_model.dart';
import '../model/common_response.dart';

class AddressRepo extends GetxService {
  ApiClient apiClient;
  AddressRepo({required this.apiClient});

  Future<StateResponseModel> getState() async {
    StateResponseModel stateResponse = StateResponseModel();
    try {
      Response response = await apiClient.getData(url: AppConstant.STATE);
      if (response.statusCode == 200) {
        stateResponse = StateResponseModel.fromJson(response.body);
      } else if (response.statusCode == 400) {
        stateResponse = StateResponseModel.fromJson(response.body);
      }
    } catch (e) {
      log("State error" + e.toString());
    }
    return stateResponse;
  }

  Future<CityResponseModel> getCityByState(String stateId) async {
    CityResponseModel cityResponse = CityResponseModel();
    try {
      Response response =
          await apiClient.getData(url: AppConstant.CITY_BY_STATE + stateId);
      if (response.statusCode == 200) {
        cityResponse = CityResponseModel.fromJson(response.body);
      } else if (response.statusCode == 400) {
        cityResponse = CityResponseModel.fromJson(response.body);
      }
    } catch (e) {
      log("City error" + e.toString());
    }
    return cityResponse;
  }

  Future<CommonResponse> addNewAddress(body) async {
    CommonResponse commonResponse = CommonResponse();
    try {
      Response response =
          await apiClient.postData(url: AppConstant.CREATE_ADDRESS, body: body);
      if (response.statusCode == 200) {
        commonResponse = CommonResponse.fromJson(response.body);
      } else if (response.statusCode == 400) {
        commonResponse = CommonResponse.fromJson(response.body);
      }
    } catch (e) {
      log("Add address error" + e.toString());
    }
    return commonResponse;
  }

  Future<CommonResponse> updateAddress(body) async {
    CommonResponse commonResponse = CommonResponse();
    try {
      Response response =
          await apiClient.postData(url: AppConstant.UPDATE_ADDRESS, body: body);
      if (response.statusCode == 200) {
        commonResponse = CommonResponse.fromJson(response.body);
      } else if (response.statusCode == 400) {
        commonResponse = CommonResponse.fromJson(response.body);
      }
    } catch (e) {
      log("Update address error" + e.toString());
    }
    return commonResponse;
  }

  Future<AddressResponseModel> getAddress() async {
    AddressResponseModel addressResponse = AddressResponseModel();
    try {
      Response response = await apiClient.getData(url: AppConstant.GET_ADDRESS);
      if (response.statusCode == 200) {
        addressResponse = AddressResponseModel.fromJson(response.body);
      } else if (response.statusCode == 400) {
        addressResponse = AddressResponseModel.fromJson(response.body);
      }
    } catch (e) {
      log("Get shipping Address" + e.toString());
    }
    return addressResponse;
  }

  Future<CommonResponse> makeDefaultAddress(body) async {
    CommonResponse commonResponse = CommonResponse();
    try {
      Response response = await apiClient.postData(
          url: AppConstant.MAKE_DEFAULT_ADDRESS, body: body);
      if (response.statusCode == 200) {
        commonResponse = CommonResponse.fromJson(response.body);
      } else if (response.statusCode == 400) {
        commonResponse = CommonResponse.fromJson(response.body);
      }
    } catch (e) {
      log("Delete address error" + e.toString());
    }
    return commonResponse;
  }

  Future<CommonResponse> deleteAddress(String addId) async {
    CommonResponse commonResponse = CommonResponse();
    try {
      Response response =
          await apiClient.getData(url: AppConstant.DELETE_ADDRESS + addId);
      if (response.statusCode == 200) {
        commonResponse = CommonResponse.fromJson(response.body);
      } else if (response.statusCode == 400) {
        commonResponse = CommonResponse.fromJson(response.body);
      }
    } catch (e) {
      log("Delete address error" + e.toString());
    }
    return commonResponse;
  }
}
