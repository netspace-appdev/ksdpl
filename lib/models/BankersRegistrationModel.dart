class BankersRegistrationModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  BankersRegistrationModel(
      {this.status, this.success, this.data, this.message});

  BankersRegistrationModel.fromJson(Map<String, dynamic> json) {
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
  int? bankId;
  int? branchId;
  String? bankerCode;
  String? bankerName;
  String? contactNo;
  String? whatsappNo;
  String? email;
  String? otp;
  String? supervisorName;
  String? supervisorMobileNo;
  String? supervisorEmail;
  String? role;
  bool? active;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? deletedBy;
  String? deletedDate;
  String? privilege;
  String? approvedBy;
  bool? otpVerified;
  String? status;
  bool? authorizationStatus;
  String? shortRole;
  int? levelId;
  String? admSupervisorName;
  String? admSupervisorMobileNo;
  String? admSupervisorEmail;
  int? superiorId;
  int? admSupervisorId;
  bool? otsauthorizationStatus;
  double? fromRange;
  double? toRange;

  Data(
      {this.id,
        this.bankId,
        this.branchId,
        this.bankerCode,
        this.bankerName,
        this.contactNo,
        this.whatsappNo,
        this.email,
        this.otp,
        this.supervisorName,
        this.supervisorMobileNo,
        this.supervisorEmail,
        this.role,
        this.active,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
        this.deletedBy,
        this.deletedDate,
        this.privilege,
        this.approvedBy,
        this.otpVerified,
        this.status,
        this.authorizationStatus,
        this.shortRole,
        this.levelId,
        this.admSupervisorName,
        this.admSupervisorMobileNo,
        this.admSupervisorEmail,
        this.superiorId,
        this.admSupervisorId,
        this.otsauthorizationStatus,
        this.fromRange,
        this.toRange});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    bankId = json['BankId'];
    branchId = json['BranchId'];
    bankerCode = json['BankerCode'];
    bankerName = json['BankerName'];
    contactNo = json['ContactNo'];
    whatsappNo = json['WhatsappNo'];
    email = json['Email'];
    otp = json['Otp'];
    supervisorName = json['SupervisorName'];
    supervisorMobileNo = json['SupervisorMobileNo'];
    supervisorEmail = json['SupervisorEmail'];
    role = json['Role'];
    active = json['Active'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    updatedBy = json['UpdatedBy'];
    updatedDate = json['UpdatedDate'];
    deletedBy = json['DeletedBy'];
    deletedDate = json['DeletedDate'];
    privilege = json['Privilege'];
    approvedBy = json['ApprovedBy'];
    otpVerified = json['OtpVerified'];
    status = json['Status'];
    authorizationStatus = json['AuthorizationStatus'];
    shortRole = json['ShortRole'];
    levelId = json['LevelId'];
    admSupervisorName = json['AdmSupervisorName'];
    admSupervisorMobileNo = json['AdmSupervisorMobileNo'];
    admSupervisorEmail = json['AdmSupervisorEmail'];
    superiorId = json['SuperiorId'];
    admSupervisorId = json['AdmSupervisorId'];
    otsauthorizationStatus = json['OtsauthorizationStatus'];
    fromRange = json['FromRange'];
    toRange = json['ToRange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['BankId'] = this.bankId;
    data['BranchId'] = this.branchId;
    data['BankerCode'] = this.bankerCode;
    data['BankerName'] = this.bankerName;
    data['ContactNo'] = this.contactNo;
    data['WhatsappNo'] = this.whatsappNo;
    data['Email'] = this.email;
    data['Otp'] = this.otp;
    data['SupervisorName'] = this.supervisorName;
    data['SupervisorMobileNo'] = this.supervisorMobileNo;
    data['SupervisorEmail'] = this.supervisorEmail;
    data['Role'] = this.role;
    data['Active'] = this.active;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;
    data['DeletedBy'] = this.deletedBy;
    data['DeletedDate'] = this.deletedDate;
    data['Privilege'] = this.privilege;
    data['ApprovedBy'] = this.approvedBy;
    data['OtpVerified'] = this.otpVerified;
    data['Status'] = this.status;
    data['AuthorizationStatus'] = this.authorizationStatus;
    data['ShortRole'] = this.shortRole;
    data['LevelId'] = this.levelId;
    data['AdmSupervisorName'] = this.admSupervisorName;
    data['AdmSupervisorMobileNo'] = this.admSupervisorMobileNo;
    data['AdmSupervisorEmail'] = this.admSupervisorEmail;
    data['SuperiorId'] = this.superiorId;
    data['AdmSupervisorId'] = this.admSupervisorId;
    data['OtsauthorizationStatus'] = this.otsauthorizationStatus;
    data['FromRange'] = this.fromRange;
    data['ToRange'] = this.toRange;
    return data;
  }
}
