class FunctionalSupervisorModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  FunctionalSupervisorModel(
      {this.status, this.success, this.data, this.message});

  FunctionalSupervisorModel.fromJson(Map<String, dynamic> json) {
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
  String? bankerName;
  String? contactNo;
  String? email;
  int? bankId;
  String? shortRole;
  int? level;

  Data(
      {this.id,
        this.bankerName,
        this.contactNo,
        this.email,
        this.bankId,
        this.shortRole,
        this.level});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankerName = json['bankerName'];
    contactNo = json['contactNo'];
    email = json['email'];
    bankId = json['bankId'];
    shortRole = json['shortRole'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bankerName'] = this.bankerName;
    data['contactNo'] = this.contactNo;
    data['email'] = this.email;
    data['bankId'] = this.bankId;
    data['shortRole'] = this.shortRole;
    data['level'] = this.level;
    return data;
  }
}
