class LoginModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  LoginModel({this.status, this.success, this.data, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? phoneNumber;
  List<String>? roles;
  String? token;
  bool? isActive;
  String? normalizedUserName;
  String? normalizedEmail;
  String? passwordHash;
  String? securityStamp;
  String? concurrencyStamp;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.userName,
        this.email,
        this.phoneNumber,
        this.roles,
        this.token,
        this.isActive,
        this.normalizedUserName,
        this.normalizedEmail,
        this.passwordHash,
        this.securityStamp,
        this.concurrencyStamp});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    roles = json['roles'].cast<String>();
    token = json['token'];
    isActive = json['isActive'];
    normalizedUserName = json['normalizedUserName'];
    normalizedEmail = json['normalizedEmail'];
    passwordHash = json['passwordHash'];
    securityStamp = json['securityStamp'];
    concurrencyStamp = json['concurrencyStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['roles'] = this.roles;
    data['token'] = this.token;
    data['isActive'] = this.isActive;
    data['normalizedUserName'] = this.normalizedUserName;
    data['normalizedEmail'] = this.normalizedEmail;
    data['passwordHash'] = this.passwordHash;
    data['securityStamp'] = this.securityStamp;
    data['concurrencyStamp'] = this.concurrencyStamp;
    return data;
  }
}
