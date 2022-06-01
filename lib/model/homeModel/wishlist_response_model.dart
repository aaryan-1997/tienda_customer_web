import 'package:tiendaweb/model/homeModel/product_response.dart';

class WishlistResponseModel {
  List<WishlistProduct>? wishlistProduct;
  bool? result;
  String? message;

  WishlistResponseModel({this.wishlistProduct, this.result, this.message});

  WishlistResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      wishlistProduct = <WishlistProduct>[];
      json['data'].forEach((v) {
        wishlistProduct!.add(WishlistProduct.fromJson(v));
      });
    }
    result = json['result'];
    message = json['message'];
  }
}

class WishlistProduct {
  int? id;
  Product? product;

  WishlistProduct({this.id, this.product});

  WishlistProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}
