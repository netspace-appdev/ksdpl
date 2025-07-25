class GetBankerDetailsByBranchIdModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetBankerDetailsByBranchIdModel(
      {this.status, this.success, this.data, this.message});

  GetBankerDetailsByBranchIdModel.fromJson(Map<String, dynamic> json) {
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
  String? bankersName;
  String? bankersMobileNumber;
  String? bankersWhatsAppNumber;
  String? bankersEmailId;
  int? city;
  String? superiorName;
  String? superiorMobile;
  String? superiorWhatsApp;
  String? superiorEmail;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;

  Data(
      {this.id,
        this.bankId,
        this.branchId,
        this.bankersName,
        this.bankersMobileNumber,
        this.bankersWhatsAppNumber,
        this.bankersEmailId,
        this.city,
        this.superiorName,
        this.superiorMobile,
        this.superiorWhatsApp,
        this.superiorEmail,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankId = json['bankId'];
    branchId = json['branchId'];
    bankersName = json['bankersName'];
    bankersMobileNumber = json['bankersMobileNumber'];
    bankersWhatsAppNumber = json['bankersWhatsAppNumber'];
    bankersEmailId = json['bankersEmailId'];
    city = json['city'];
    superiorName = json['superiorName'];
    superiorMobile = json['superiorMobile'];
    superiorWhatsApp = json['superiorWhatsApp'];
    superiorEmail = json['superiorEmail'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bankId'] = this.bankId;
    data['branchId'] = this.branchId;
    data['bankersName'] = this.bankersName;
    data['bankersMobileNumber'] = this.bankersMobileNumber;
    data['bankersWhatsAppNumber'] = this.bankersWhatsAppNumber;
    data['bankersEmailId'] = this.bankersEmailId;
    data['city'] = this.city;
    data['superiorName'] = this.superiorName;
    data['superiorMobile'] = this.superiorMobile;
    data['superiorWhatsApp'] = this.superiorWhatsApp;
    data['superiorEmail'] = this.superiorEmail;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['updatedBy'] = this.updatedBy;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}
