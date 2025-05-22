class GetDocumentProductIdModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetDocumentProductIdModel(
      {this.status, this.success, this.data, this.message});

  GetDocumentProductIdModel.fromJson(Map<String, dynamic> json) {
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
  int? productId;
  int? bankId;
  int? documentId;
  int? loanProductCategoryId;
  String? productCategoryName;
  String? productName;
  String? documentName;
  String? documentType;
  int? ksdplProductId;
  bool? active;

  Data(
      {this.productId,
        this.bankId,
        this.documentId,
        this.loanProductCategoryId,
        this.productCategoryName,
        this.productName,
        this.documentName,
        this.documentType,
        this.ksdplProductId,
        this.active});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    bankId = json['bankId'];
    documentId = json['documentId'];
    loanProductCategoryId = json['loanProductCategoryId'];
    productCategoryName = json['productCategoryName'];
    productName = json['productName'];
    documentName = json['documentName'];
    documentType = json['documentType'];
    ksdplProductId = json['ksdplProductId'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['bankId'] = this.bankId;
    data['documentId'] = this.documentId;
    data['loanProductCategoryId'] = this.loanProductCategoryId;
    data['productCategoryName'] = this.productCategoryName;
    data['productName'] = this.productName;
    data['documentName'] = this.documentName;
    data['documentType'] = this.documentType;
    data['ksdplProductId'] = this.ksdplProductId;
    data['active'] = this.active;
    return data;
  }
}
