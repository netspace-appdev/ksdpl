class UpdateFCMTokenModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  UpdateFCMTokenModel({this.status, this.success, this.data, this.message});

  UpdateFCMTokenModel.fromJson(Map<String, dynamic> json) {
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
  Null? branchId;
  Null? branchName;
  String? employeeName;
  Null? managerName;
  Null? gender;
  Null? dateOfBirth;
  Null? email;
  String? phoneNumber;
  Null? whatsappNumber;
  Null? hireDate;
  Null? jobRole;
  Null? workPlace;
  Null? managerID;
  Null? address;
  Null? state;
  Null? district;
  Null? city;
  Null? postalCode;
  Null? active;
  Null? createdBy;
  Null? createdDate;
  Null? stateName;
  Null? districtName;
  Null? cityName;
  Null? image;
  Null? addressAsPerAddhar;
  Null? aadharNumber;
  String? deviceID;
  String? fcmToken;

  Data(
      {this.id,
        this.branchId,
        this.branchName,
        this.employeeName,
        this.managerName,
        this.gender,
        this.dateOfBirth,
        this.email,
        this.phoneNumber,
        this.whatsappNumber,
        this.hireDate,
        this.jobRole,
        this.workPlace,
        this.managerID,
        this.address,
        this.state,
        this.district,
        this.city,
        this.postalCode,
        this.active,
        this.createdBy,
        this.createdDate,
        this.stateName,
        this.districtName,
        this.cityName,
        this.image,
        this.addressAsPerAddhar,
        this.aadharNumber,
        this.deviceID,
        this.fcmToken});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branchId'];
    branchName = json['branchName'];
    employeeName = json['employeeName'];
    managerName = json['managerName'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    whatsappNumber = json['whatsappNumber'];
    hireDate = json['hireDate'];
    jobRole = json['jobRole'];
    workPlace = json['workPlace'];
    managerID = json['managerID'];
    address = json['address'];
    state = json['state'];
    district = json['district'];
    city = json['city'];
    postalCode = json['postalCode'];
    active = json['active'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    stateName = json['stateName'];
    districtName = json['districtName'];
    cityName = json['cityName'];
    image = json['image'];
    addressAsPerAddhar = json['addressAsPerAddhar'];
    aadharNumber = json['aadharNumber'];
    deviceID = json['deviceID'];
    fcmToken = json['fcmToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branchId'] = this.branchId;
    data['branchName'] = this.branchName;
    data['employeeName'] = this.employeeName;
    data['managerName'] = this.managerName;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['whatsappNumber'] = this.whatsappNumber;
    data['hireDate'] = this.hireDate;
    data['jobRole'] = this.jobRole;
    data['workPlace'] = this.workPlace;
    data['managerID'] = this.managerID;
    data['address'] = this.address;
    data['state'] = this.state;
    data['district'] = this.district;
    data['city'] = this.city;
    data['postalCode'] = this.postalCode;
    data['active'] = this.active;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['stateName'] = this.stateName;
    data['districtName'] = this.districtName;
    data['cityName'] = this.cityName;
    data['image'] = this.image;
    data['addressAsPerAddhar'] = this.addressAsPerAddhar;
    data['aadharNumber'] = this.aadharNumber;
    data['deviceID'] = this.deviceID;
    data['fcmToken'] = this.fcmToken;
    return data;
  }
}
