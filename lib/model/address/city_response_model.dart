
class CityResponseModel {
  List<City>? cityList;
  bool? success;
  int? status;

  CityResponseModel({this.cityList, this.success, this.status});

  CityResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      cityList = <City>[];
      json['data'].forEach((v) {
        cityList!.add(City.fromJson(v));
      });
    }
    success = json['success'];
    status = json['status'];
  }
}

class City {
  int? id;
  int? stateId;
  String? name;
  int? cost;

  City({this.id, this.stateId, this.name, this.cost});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateId = json['state_id'];
    name = json['name'];
    cost = json['cost'];
  }
}

