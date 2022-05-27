import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tiendaweb/model/homeModel/slider_model.dart';

import '../../api/api_service.dart';
import '../../api/api_url.dart';
import '../../utils/custom_loader.dart';

class HomeProvider with ChangeNotifier {
  List<SliderModel> _slider = [];
  List<SliderModel> get sliders => _slider;

  Future fetchSlider(
      {required BuildContext context,
      required bool isLoad,
      required String id}) async {
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
  }
}
