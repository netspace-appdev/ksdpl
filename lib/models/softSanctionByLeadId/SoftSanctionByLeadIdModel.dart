class SoftSanctionByLeadIdModel {
  String? status;
  bool? success;
  List<SoftSanctionData>? data;
  String? message;

  SoftSanctionByLeadIdModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  SoftSanctionByLeadIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <SoftSanctionData>[];
      json['data'].forEach((v) {
        data!.add(SoftSanctionData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['status'] = status;
    map['success'] = success;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }
}

class SoftSanctionData {
  int? bankId;
  String? bankName;
  double? amount;

  SoftSanctionData({
    this.bankId,
    this.bankName,
    this.amount,
  });

  SoftSanctionData.fromJson(Map<String, dynamic> json) {
    bankId = json['bankId'];
    bankName = json['bankName'];
    amount = json['amount']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['bankId'] = bankId;
    map['bankName'] = bankName;
    map['amount'] = amount;
    return map;
  }
}
