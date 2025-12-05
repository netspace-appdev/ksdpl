class GetAllStateModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetAllStateModel({this.status, this.success, this.data, this.message});

  GetAllStateModel.fromJson(Map<String, dynamic> json) {
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
  bool? active;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? deletedBy;
  String? deletedDate;
  String? language;

  Data(
      {this.id,
        this.stateName,
        this.active,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
        this.deletedBy,
        this.deletedDate,
        this.language});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateName = json['stateName'];
    active = json['active'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    deletedBy = json['deletedBy'];
    deletedDate = json['deletedDate'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stateName'] = this.stateName;
    data['active'] = this.active;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['updatedBy'] = this.updatedBy;
    data['updatedDate'] = this.updatedDate;
    data['deletedBy'] = this.deletedBy;
    data['deletedDate'] = this.deletedDate;
    data['language'] = this.language;
    return data;
  }
}
