class CategoryResponse {
  List<Category>? category;
  bool? success;
  String? message;

  CategoryResponse({this.category, this.success, this.message});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      category = <Category>[];
      json['data'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }
}

class Category {
  int? id;
  String? name;
  String? banner;
  String? icon;
  int? numberOfChildren;
  int? numberOfItem;
  Links? links;

  Category(
      {this.id,
      this.name,
      this.banner,
      this.icon,
      this.numberOfChildren,
      this.numberOfItem,
      this.links});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    banner = json['banner'];
    icon = json['icon'];
    numberOfChildren = json['number_of_children'];
    numberOfItem = json['number_of_item'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
}

class Links {
  String? products;
  String? subCategories;

  Links({this.products, this.subCategories});

  Links.fromJson(Map<String, dynamic> json) {
    products = json['products'];
    subCategories = json['sub_categories'];
  }
}
