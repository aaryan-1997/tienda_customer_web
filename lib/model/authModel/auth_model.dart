class UserModel {
  bool? result;
  String? message;
  bool? isVerified;
  bool? isOtpSent;
  bool? isExist;

  UserModel(
      {this.result,
      this.message,
      this.isVerified,
      this.isOtpSent,
      this.isExist});

  UserModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    isVerified = json['is_verified'];
    isOtpSent = json['is_otp_sent'];
    isExist = json['is_exist'];
  }
}

class AuthModel {
  bool? result;
  String? message;
  String? accessToken;
  String? tokenType;
  String? expiresAt;
  User? user;

  AuthModel(
      {this.result,
      this.message,
      this.accessToken,
      this.tokenType,
      this.expiresAt,
      this.user});

  AuthModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresAt = json['expires_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? type;
  String? name;
  String? email;
  String? avatar;
  String? avatarOriginal;
  String? phone;

  User(
      {this.id,
      this.type,
      this.name,
      this.email,
      this.avatar,
      this.avatarOriginal,
      this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    avatarOriginal = json['avatar_original'];
    phone = json['phone'];
  }
}

class SignUpModel {
  bool? result;
  String? message;
  bool? isVerified;
  bool? isOtpSent;
  bool? isExist;

  SignUpModel(
      {this.result,
      this.message,
      this.isVerified,
      this.isOtpSent,
      this.isExist});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    isVerified = json['is_verified'];
    isOtpSent = json['is_otp_sent'];
    isExist = json['is_exist'];
  }
}
