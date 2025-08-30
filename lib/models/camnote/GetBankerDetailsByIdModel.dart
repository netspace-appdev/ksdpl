
class GetBankerDetailsByIdModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  GetBankerDetailsByIdModel(
      {this.status, this.success, this.data, this.message});

  GetBankerDetailsByIdModel.fromJson(Map<String, dynamic> json) {
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
  String? bankName;
  int? branchId;
  String? branchName;
  String? bankersName;
  String? bankersMobileNumber;
  String? bankersWhatsAppNumber;
  String? bankersEmailId;
  int? city;
  Null? cityName;
  String? superiorName;
  String? superiorMobile;
  String? superiorWhatsApp;
  String? superiorEmail;

  Data(
      {this.id,
        this.bankId,
        this.bankName,
        this.branchId,
        this.branchName,
        this.bankersName,
        this.bankersMobileNumber,
        this.bankersWhatsAppNumber,
        this.bankersEmailId,
        this.city,
        this.cityName,
        this.superiorName,
        this.superiorMobile,
        this.superiorWhatsApp,
        this.superiorEmail});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankId = json['bankId'];
    bankName = json['bankName'];
    branchId = json['branchId'];
    branchName = json['branchName'];
    bankersName = json['bankersName'];
    bankersMobileNumber = json['bankersMobileNumber'];

    bankersWhatsAppNumber = json['bankersWhatsAppNumber'];
    bankersEmailId = json['bankersEmailId'];
    city = json['city'];
    cityName = json['cityName'];
    superiorName = json['superiorName'];
    superiorMobile = json['superiorMobile'];
    superiorWhatsApp = json['superiorWhatsApp'];
    superiorEmail = json['superiorEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bankId'] = this.bankId;
    data['bankName'] = this.bankName;
    data['branchId'] = this.branchId;
    data['branchName'] = this.branchName;
    data['bankersName'] = this.bankersName;
    data['bankersMobileNumber'] = this.bankersMobileNumber;
    data['bankersWhatsAppNumber'] = this.bankersWhatsAppNumber;
    data['bankersEmailId'] = this.bankersEmailId;
    data['city'] = this.city;
    data['cityName'] = this.cityName;
    data['superiorName'] = this.superiorName;
    data['superiorMobile'] = this.superiorMobile;
    data['superiorWhatsApp'] = this.superiorWhatsApp;
    data['superiorEmail'] = this.superiorEmail;
    return data;
  }
}
