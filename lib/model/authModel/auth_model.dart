
class CheckAuthModel {
  CheckAuthModel({
    required this.result,
    required this.message,
    required this.isExist,
    required this.isVerified,
    required this.isOtpSent,
  });

  bool result;
  String message;
  bool isExist;
  bool isVerified;
  bool isOtpSent;

  factory CheckAuthModel.fromJson(Map<String, dynamic> json) => CheckAuthModel(
    result: json["result"],
    message: json["message"],
    isExist: json["is_exist"],
    isVerified: json["is_verified"],
    isOtpSent: json["is_otp_sent"],
  );

}

class AuthUserModel {
  AuthUserModel({
    required this.result,
    required this.message,
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  bool result;
  String message;
  String accessToken;
  String tokenType;
  User user;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) => AuthUserModel(
    result: json["result"],
    message: json["message"],
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    user: User.fromJson(json["user"]),
  );

}

class User {
  User({
    required this.id,
    required this.type,
    required this.name,
    required this.phone,
  });

  int id;
  String type;
  String name;
  String phone;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    type: json["type"],
    name: json["name"],
    phone: json["phone"],
  );

}
