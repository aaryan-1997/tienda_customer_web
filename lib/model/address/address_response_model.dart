
class AddressResponseModel {
  List<Address>? addressLIst;
  bool? success;
  int? status;

  AddressResponseModel({this.addressLIst, this.success, this.status});

  AddressResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      addressLIst = <Address>[];
      json['data'].forEach((v) {
        addressLIst!.add(Address.fromJson(v));
      });
    }
    success = json['success'];
    status = json['status'];
  }
}

class Address {
  int? id;
  int? userId;
  String? address;
  int? countryId;
  int? stateId;
  int? cityId;
  String? stateName;
  String? cityName;
  String? postalCode;
  String? phone;
  int? setDefault;
  bool? locationAvailable;
  double? lat;
  double? lang;

  Address(
      {this.id,
      this.userId,
      this.address,
      this.countryId,
      this.stateId,
      this.cityId,
      this.stateName,
      this.cityName,
      this.postalCode,
      this.phone,
      this.setDefault,
      this.locationAvailable,
      this.lat,
      this.lang});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    address = json['address'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    stateName = json['state_name'];
    cityName = json['city_name'];
    postalCode = json['postal_code'];
    phone = json['phone'];
    setDefault = json['set_default'];
    locationAvailable = json['location_available'];
    lat = json['lat'];
    lang = json['lang'];
  }
}
