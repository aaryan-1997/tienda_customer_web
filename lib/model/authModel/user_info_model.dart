
class UserInfoModel {
  UserInfoModel({
    required this.id,
    required this.name,
    required this.type,
    required this.email,
    required this.avatar,
    required this.avatarOriginal,
    required this.address,
    required this.city,
    required this.country,
    required this.postalCode,
    required this.phone,
  });

  int id;
  String name;
  String type;
  String email;
  String avatar;
  String avatarOriginal;
  String address;
  String city;
  String country;
  String postalCode;
  String phone;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    id: json["id"],
    name: (json["name"]==null)?'':json["name"].toString(),
    type:  (json["type"]==null)?'':json["type"].toString(),
    email: (json["email"]==null)?'': json["email"].toString(),
    avatar:  (json["avatar"]==null)?'':json["avatar"].toString(),
    avatarOriginal:  (json["avatar_original"]==null)?'':json["avatar_original"].toString(),
    address:  (json["address"]==null)?'':json["address"].toString(),
    city:  (json["city"]==null)?'':json["city"].toString(),
    country:  (json["country"]==null)?'':json["country"].toString(),
    postalCode:  (json["postal_code"]==null)?'':json["postal_code"].toString(),
    phone:  (json["phone"]==null)?'':json["phone"].toString(),
  );


}
