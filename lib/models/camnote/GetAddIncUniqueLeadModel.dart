class GetAddIncUniqueLeadModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetAddIncUniqueLeadModel(
      {this.status, this.success, this.data, this.message});

  GetAddIncUniqueLeadModel.fromJson(Map<String, dynamic> json) {
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
  String? uniqueLeadNumber;
  String? description;
  num? amount;

  Data({this.id, this.uniqueLeadNumber, this.description, this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueLeadNumber = json['uniqueLeadNumber'];
    description = json['description'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uniqueLeadNumber'] = this.uniqueLeadNumber;
    data['description'] = this.description;
    data['amount'] = this.amount;
    return data;
  }
}
