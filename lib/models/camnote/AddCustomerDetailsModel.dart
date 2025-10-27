class AddCustomerDetailsModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  AddCustomerDetailsModel({this.status, this.success, this.data, this.message});

  AddCustomerDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? customerName;
  String? mobileNumber;
  String? email;
  String? gender;
  String? adharCard;
  String? panCard;
  String? streetAddress;
  int? state;
  int? district;
  int? city;
  String? nationality;
  bool? active;
  Null? otp;

  Data(
      {this.id,
        this.customerName,
        this.mobileNumber,
        this.email,
        this.gender,
        this.adharCard,
        this.panCard,
        this.streetAddress,
        this.state,
        this.district,
        this.city,
        this.nationality,
        this.active,
        this.otp});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customerName'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    gender = json['gender'];
    adharCard = json['adharCard'];
    panCard = json['panCard'];
    streetAddress = json['streetAddress'];
    state = json['state'];
    district = json['district'];
    city = json['city'];
    nationality = json['nationality'];
    active = json['active'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerName'] = this.customerName;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['adharCard'] = this.adharCard;
    data['panCard'] = this.panCard;
    data['streetAddress'] = this.streetAddress;
    data['state'] = this.state;
    data['district'] = this.district;
    data['city'] = this.city;
    data['nationality'] = this.nationality;
    data['active'] = this.active;
    data['otp'] = this.otp;
    return data;
  }
}
