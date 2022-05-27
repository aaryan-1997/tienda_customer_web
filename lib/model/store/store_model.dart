

import '../../api/api_url.dart';

class StoreModel {
  StoreModel({
    required this.id,
    required this.status,
    required this.userId,
    required this.catalogMode,
    required this.businessCategory,
    required this.businessTemplateType,
    required this.name,
    required this.logo,
    required this.sliders,
    required this.address,
    required this.facebook,
    required this.google,
    required this.twitter,
    required this.qrcode,
    required this.trueRating,
    required this.rating,
  });

  int id;
  String status;
  int userId;
  CatalogMode catalogMode;
  String businessCategory;
  String businessTemplateType;
  String name;
  String logo;
  List<dynamic> sliders;
  String address;
  dynamic facebook;
  dynamic google;
  dynamic twitter;
  String qrcode;
  int trueRating;
  int rating;

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
    id: json["id"],
    status: json["status"],
    userId: json["user_id"],
    catalogMode: CatalogMode.fromJson(json["catalog_mode"]),
    businessCategory: json["business_category"],
    businessTemplateType: json["business_template_type"],
    name: json["name"],
    logo:Url.IMAGE_BASE_URL+ json["logo"],
    sliders: List<dynamic>.from(json["sliders"].map((x) => x)),
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
