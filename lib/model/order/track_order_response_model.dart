
class TrackOrderResponseModel {
  bool? result;
  String? message;
  List<TrackOrder>? trackOrder;

  TrackOrderResponseModel({this.result, this.message, this.trackOrder});

  TrackOrderResponseModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['data'] != null) {
      trackOrder = <TrackOrder>[];
      json['data'].forEach((v) {
        trackOrder!.add(TrackOrder.fromJson(v));
      });
    }
  }
}

class TrackOrder {
  int? id;
  int? deliveryBoyId;
  int? sellerId;
  int? orderId;
  String? deliveryStatus;
  String? paymentType;
  int? earning;
  int? collection;
  String? createdAt;
  String? updatedAt;
  String? changeBy;

  TrackOrder(
      {this.id,
      this.deliveryBoyId,
      this.sellerId,
      this.orderId,
      this.deliveryStatus,
      this.paymentType,
      this.earning,
      this.collection,
      this.createdAt,
      this.updatedAt,
      this.changeBy});

  TrackOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryBoyId = json['delivery_boy_id'];
    sellerId = json['seller_id'];
    orderId = json['order_id'];
    deliveryStatus = json['delivery_status'];
    paymentType = json['payment_type'];
    earning = json['earning'];
    collection = json['collection'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    changeBy = json['change_by'];
  }
}

