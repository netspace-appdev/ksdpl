class GetAllPackageMasterModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetAllPackageMasterModel(
      {this.status, this.success, this.data, this.message});

  GetAllPackageMasterModel.fromJson(Map<String, dynamic> json) {
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
  String? packageName;
  num? amount;
  bool? active;
  int? createdBy;
  String? createdDate;
  int? updatedBy;
  String? updatedDate;
  List<Services>? services;

  Data(
      {this.id,
        this.packageName,
        this.amount,
        this.active,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
        this.services});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageName = json['packageName'];
    amount = json['amount'];
    active = json['active'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['packageName'] = this.packageName;
    data['amount'] = this.amount;
    data['active'] = this.active;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['updatedBy'] = this.updatedBy;
    data['updatedDate'] = this.updatedDate;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  int? packageId;
  String? serviceName;
  num? amount;

  Services({this.id, this.packageId, this.serviceName, this.amount});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageId = json['packageId'];
    serviceName = json['serviceName'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['packageId'] = this.packageId;
    data['serviceName'] = this.serviceName;
    data['amount'] = this.amount;
    return data;
  }
}
