import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast_web.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiendaweb/model/store/store_model.dart';
import 'package:tiendaweb/utils/common_alert.dart';
import 'package:tiendaweb/utils/custom_loader.dart';

import '../../api/api_service.dart';
import '../../api/api_url.dart';

class ShopProvider with ChangeNotifier{

  List<StoreModel> _storeModel = [];
  List<StoreModel> get storeModel =>_storeModel;

  bool _isAdd = false;
  bool get isAdd =>_isAdd;


  Future fetchStore({required BuildContext context,required bool isLoad}) async {
    var url = Uri.parse(Url.SHOPLIST);
if (isLoad) {
  showLoaderDialog(context);
}
    debugPrint('Data-==>  $url');
    final response = await ApiClient().getData(uri: url);
    var result = jsonDecode(response.body);
    if (isLoad) {
      Navigator.pop(context);
    }
    if (response.statusCode == 200) {
      var _list = result['data']as List;
      _storeModel.clear();
      _storeModel = _list.map((e) => StoreModel.fromJson(e)).toList();
      log('data===User>>  ${_storeModel[0].name}');
      notifyListeners();
    }
  }

  Future addStore({required BuildContext context,required bool isLoad,required String id}) async {
    var url = Uri.parse(Url.QRCODE+id);
if (isLoad) {
  showLoaderDialog(context);
}
    debugPrint('Data-==>  $url');
    final response = await ApiClient().getData(uri: url);
    var result = jsonDecode(response.body);
    if (isLoad) {
        Navigator.pop(context);
    }
    Fluttertoast.showToast(msg: result['message'], gravity: ToastGravity.CENTER);
    if (response.statusCode == 200) {
      _isAdd = true;

      notifyListeners();
    }
      else{
      _isAdd = false;
      notifyListeners();

    }
    }


}