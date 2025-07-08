class FetchBankDetailSegKSDPLProdModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  FetchBankDetailSegKSDPLProdModel(
      {this.status, this.success, this.data, this.message});

  FetchBankDetailSegKSDPLProdModel.fromJson(Map<String, dynamic> json) {
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
  int? bankId;
  String? bankName;

  Data({this.bankId, this.bankName});

  Data.fromJson(Map<String, dynamic> json) {
    bankId = json['bankId'];
    bankName = json['bankName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankId'] = this.bankId;
    data['bankName'] = this.bankName;
    return data;
  }
}
