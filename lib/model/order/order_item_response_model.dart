
class OrderItemResponseModel {
  List<PurchaseItem>? purchaseItemList;
  bool? success;
  int? status;

  OrderItemResponseModel({this.purchaseItemList, this.success, this.status});

  OrderItemResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      purchaseItemList = <PurchaseItem>[];
      json['data'].forEach((v) {
        purchaseItemList!.add(PurchaseItem.fromJson(v));
      });
    }
    success = json['success'];
    status = json['status'];
  }
}

class PurchaseItem {
  int? id;
  int? productId;
  String? productName;
  String? variation;
  String? price;
  String? tax;
  String? shippingCost;
  String? couponDiscount;
  int? quantity;
  String? paymentStatus;
  String? paymentStatusString;
  String? deliveryStatus;
  String? deliveryStatusString;
  bool? refundSection;
  bool? refundButton;
  String? refundLabel;
  int? refundRequestStatus;
  String? thumbnailImage;

  PurchaseItem({
    this.id,
    this.productId,
    this.productName,
    this.variation,
    this.price,
    this.tax,
    this.shippingCost,
    this.couponDiscount,
    this.quantity,
    this.paymentStatus,
    this.paymentStatusString,
    this.deliveryStatus,
    this.deliveryStatusString,
    this.refundSection,
    this.refundButton,
    this.refundLabel,
    this.refundRequestStatus,
    this.thumbnailImage,
  });

  PurchaseItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    variation = json['variation'];
    price = json['price'];
    tax = json['tax'];
    shippingCost = json['shipping_cost'];
    couponDiscount = json['coupon_discount'];
    quantity = json['quantity'];
    paymentStatus = json['payment_status'];
    paymentStatusString = json['payment_status_string'];
    deliveryStatus = json['delivery_status'];
    deliveryStatusString = json['delivery_status_string'];
    refundSection = json['refund_section'];
    refundButton = json['refund_button'];
    refundLabel = json['refund_label'];
    refundRequestStatus = json['refund_request_status'];
    thumbnailImage = json['thumbnail_image'];
  }
}

