
class OrderResponseModel {
  List<Order>? orderList;
  bool? success;
  int? status;

  OrderResponseModel({this.orderList, this.success, this.status});

  OrderResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      orderList = <Order>[];
      json['data'].forEach((v) {
        orderList!.add(Order.fromJson(v));
      });
    }
    success = json['success'];
    status = json['status'];
  }
}

class Order {
  int? id;
  String? code;
  int? userId;
  String? paymentType;
  String? paymentStatus;
  String? paymentStatusString;
  String? deliveryStatus;
  String? deliveryStatusString;
  String? grandTotal;
  String? date;
  Links? links;

  Order(
      {this.id,
      this.code,
      this.userId,
      this.paymentType,
      this.paymentStatus,
      this.paymentStatusString,
      this.deliveryStatus,
      this.deliveryStatusString,
      this.grandTotal,
      this.date,
      this.links});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['tracking_code'];
    userId = json['user_id'];
    paymentType = json['payment_type'];
    paymentStatus = json['payment_status'];
    paymentStatusString = json['payment_status_string'];
    deliveryStatus = json['delivery_status'];
    deliveryStatusString = json['delivery_status_string'];
    grandTotal = json['grand_total'];
    date = json['date'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
}

class Links {
  String? details;

  Links({this.details});

  Links.fromJson(Map<String, dynamic> json) {
    details = json['details'];
  }
}
