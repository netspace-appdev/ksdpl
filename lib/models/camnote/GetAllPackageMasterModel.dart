

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
  num? createdBy;
  String? createdDate;
  num? updatedBy;
  String? updatedDate;
  String? qRImage;
  int? noOfBank;
  List<PackageDetails>? packageDetails;

  Data(
      {this.id,
        this.packageName,
        this.amount,
        this.active,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
        this.qRImage,
        this.noOfBank,
        this.packageDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageName = json['packageName'];
    amount = json['amount'];
    active = json['active'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    qRImage = json['qR_Image'];
    noOfBank = json['noOfBank'];
    if (json['packageDetails'] != null) {
      packageDetails = <PackageDetails>[];
      json['packageDetails'].forEach((v) {
        packageDetails!.add(new PackageDetails.fromJson(v));
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
    data['qR_Image'] = this.qRImage;
    data['noOfBank'] = this.noOfBank;
    if (this.packageDetails != null) {
      data['packageDetails'] =
          this.packageDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PackageDetails {
  int? id;
  int? packageId;
  num? service;
  String? serviceName;
  num? amount;

  PackageDetails(
      {this.id, this.packageId, this.service, this.serviceName, this.amount});

  PackageDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageId = json['packageId'];
    service = json['service'];
    serviceName = json['serviceName'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['packageId'] = this.packageId;
    data['service'] = this.service;
    data['serviceName'] = this.serviceName;
    data['amount'] = this.amount;
    return data;
  }
}
