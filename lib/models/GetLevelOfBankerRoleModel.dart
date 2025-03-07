class GetLevelOfBankerRoleModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetLevelOfBankerRoleModel(
      {this.status, this.success, this.data, this.message});

  GetLevelOfBankerRoleModel.fromJson(Map<String, dynamic> json) {
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
  String? bankRoleLevel1;

  Data({this.id, this.bankRoleLevel1});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankRoleLevel1 = json['bankRoleLevel1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bankRoleLevel1'] = this.bankRoleLevel1;
    return data;
  }
}
