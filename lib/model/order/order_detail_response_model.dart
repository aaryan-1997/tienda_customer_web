
class OrderDetailResponseModel {
  List<OrderDetails>? purchaseDetails;
  bool? success;
  int? status;

  OrderDetailResponseModel({this.purchaseDetails, this.success, this.status});

  OrderDetailResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      purchaseDetails = <OrderDetails>[];
      json['data'].forEach((v) {
        purchaseDetails!.add(OrderDetails.fromJson(v));
      });
    }
    success = json['success'];
    status = json['status'];
  }
}

class OrderDetails {
  int? id;
  String? code;
  int? userId;
  ShippingAddress? shippingAddress;
  String? paymentType;
  String? pickupPoint;
  String? shippingType;
  String? shippingTypeString;
  String? paymentStatus;
  String? paymentStatusString;
  String? deliveryStatus;
  String? deliveryStatusString;
  String? grandTotal;
  String? couponDiscount;
  String? shippingCost;
  String? subtotal;
  String? tax;
  String? date;
  bool? cancelRequest;
  List<OrderItems>? orderItems;
  bool? manuallyPayable;
  Links? links;

  OrderDetails(
      {this.id,
      this.code,
      this.userId,
      this.shippingAddress,
      this.paymentType,
      this.pickupPoint,
      this.shippingType,
      this.shippingTypeString,
      this.paymentStatus,
      this.paymentStatusString,
      this.deliveryStatus,
      this.deliveryStatusString,
      this.grandTotal,
      this.couponDiscount,
      this.shippingCost,
      this.subtotal,
      this.tax,
      this.date,
      this.cancelRequest,
      this.orderItems,
      this.manuallyPayable,
      this.links});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['tracking_code'];
    userId = json['user_id'];
    shippingAddress = json['shipping_address'] != null
        ? ShippingAddress.fromJson(json['shipping_address'])
        : null;
    paymentType = json['payment_type'];
    pickupPoint = json['pickup_point'];
    shippingType = json['shipping_type'];
    shippingTypeString = json['shipping_type_string'];
    paymentStatus = json['payment_status'];
    paymentStatusString = json['payment_status_string'];
    deliveryStatus = json['delivery_status'];
    deliveryStatusString = json['delivery_status_string'];
    grandTotal = json['grand_total'];
    couponDiscount = json['coupon_discount'];
    shippingCost = json['shipping_cost'];
    subtotal = json['subtotal'];
    tax = json['tax'];
    date = json['date'];
    cancelRequest = json['cancel_request'];
    if (json['order_details'] != null) {
      orderItems = <OrderItems>[];
      json['order_details'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
    manuallyPayable = json['manually_payable'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
}

class ShippingAddress {
  String? name;
  String? email;
  String? address;
  String? state;
  String? city;
  String? postalCode;
  String? phone;
  String? latLang;

  ShippingAddress(
      {this.name,
      this.email,
      this.address,
      this.state,
      this.city,
      this.postalCode,
      this.phone,
      this.latLang});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    address = json['address'];
    state = json['state'];
    city = json['city'];
    postalCode = json['postal_code'];
    phone = json['phone'];
    latLang = json['lat_lang'];
  }
}

class OrderItems {
  int? id;
  int? orderId;
  int? sellerId;
  int? productId;
  String? variation;
  int? price;
  int? tax;
  int? shippingCost;
  int? quantity;
  String? paymentStatus;
  String? deliveryStatus;
  String? shippingType;
  String? pickupPointId;
  String? productReferralCode;
  String? createdAt;
  String? updatedAt;
  String? thumbnailImg;
  String? name;

  OrderItems({
    this.id,
    this.orderId,
    this.sellerId,
    this.productId,
    this.variation,
    this.price,
    this.tax,
    this.shippingCost,
    this.quantity,
    this.paymentStatus,
    this.deliveryStatus,
    this.shippingType,
    this.pickupPointId,
    this.productReferralCode,
    this.createdAt,
    this.updatedAt,
    this.thumbnailImg,
    this.name,
  });

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    sellerId = json['seller_id'];
    productId = json['product_id'];
    variation = json['variation'];
    price = json['price'];
    tax = json['tax'];
    shippingCost = json['shipping_cost'];
    quantity = json['quantity'];
    paymentStatus = json['payment_status'];
    deliveryStatus = json['delivery_status'];
    shippingType = json['shipping_type'];
    pickupPointId = json['pickup_point_id'];
    productReferralCode = json['product_referral_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    thumbnailImg = json['thumbnail_img'];
    name = json['name'];
  }
}

class Links {
  String? details;

  Links({this.details});

  Links.fromJson(Map<String, dynamic> json) {
    details = json['details'];
  }
}

