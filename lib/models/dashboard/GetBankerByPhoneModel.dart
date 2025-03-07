class GetBankerByPhoneModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  GetBankerByPhoneModel({this.status, this.success, this.data, this.message});

  GetBankerByPhoneModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  int? bankId;
  int? branchId;
  String? bankName;
  String? branchName;
  String? bankerCode;
  String? bankerName;
  String? contactNo;
  String? whatsappNo;
  String? email;
  String? supervisorName;
  String? supervisorMobileNo;
  String? supervisorEmail;
  String? role;
  bool? active;
  String? status;
  bool? authorizationStatus;
  int? levelId;
  bool? otsAuthorizationStatus;
  double? fromRange;
  double? toRange;

  Data(
      {this.id,
        this.bankId,
        this.branchId,
        this.bankName,
        this.branchName,
        this.bankerCode,
        this.bankerName,
        this.contactNo,
        this.whatsappNo,
        this.email,
        this.supervisorName,
        this.supervisorMobileNo,
        this.supervisorEmail,
        this.role,
        this.active,
        this.status,
        this.authorizationStatus,
        this.levelId,
        this.otsAuthorizationStatus,
        this.fromRange,
        this.toRange});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankId = json['bankId'];
    branchId = json['branchId'];
    bankName = json['bankName'];
    branchName = json['branchName'];
    bankerCode = json['bankerCode'];
    bankerName = json['bankerName'];
    contactNo = json['contactNo'];
    whatsappNo = json['whatsappNo'];
    email = json['email'];
    supervisorName = json['supervisorName'];
    supervisorMobileNo = json['supervisorMobileNo'];
    supervisorEmail = json['supervisorEmail'];
    role = json['role'];
    active = json['active'];
    status = json['status'];
    authorizationStatus = json['authorizationStatus'];
    levelId = json['levelId'];
    otsAuthorizationStatus = json['otsAuthorizationStatus'];
    fromRange = json['fromRange'];
    toRange = json['toRange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bankId'] = this.bankId;
    data['branchId'] = this.branchId;
    data['bankName'] = this.bankName;
    data['branchName'] = this.branchName;
    data['bankerCode'] = this.bankerCode;
    data['bankerName'] = this.bankerName;
    data['contactNo'] = this.contactNo;
    data['whatsappNo'] = this.whatsappNo;
    data['email'] = this.email;
    data['supervisorName'] = this.supervisorName;
    data['supervisorMobileNo'] = this.supervisorMobileNo;
    data['supervisorEmail'] = this.supervisorEmail;
    data['role'] = this.role;
    data['active'] = this.active;
    data['status'] = this.status;
    data['authorizationStatus'] = this.authorizationStatus;
    data['levelId'] = this.levelId;
    data['otsAuthorizationStatus'] = this.otsAuthorizationStatus;
    data['fromRange'] = this.fromRange;
    data['toRange'] = this.toRange;
    return data;
  }
}
