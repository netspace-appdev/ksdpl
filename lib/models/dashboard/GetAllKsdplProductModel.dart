class GetAllKsdplProductModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetAllKsdplProductModel({this.status, this.success, this.data, this.message});

  GetAllKsdplProductModel.fromJson(Map<String, dynamic> json) {
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
  String? productName;
  bool? active;
  String? createdBy;
  String? createdDate;
  Null? deletedBy;
  Null? deletedDate;

  Data(
      {this.id,
        this.productName,
        this.active,
        this.createdBy,
        this.createdDate,
        this.deletedBy,
        this.deletedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['productName'];
    active = json['active'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    deletedBy = json['deletedBy'];
    deletedDate = json['deletedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productName'] = this.productName;
    data['active'] = this.active;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['deletedBy'] = this.deletedBy;
    data['deletedDate'] = this.deletedDate;
    return data;
  }
}
