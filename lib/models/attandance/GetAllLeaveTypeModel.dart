
class GetAllLeaveTypeModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetAllLeaveTypeModel({this.status, this.success, this.data, this.message});

  GetAllLeaveTypeModel.fromJson(Map<String, dynamic> json) {
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
  String? leaveTypeName;
  String? description;
  bool? active;
  String? createdBy;
  String? createdDate;

  Data(
      {this.id,
        this.leaveTypeName,
        this.description,
        this.active,
        this.createdBy,
        this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveTypeName = json['leaveTypeName'];
    description = json['description'];
    active = json['active'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leaveTypeName'] = this.leaveTypeName;
    data['description'] = this.description;
    data['active'] = this.active;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
