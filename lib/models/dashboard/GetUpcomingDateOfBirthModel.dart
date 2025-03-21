class GetUpcomingDateOfBirthModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetUpcomingDateOfBirthModel(
      {this.status, this.success, this.data, this.message});

  GetUpcomingDateOfBirthModel.fromJson(Map<String, dynamic> json) {
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
  String? employeeName;
  String? dateOfBirth;
  String? email;
  String? phoneNumber;

  Data({this.employeeName, this.dateOfBirth, this.email, this.phoneNumber});

  Data.fromJson(Map<String, dynamic> json) {
    employeeName = json['employeeName'];
    dateOfBirth = json['dateOfBirth'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeName'] = this.employeeName;
    data['dateOfBirth'] = this.dateOfBirth;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
