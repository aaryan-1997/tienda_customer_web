import 'dart:developer';

import 'package:get/get.dart';

import '../api/api_service.dart';
import '../api/app_constant.dart';
import '../model/order/order_detail_response_model.dart';
import '../model/order/order_item_response_model.dart';
import '../model/order/order_response_model.dart';
import '../model/order/track_order_response_model.dart';

class OrderRepo extends GetxService {
  ApiClient apiClient;
  OrderRepo({required this.apiClient});

  Future<OrderResponseModel> getOrderHistory() async {
    OrderResponseModel orderResponse = OrderResponseModel();
    try {
      Response response =
          await apiClient.getData(url: AppConstant.PURCHASE_HISTORY);
      if (response.statusCode == 200) {
        orderResponse = OrderResponseModel.fromJson(response.body);
      }
    } catch (e) {
      log("Order history error" + e.toString());
    }
    return orderResponse;
  }

  Future<OrderDetailResponseModel> getOrderDetail(String orderId) async {
    OrderDetailResponseModel orderDetailResponse = OrderDetailResponseModel();
    try {
      Response response = await apiClient.getData(
          url: AppConstant.PURCHASE_HISTORY_DETAIL + orderId);
      if (response.statusCode == 200) {
        orderDetailResponse = OrderDetailResponseModel.fromJson(response.body);
      }
    } catch (e) {
      log("Order detail error" + e.toString());
    }
    return orderDetailResponse;
  }

  Future<OrderItemResponseModel> getPurchaseHistoryItems(String orderId) async {
    OrderItemResponseModel orderItemResponse = OrderItemResponseModel();
    try {
      Response response =
          await apiClient.getData(url: AppConstant.PURCHASE_ITEMS + orderId);
      if (response.statusCode == 200) {
        orderItemResponse = OrderItemResponseModel.fromJson(response.body);
      }
    } catch (e) {
      log("Purchase history detail error" + e.toString());
    }
    return orderItemResponse;
  }

  Future<TrackOrderResponseModel> getOrderTracking(String orderId) async {
    TrackOrderResponseModel trackOrderResponse = TrackOrderResponseModel();
    try {
      Response response =
          await apiClient.getData(url: AppConstant.TRACK_ORDER + orderId);
      if (response.statusCode == 200) {
        trackOrderResponse = TrackOrderResponseModel.fromJson(response.body);
      } else if (response.statusCode == 400) {
        trackOrderResponse = TrackOrderResponseModel.fromJson(response.body);
      } else {
        trackOrderResponse = TrackOrderResponseModel();
      }
    } catch (e) {
      log("Track order error " + e.toString());
    }
    return trackOrderResponse;
  }
}
