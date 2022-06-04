class StateResponseModel {
  List<States>? stateList;
  bool? success;
  int? status;

  StateResponseModel({this.stateList, this.success, this.status});

  StateResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      stateList = <States>[];
      json['data'].forEach((v) {
        stateList!.add(States.fromJson(v));
      });
    }
    success = json['success'];
    status = json['status'];
  }
}

class States {
  int? id;
  int? countryId;
  String? name;

  States({this.id, this.countryId, this.name});

  States.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    name = json['name'];
  }
}
