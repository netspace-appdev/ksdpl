class GetBankerRoleByLevelAndBankIdModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetBankerRoleByLevelAndBankIdModel(
      {this.status, this.success, this.data, this.message});

  GetBankerRoleByLevelAndBankIdModel.fromJson(Map<String, dynamic> json) {
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
  int? roleLevel;
  String? originalRole;
  String? bankerRole;
  String? shortRole;

  Data(
      {this.id,
        this.bankId,
        this.roleLevel,
        this.originalRole,
        this.bankerRole,
        this.shortRole});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankId = json['bankId'];
    roleLevel = json['roleLevel'];
    originalRole = json['originalRole'];
    bankerRole = json['bankerRole'];
    shortRole = json['shortRole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bankId'] = this.bankId;
    data['roleLevel'] = this.roleLevel;
    data['originalRole'] = this.originalRole;
    data['bankerRole'] = this.bankerRole;
    data['shortRole'] = this.shortRole;
    return data;
  }
}
