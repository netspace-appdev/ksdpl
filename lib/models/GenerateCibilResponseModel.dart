class GenerateCibilResponseModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  GenerateCibilResponseModel(
      {this.status, this.success, this.data, this.message});

  GenerateCibilResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? code;
  int? timestamp;
  String? transactionId;
  String? subCode;
  String? message;
  CibilData? cibilData;

  Data(
      {this.code,
        this.timestamp,
        this.transactionId,
        this.subCode,
        this.message,
        this.cibilData});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    timestamp = json['timestamp'];
    transactionId = json['transaction_id'];
    subCode = json['sub_code'];
    message = json['message'];
    cibilData = json['data'] != null ? new CibilData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['timestamp'] = this.timestamp;
    data['transaction_id'] = this.transactionId;
    data['sub_code'] = this.subCode;
    data['message'] = this.message;
    if (this.cibilData != null) {
      data['data'] = this.cibilData!.toJson();
    }
    return data;
  }
}

class CibilData {
  String? redirectUrl;

  CibilData({this.redirectUrl});

  CibilData.fromJson(Map<String, dynamic> json) {
    redirectUrl = json['redirect_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['redirect_url'] = this.redirectUrl;
    return data;
  }
}
