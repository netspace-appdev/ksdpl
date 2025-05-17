class GetAllProductCategoryModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetAllProductCategoryModel(
      {this.status, this.success, this.data, this.message});

  GetAllProductCategoryModel.fromJson(Map<String, dynamic> json) {
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
  String? productCategoryName;
  bool? active;
  String? createdDate;
  String? createdBy;
  String? updatedDate;
  String? updatedBy;
  Null? deletedDate;
  Null? deletedBy;

  Data(
      {this.id,
        this.productCategoryName,
        this.active,
        this.createdDate,
        this.createdBy,
        this.updatedDate,
        this.updatedBy,
        this.deletedDate,
        this.deletedBy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productCategoryName = json['productCategoryName'];
    active = json['active'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    updatedDate = json['updatedDate'];
    updatedBy = json['updatedBy'];
    deletedDate = json['deletedDate'];
    deletedBy = json['deletedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productCategoryName'] = this.productCategoryName;
    data['active'] = this.active;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['updatedDate'] = this.updatedDate;
    data['updatedBy'] = this.updatedBy;
    data['deletedDate'] = this.deletedDate;
    data['deletedBy'] = this.deletedBy;
    return data;
  }
}
