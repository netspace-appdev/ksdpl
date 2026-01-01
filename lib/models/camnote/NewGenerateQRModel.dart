class NewGenerateQRModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  NewGenerateQRModel({this.status, this.success, this.data, this.message});

  NewGenerateQRModel.fromJson(Map<String, dynamic> json) {
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
  int? merchantId;
  String? merchantTranId;
  String? refId;
  String? qrString;
  String? qrImageUrl;
  num? amount;
  String? validityStart;
  String? validityEnd;
  bool? isExistingQR;
  String? messageToUser;

  Data(
      {this.merchantId,
        this.merchantTranId,
        this.refId,
        this.qrString,
        this.qrImageUrl,
        this.amount,
        this.validityStart,
        this.validityEnd,
        this.isExistingQR,
        this.messageToUser});

  Data.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchantId'];
    merchantTranId = json['merchantTranId'];
    refId = json['refId'];
    qrString = json['qrString'];
    qrImageUrl = json['qrImageUrl'];
    amount = json['amount'];
    validityStart = json['validityStart'];
    validityEnd = json['validityEnd'];
    isExistingQR = json['isExistingQR'];
    messageToUser = json['messageToUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchantId'] = this.merchantId;
    data['merchantTranId'] = this.merchantTranId;
    data['refId'] = this.refId;
    data['qrString'] = this.qrString;
    data['qrImageUrl'] = this.qrImageUrl;
    data['amount'] = this.amount;
    data['validityStart'] = this.validityStart;
    data['validityEnd'] = this.validityEnd;
    data['isExistingQR'] = this.isExistingQR;
    data['messageToUser'] = this.messageToUser;
    return data;
  }
}
