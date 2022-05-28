class ProductResponse {
  List<Product>? product;
  bool? success;
  String? message;

  ProductResponse({this.product, this.success, this.message});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      product = <Product>[];
      json['data'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }
}

class Product {
  int? id;
  String? name;
  String? thumbnailImage;
  String? basePrice;
  int? baseDiscountedPrice;
  int? todaysDeal;
  int? featured;
  String? unit;
  String? strokedPrice;
  String? mainPrice;
  bool? hasDiscount;
  bool? isAvailableWishlist;
  int? rating;
  int? sales;
  Links? links;

  Product(
      {this.id,
      this.name,
      this.thumbnailImage,
      this.basePrice,
      this.baseDiscountedPrice,
      this.todaysDeal,
      this.strokedPrice,
      this.featured,
      this.mainPrice,
      this.hasDiscount,
      this.unit,
      this.rating,
      this.isAvailableWishlist,
      this.sales,
      this.links});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnailImage = json['thumbnail_image'];
    basePrice = json['base_price'].toString();
    baseDiscountedPrice = json['base_discounted_price'];
    todaysDeal = json['todays_deal'];
    featured = json['featured'];
    unit = json['unit'];
    rating = json['rating'];

    hasDiscount = json['has_discount'];
    strokedPrice = json['stroked_price'];
    mainPrice = json['main_price'];
    isAvailableWishlist = json['is_available_wishlist'];

    sales = json['sales'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
}

class Links {
  String? details;
  String? reviews;
  String? related;

  Links({this.details, this.reviews, this.related});

  Links.fromJson(Map<String, dynamic> json) {
    details = json['details'];
    reviews = json['reviews'];
    related = json['related'];
  }
}
