class GetBranchDistrictByZipBankModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetBranchDistrictByZipBankModel(
      {this.status, this.success, this.data, this.message});

  GetBranchDistrictByZipBankModel.fromJson(Map<String, dynamic> json) {
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
  String? branchName;
  String? branchAddress;
  int? bankId;
  int? stateId;
  int? districtId;
  int? cityId;
  String? zipCode;
  String? branchPhoneNo;
  String? email;
  String? ifsc;
  String? micrCode;
  String? branchCode;
  bool? active;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  Null? deletedBy;
  Null? deletedDate;

  Data(
      {this.id,
        this.branchName,
        this.branchAddress,
        this.bankId,
        this.stateId,
        this.districtId,
        this.cityId,
        this.zipCode,
        this.branchPhoneNo,
        this.email,
        this.ifsc,
        this.micrCode,
        this.branchCode,
        this.active,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
        this.deletedBy,
        this.deletedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchName = json['branchName'];
    branchAddress = json['branchAddress'];
    bankId = json['bankId'];
    stateId = json['stateId'];
    districtId = json['districtId'];
    cityId = json['cityId'];
    zipCode = json['zipCode'];
    branchPhoneNo = json['branchPhoneNo'];
    email = json['email'];
    ifsc = json['ifsc'];
    micrCode = json['micrCode'];
    branchCode = json['branchCode'];
    active = json['active'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    deletedBy = json['deletedBy'];
    deletedDate = json['deletedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branchName'] = this.branchName;
    data['branchAddress'] = this.branchAddress;
    data['bankId'] = this.bankId;
    data['stateId'] = this.stateId;
    data['districtId'] = this.districtId;
    data['cityId'] = this.cityId;
    data['zipCode'] = this.zipCode;
    data['branchPhoneNo'] = this.branchPhoneNo;
    data['email'] = this.email;
    data['ifsc'] = this.ifsc;
    data['micrCode'] = this.micrCode;
    data['branchCode'] = this.branchCode;
    data['active'] = this.active;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['updatedBy'] = this.updatedBy;
    data['updatedDate'] = this.updatedDate;
    data['deletedBy'] = this.deletedBy;
    data['deletedDate'] = this.deletedDate;
    return data;
  }
}
