class GetPackageDetailsByIdModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetPackageDetailsByIdModel({this.status, this.success, this.data, this.message});

  GetPackageDetailsByIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  int? packageId;
  int? service;
  String? serviceName;
  num? amount;

  Data({this.id, this.packageId, this.service, this.serviceName, this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageId = json['packageId'];
    service = json['service'];
    serviceName = json['serviceName'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['packageId'] = packageId;
    map['service'] = service;
    map['serviceName'] = serviceName;
    map['amount'] = amount;
    return map;
  }

  /// 👇 Checks if the serviceName is "cibil" (case-insensitive)
  bool get isCibilService => serviceName?.toLowerCase().trim() == 'cibil' || serviceName?.toLowerCase().trim() == 'CIBIL ';
}
