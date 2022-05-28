import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tiendaweb/model/homeModel/category_response.dart';
import 'package:tiendaweb/model/homeModel/common_response.dart';
import 'package:tiendaweb/model/homeModel/product_response.dart';
import 'package:tiendaweb/model/homeModel/slider_model.dart';

import '../../api/api_service.dart';
import '../../api/api_url.dart';
import '../../utils/custom_loader.dart';

class HomeProvider with ChangeNotifier {
  List<SliderModel> _slider = [];
  List<SliderModel> get sliders => _slider;

  List<Category> _category = [];
  List<Category> get category => _category;

  List<Product> _productList = <Product>[];
  List<Product> get productList => _productList;

  Future fetchSlider(
      {required BuildContext context,
      required bool isLoad,
      required String id}) async {
    try {
      var url = Uri.parse(Url.SLIDER);
      if (isLoad) {
        showLoaderDialog(context);
      }
      var _body = {"id": id};
      debugPrint('Data-=1=>  $url');
      debugPrint('Data-=2=>  $_body');

      final response = await ApiClient().postData(
        url: url,
        body: _body,
      );
      var result = jsonDecode(response.body);
      if (isLoad) {
        Navigator.pop(context);
      }
      if (response.statusCode == 200) {
        var _list = result['data'] as List;
        _slider.clear();
        _slider = _list.map((e) => SliderModel.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      log("Slider Error===>" + e.toString());
      notifyListeners();
    }
  }

  Future fetchCategory(
      {required BuildContext context,
      required bool isLoad,
      required String id}) async {
    try {
      var body = {"shopid": id};
      var url = Uri.parse(Url.CATEGORY);
      if (isLoad) {
        showLoaderDialog(context);
      }
      final response = await ApiClient().postData(url: url, body: body);
      if (isLoad) {
        Navigator.pop(context);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        CategoryResponse _list = CategoryResponse.fromJson(result);
        _category.clear();
        _category = _list.category!;
        notifyListeners();
      }
    } catch (e) {
      log("Category Error===>" + e.toString());
      notifyListeners();
    }
  }

  Future fetchProduct(
      {required BuildContext context,
      required bool isLoad,
      required String id}) async {
    try {
      var url = Uri.parse(Url.HOME_PRODUCT + id);
      if (isLoad) {
        showLoaderDialog(context);
      }
      final response = await ApiClient().getData(uri: url);
      if (isLoad) {
        Navigator.pop(context);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        ProductResponse _list = ProductResponse.fromJson(result);
        _productList.clear();
        _productList = _list.product!;
        notifyListeners();
      }
    } catch (e) {
      log("Product Error===>" + e.toString());
      notifyListeners();
    }
  }

  Future addToWishList(
      {required BuildContext context,
      required bool isLoad,
      required String storeId,
      required String prodId}) async {
    try {
      var body = {"shop_id": storeId, "product_id": prodId};
      var url = Uri.parse(Url.ADD_TO_WISHLIST);
      if (isLoad) {
        showLoaderDialog(context);
      }
      final response = await ApiClient().postData(url: url, body: body);
      if (isLoad) {
        Navigator.pop(context);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        CommonResponse commonResponse = CommonResponse.fromJson(result);
        if (commonResponse.result != null && commonResponse.result == true) {
          fetchProduct(context: context, isLoad: isLoad, id: storeId);
          Fluttertoast.showToast(
              msg: commonResponse.message.toString(),
              timeInSecForIosWeb: 2,
              gravity: ToastGravity.CENTER);
        }

        notifyListeners();
      }
    } catch (e) {
      log("Add to wishlist Error===>" + e.toString());
      notifyListeners();
    }
  }

  Future removeFromWishList(
      {required BuildContext context,
      required bool isLoad,
      required String storeId,
      required String prodId}) async {
    try {
      var body = {"shop_id": storeId, "product_id": prodId};
      var url = Uri.parse(Url.REMOVE_WISHLIST);
      if (isLoad) {
        showLoaderDialog(context);
      }
      final response = await ApiClient().postData(url: url, body: body);
      if (isLoad) {
        Navigator.pop(context);
      }
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        CommonResponse commonResponse = CommonResponse.fromJson(result);
        if (commonResponse.result != null && commonResponse.result == true) {
          fetchProduct(context: context, isLoad: isLoad, id: storeId);
          Fluttertoast.showToast(
              msg: commonResponse.message.toString(),
              timeInSecForIosWeb: 2,
              gravity: ToastGravity.CENTER);
        }
        notifyListeners();
      }
    } catch (e) {
      log("Add to wishlist Error===>" + e.toString());
      notifyListeners();
    }
  }
}
