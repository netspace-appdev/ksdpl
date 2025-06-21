class AddCibilDetailsModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  AddCibilDetailsModel({this.status, this.success, this.data, this.message});

  AddCibilDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? phoneNo;
  String? aadhar;
  String? pan;
  String? uniqueLeadNo;
  Null? paymentTransactionId;
  String? cibilTransactionId;
  String? pdf;
  String? date;

  Data(
      {this.id,
        this.phoneNo,
        this.aadhar,
        this.pan,
        this.uniqueLeadNo,
        this.paymentTransactionId,
        this.cibilTransactionId,
        this.pdf,
        this.date});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNo = json['phoneNo'];
    aadhar = json['aadhar'];
    pan = json['pan'];
    uniqueLeadNo = json['uniqueLeadNo'];
    paymentTransactionId = json['paymentTransactionId'];
    cibilTransactionId = json['cibilTransactionId'];
    pdf = json['pdf'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phoneNo'] = this.phoneNo;
    data['aadhar'] = this.aadhar;
    data['pan'] = this.pan;
    data['uniqueLeadNo'] = this.uniqueLeadNo;
    data['paymentTransactionId'] = this.paymentTransactionId;
    data['cibilTransactionId'] = this.cibilTransactionId;
    data['pdf'] = this.pdf;
    data['date'] = this.date;
    return data;
  }
}
