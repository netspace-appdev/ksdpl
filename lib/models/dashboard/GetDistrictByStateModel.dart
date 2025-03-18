class GetDistrictByStateModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetDistrictByStateModel({this.status, this.success, this.data, this.message});

  GetDistrictByStateModel.fromJson(Map<String, dynamic> json) {
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
  bool? active;
  String? language;
  int? stateId;

  Data(
      {this.id,
        this.stateName,
        this.districtName,
        this.active,
        this.language,
        this.stateId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateName = json['stateName'];
    districtName = json['districtName'];
    active = json['active'];
    language = json['language'];
    stateId = json['stateId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stateName'] = this.stateName;
    data['districtName'] = this.districtName;
    data['active'] = this.active;
    data['language'] = this.language;
    data['stateId'] = this.stateId;
    return data;
  }
}
