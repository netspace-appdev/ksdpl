class GetCustomerCibilDetailModel {
  String? status;
  bool? success;
  List<CibilData>? data;
  String? message;

  GetCustomerCibilDetailModel(
      {this.status, this.success, this.data, this.message});

  GetCustomerCibilDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <CibilData>[];
      json['data'].forEach((v) {
        data!.add(new CibilData.fromJson(v));
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

class CibilData {
  int? id;
  String? name;
  String? mobile;
  num? amount;
  String? receiveDate;
  String? utr;
  String? transactionId;
  String? userId;
  String? filePath;

  CibilData(
      {this.id,
        this.name,
        this.mobile,
        this.amount,
        this.receiveDate,
        this.utr,
        this.transactionId,
        this.userId,
        this.filePath});

  CibilData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    amount = json['amount'];
    receiveDate = json['receiveDate'];
    utr = json['utr'];
    transactionId = json['transactionId'];
    userId = json['userId'];
    filePath = json['filePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['amount'] = this.amount;
    data['receiveDate'] = this.receiveDate;
    data['utr'] = this.utr;
    data['transactionId'] = this.transactionId;
    data['userId'] = this.userId;
    data['filePath'] = this.filePath;
    return data;
  }
}
