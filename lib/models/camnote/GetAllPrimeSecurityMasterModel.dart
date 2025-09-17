class GetAllPrimeSecurityMasterModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetAllPrimeSecurityMasterModel(
      {this.status, this.success, this.data, this.message});

  GetAllPrimeSecurityMasterModel.fromJson(Map<String, dynamic> json) {
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
  String? description;
  bool? active;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;

  Data(
      {this.id,
        this.description,
        this.active,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    active = json['active'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['active'] = this.active;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['updatedBy'] = this.updatedBy;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}
