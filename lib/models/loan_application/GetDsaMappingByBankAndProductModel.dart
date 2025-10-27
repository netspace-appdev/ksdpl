
class GetDsaMappingByBankAndProductModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetDsaMappingByBankAndProductModel(
      {this.status, this.success, this.data, this.message});

  GetDsaMappingByBankAndProductModel.fromJson(Map<String, dynamic> json) {
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
  String? firmNameWithCode;

  Data({this.id, this.firmNameWithCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firmNameWithCode = json['firmNameWithCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firmNameWithCode'] = this.firmNameWithCode;
    return data;
  }
}
