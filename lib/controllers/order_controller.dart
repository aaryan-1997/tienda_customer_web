import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendaweb/repository/order_repo.dart';

import '../model/order/order_detail_response_model.dart';
import '../model/order/order_response_model.dart';
import '../model/order/track_order_response_model.dart';
import '../utils/custom_loader.dart';

class OrderController extends GetxController {
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Order> _orderList = [];
  List<Order> get orderList => _orderList;

  List<TrackOrder> _trackOrderList = [];
  List<TrackOrder> get trackOrderList => _trackOrderList;

  OrderDetails _orderDetails = OrderDetails();
  OrderDetails get orderDetails => _orderDetails;

  Future<void> getOrderHistory() async {
    try {
      _orderList = [];
      OrderResponseModel response = await orderRepo.getOrderHistory();
      if (response.success != null && response.success == true) {
        _orderList = response.orderList!;
      } else {
        _orderList = [];
      }
    } catch (e) {
      log("Order history error" + e.toString());
    }
    update();
  }

  Future<void> getOrderDetail(
      {required String orderId}) async {
    try {
      _isLoading = true;
      _orderDetails = OrderDetails();
      showLoaderDialog();
      OrderDetailResponseModel response =
          await orderRepo.getOrderDetail(orderId);
      Get.back();
      if (response.success != null && response.success == true) {
        _orderDetails = response.purchaseDetails![0];
      } else {
        _orderDetails = OrderDetails();
      }
    } catch (e) {
      log("Order detail error" + e.toString());
      _isLoading = false;
      update();
    }
    _isLoading = false;
    update();
  }

  Future<void> getOrderTracking({required String orderId}) async {
    try {
      _isLoading = true;
       showLoaderDialog();
      TrackOrderResponseModel response =
          await orderRepo.getOrderTracking(orderId);
           Get.back();
      if (response.result != null && response.result == true) {
        _trackOrderList = response.trackOrder!;
      } else {
        _trackOrderList = [];
      }
    } catch (e) {
      log("Track order error " + e.toString());
      _isLoading = false;
      update();
    }
    _isLoading = false;
    update();
  }
}
