class GetEmployeeModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  GetEmployeeModel({this.status, this.success, this.data, this.message});

  GetEmployeeModel.fromJson(Map<String, dynamic> json) {
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
  int? branchId;
  String? employeeName;
  String? gender;
  String? dateOfBirth;
  String? email;
  String? phoneNumber;
  String? whatsappNumber;
  String? hireDate;
  String? jobRole;
  String? workPlace;
  int? managerId;
  String? address;
  int? state;
  int? district;
  int? city;
  String? postalCode;
  bool? active;
  String? createdBy;
  String? createdDate;
  String? upatedBy;
  String? updatedDate;
  Null? deletedBy;
  Null? deletedDate;

  Data(
      {this.id,
        this.branchId,
        this.employeeName,
        this.gender,
        this.dateOfBirth,
        this.email,
        this.phoneNumber,
        this.whatsappNumber,
        this.hireDate,
        this.jobRole,
        this.workPlace,
        this.managerId,
        this.address,
        this.state,
        this.district,
        this.city,
        this.postalCode,
        this.active,
        this.createdBy,
        this.createdDate,
        this.upatedBy,
        this.updatedDate,
        this.deletedBy,
        this.deletedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branchId'];
    employeeName = json['employeeName'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    whatsappNumber = json['whatsappNumber'];
    hireDate = json['hireDate'];
    jobRole = json['jobRole'];
    workPlace = json['workPlace'];
    managerId = json['managerId'];
    address = json['address'];
    state = json['state'];
    district = json['district'];
    city = json['city'];
    postalCode = json['postalCode'];
    active = json['active'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    upatedBy = json['upatedBy'];
    updatedDate = json['updatedDate'];
    deletedBy = json['deletedBy'];
    deletedDate = json['deletedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branchId'] = this.branchId;
    data['employeeName'] = this.employeeName;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['whatsappNumber'] = this.whatsappNumber;
    data['hireDate'] = this.hireDate;
    data['jobRole'] = this.jobRole;
    data['workPlace'] = this.workPlace;
    data['managerId'] = this.managerId;
    data['address'] = this.address;
    data['state'] = this.state;
    data['district'] = this.district;
    data['city'] = this.city;
    data['postalCode'] = this.postalCode;
    data['active'] = this.active;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['upatedBy'] = this.upatedBy;
    data['updatedDate'] = this.updatedDate;
    data['deletedBy'] = this.deletedBy;
    data['deletedDate'] = this.deletedDate;
    return data;
  }
}
