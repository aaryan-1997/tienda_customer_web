import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/address/address_response_model.dart';
import '../model/address/city_response_model.dart';
import '../model/address/state_response_model.dart';
import '../model/common_response.dart';
import '../repository/address_repo.dart';
import '../utils/app_utils.dart';
import '../utils/constant.dart';
import '../utils/custom_loader.dart';
import '../utils/sp_function.dart';

class AddressController extends GetxController {
  AddressRepo addressRepo;
  AddressController({required this.addressRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<States> _stateList = [];
  List<States> get stateList => _stateList;
  List<City> _cityList = [];
  List<City> get cityList => _cityList;
  List<Address> _addressList = [];
  List<Address> get addressList => _addressList;

  SPFunction spFunction = SPFunction();
  TextEditingController addressNameController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

  Future<void> getState() async {
    try {
      StateResponseModel response = await addressRepo.getState();
      if (response.status != null && response.status == 200) {
        _stateList = response.stateList!;
      }
    } catch (e) {
      log("State error" + e.toString());
    }
    update([_stateList]);
  }

  Future<void> getCityByState(String stateId) async {
    try {
      _cityList = [];
      _isLoading = true;
      update();
      showLoaderDialog();
      CityResponseModel response = await addressRepo.getCityByState(stateId);
      Get.back();
      if (response.status != null && response.status == 200) {
        _cityList = response.cityList!;
      } else if (response.success == false) {
        AppUtils().showSnackBar(message: "No city found!");
      }
    } catch (e) {
      log("City error" + e.toString());
      update([_isLoading = false]);
    }
    update();
  }

  Future<void> addNewShippingAddress() async {
    try {
      showLoaderDialog();
      var body = {
        "address": addressNameController.text.trim(),
        "state_id": stateController.text.trim(),
        "city_id": cityController.text.trim(),
        "postal_code": postalCodeController.text.trim(),
        "phone": mobileController.text.trim(),
        "longitude": longitudeController.text.trim(),
        "latitude": latitudeController.text.trim()
      };
      CommonResponse response = await addressRepo.addNewAddress(body);
      Get.back();
      if (response.result != null && response.result == true) {
        AppUtils().showSnackBar(message: response.message.toString());

        getAddress();
      } else if (response.result != null && response.result == false) {
        AppUtils().showSnackBar(message: response.message.toString());
      } else {
        AppUtils().showSnackBar(message: "Some error occure");
      }
    } catch (e) {
      log("Add address error" + e.toString());
    }

    update();
  }

  Future<void> updateAddress(String addId) async {
    try {
      var body = {
        "id": addId,
        "address": addressNameController.text.trim(),
        "state_id": stateController.text.trim(),
        "city_id": cityController.text.trim(),
        "postal_code": postalCodeController.text.trim(),
        "phone": mobileController.text.trim(),
        "longitude": longitudeController.text.trim(),
        "latitude": latitudeController.text.trim()
      };
      showLoaderDialog();
      CommonResponse response = await addressRepo.updateAddress(body);
      Get.back();
      if (response.result == true) {
        AppUtils().showSnackBar(message: response.message.toString());
        getAddress();
      } else if (response.result == false) {
        AppUtils().showSnackBar(message: response.message.toString());
      } else {
        AppUtils().showSnackBar(message: "Some error occure");
      }
    } catch (e) {
      log("Add address error" + e.toString());
    }

    update();
  }

  Future<void> getAddress() async {
    try {
      AddressResponseModel response = await addressRepo.getAddress();
      if (response.success != null && response.success == true) {
        _addressList = response.addressLIst!;
      } else {
        _addressList = [];
      }
    } catch (e) {
      log("Get address error" + e.toString());
    }
    update();
  }

  Future<void> makeDefaultAddress(String addId) async {
    try {
      showLoaderDialog();
      var body = {"id": addId};
      CommonResponse response = await addressRepo.makeDefaultAddress(body);
      Get.back();
      if (response.result != null && response.result == true) {
        AppUtils().showSnackBar(message: response.message.toString());
        getAddress();
      } else if (response.result != null && response.result == false) {
        AppUtils().showSnackBar(message: response.message.toString());
      } else {
        AppUtils().showSnackBar(message: "Some error occure");
      }
    } catch (e) {
      log("Default address error" + e.toString());
    }
    update();
  }

  Future<void> deleteAddress(String addId) async {
    try {
      showLoaderDialog();
      CommonResponse response = await addressRepo.deleteAddress(addId);
      Get.back();
      if (response.result != null && response.result == true) {
        AppUtils().showSnackBar(message: response.message.toString());
        getAddress();
      } else if (response.result != null && response.result == false) {
        AppUtils().showSnackBar(message: response.message.toString());
      } else {
        AppUtils().showSnackBar(message: "Some error occure");
      }
    } catch (e) {
      log("Delete address error" + e.toString());
    }
    update();
  }

//======
  Future getLocation() async {
    addressNameController.text =
        await spFunction.getString(ConstantKey.userAddressKey) != "null"
            ? await spFunction.getString(ConstantKey.userAddressKey)
            : "";
    latitudeController.text =
        await spFunction.getString(ConstantKey.userLatitudeKey) != "null"
            ? await spFunction.getString(ConstantKey.userLatitudeKey)
            : "";
    longitudeController.text =
        await spFunction.getString(ConstantKey.userLongitudeKey) != "null"
            ? await spFunction.getString(ConstantKey.userLongitudeKey)
            : "";
  }
}
