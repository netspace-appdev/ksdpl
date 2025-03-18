class   GetCityByDistrictIdModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetCityByDistrictIdModel(
      {this.status, this.success, this.data, this.message});

  GetCityByDistrictIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? stateName;
  String? districtName;
  String? cityName;
  bool? active;
  String? language;
  int? stateId;
  int? districtId;

  Data(
      {this.id,
        this.stateName,
        this.districtName,
        this.cityName,
        this.active,
        this.language,
        this.stateId,
        this.districtId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateName = json['stateName'];
    districtName = json['districtName'];
    cityName = json['cityName'];
    active = json['active'];
    language = json['language'];
    stateId = json['stateId'];
    districtId = json['districtId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stateName'] = this.stateName;
    data['districtName'] = this.districtName;
    data['cityName'] = this.cityName;
    data['active'] = this.active;
    data['language'] = this.language;
    data['stateId'] = this.stateId;
    data['districtId'] = this.districtId;
    return data;
  }
}
