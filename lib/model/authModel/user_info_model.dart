class UserDetailModel {
  UserDetails? userDetails;
  bool? success;
  String? message;

  UserDetailModel({this.userDetails, this.success, this.message});

  UserDetailModel.fromJson(Map<String, dynamic> json) {
    userDetails =
        json['data'] != null ? UserDetails.fromJson(json['data']) : null;
    success = json['success'];
    message = json['message'];
  }
}

class UserDetails {
  int? id;
  String? name;
  String? type;
  String? email;
  String? avatar;
  String? avatarOriginal;
  String? address;
  String? city;
  String? country;
  String? postalCode;
  String? phone;

  UserDetails(
      {this.id,
      this.name,
      this.type,
      this.email,
      this.avatar,
      this.avatarOriginal,
      this.address,
      this.city,
      this.country,
      this.postalCode,
      this.phone});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    email = json['email'];
    avatar = json['avatar'];
    avatarOriginal = json['avatar_original'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    postalCode = json['postal_code'];
    phone = json['phone'];
  }
}
