import '../../api/app_constant.dart';

class StoreResponse {
  List<StoreDetail>? shopDetail;
  bool? result;
  String? message;

  StoreResponse({this.shopDetail, this.result, this.message});

  StoreResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      shopDetail = <StoreDetail>[];
      json['data'].forEach((v) {
        shopDetail!.add(StoreDetail.fromJson(v));
      });
    }
    result = json['result'];
    message = json['message'];
  }
}

class AddStoreResponse {
  StoreDetail? shopDetail;
  bool? success;
  String? message;

  AddStoreResponse({this.shopDetail, this.success, this.message});

  AddStoreResponse.fromJson(Map<String, dynamic> json) {
    shopDetail =
        json['data'] != null ? StoreDetail.fromJson(json['data']) : null;
    success = json['success'];
    message = json['message'];
  }
}

class StoreDetail {
  StoreDetail({
    this.id,
    this.status,
    this.userId,
    this.catalogMode,
    this.businessCategory,
    this.businessTemplateType,
    this.name,
    this.logo,
    this.address,
    this.facebook,
    this.google,
    this.twitter,
    this.qrcode,
    this.trueRating,
    this.rating,
  });

  int? id;
  String? status;
  int? userId;
  CatalogMode? catalogMode;
  String? businessCategory;
  String? businessTemplateType;
  String? name;
  String? logo;
  String? address;
  String? facebook;
  String? google;
  String? twitter;
  String? qrcode;
  int? trueRating;
  int? rating;

  factory StoreDetail.fromJson(Map<String, dynamic> json) => StoreDetail(
        id: json["id"],
        status: json["status"],
        userId: json["user_id"],
        catalogMode: CatalogMode.fromJson(json["catalog_mode"]),
        businessCategory: json["business_category"],
        businessTemplateType: json["business_template_type"],
        name: json["name"],
        logo: AppConstant.IMAGE_BASE_URL + json["logo"],
        address: json["address"],
        facebook: json["facebook"],
        google: json["google"],
        twitter: json["twitter"],
        qrcode: json["qrcode"],
        trueRating: json["true_rating"],
        rating: json["rating"],
      );
}

class CatalogMode {
  CatalogMode({
    required this.enableCart,
    required this.enablePrice,
  });

  bool enableCart;
  bool enablePrice;

  factory CatalogMode.fromJson(Map<String, dynamic> json) => CatalogMode(
        enableCart: json["enable_cart"],
        enablePrice: json["enable_price"],
      );
}
