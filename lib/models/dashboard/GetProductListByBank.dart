class GetProductListByBankModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  GetProductListByBankModel(
      {this.status, this.success, this.data, this.message});

  GetProductListByBankModel.fromJson(Map<String, dynamic> json) {
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
  int? bankId;
  int? loanProductCategoryId;
  String? productCategoryName;
  String? productName;
  String? productDescriptions;
  String? productValidateFromDate;
  String? productValidateToDate;
  int? fromAmount;
  Null? toAmount;
  int? profitPercentage;
  Null? noOfDocument;
  Null? ksdplProductId;
  bool? active;
  String? createdDate;
  String? createdBy;
  String? updatedDate;
  String? updatedBy;
  Null? deletedDate;
  Null? deletedBy;
  String? bankName;
  Null? rateOfInterest;
  Null? ksdpLpercent;

  Data(
      {this.id,
        this.bankId,
        this.loanProductCategoryId,
        this.productCategoryName,
        this.productName,
        this.productDescriptions,
        this.productValidateFromDate,
        this.productValidateToDate,
        this.fromAmount,
        this.toAmount,
        this.profitPercentage,
        this.noOfDocument,
        this.ksdplProductId,
        this.active,
        this.createdDate,
        this.createdBy,
        this.updatedDate,
        this.updatedBy,
        this.deletedDate,
        this.deletedBy,
        this.bankName,
        this.rateOfInterest,
        this.ksdpLpercent});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankId = json['bankId'];
    loanProductCategoryId = json['loanProductCategoryId'];
    productCategoryName = json['productCategoryName'];
    productName = json['productName'];
    productDescriptions = json['productDescriptions'];
    productValidateFromDate = json['productValidateFromDate'];
    productValidateToDate = json['productValidateToDate'];
    fromAmount = json['fromAmount'];
    toAmount = json['toAmount'];
    profitPercentage = json['profitPercentage'];
    noOfDocument = json['noOfDocument'];
    ksdplProductId = json['ksdplProductId'];
    active = json['active'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    updatedDate = json['updatedDate'];
    updatedBy = json['updatedBy'];
    deletedDate = json['deletedDate'];
    deletedBy = json['deletedBy'];
    bankName = json['bankName'];
    rateOfInterest = json['rateOfInterest'];
    ksdpLpercent = json['ksdpLpercent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bankId'] = this.bankId;
    data['loanProductCategoryId'] = this.loanProductCategoryId;
    data['productCategoryName'] = this.productCategoryName;
    data['productName'] = this.productName;
    data['productDescriptions'] = this.productDescriptions;
    data['productValidateFromDate'] = this.productValidateFromDate;
    data['productValidateToDate'] = this.productValidateToDate;
    data['fromAmount'] = this.fromAmount;
    data['toAmount'] = this.toAmount;
    data['profitPercentage'] = this.profitPercentage;
    data['noOfDocument'] = this.noOfDocument;
    data['ksdplProductId'] = this.ksdplProductId;
    data['active'] = this.active;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['updatedDate'] = this.updatedDate;
    data['updatedBy'] = this.updatedBy;
    data['deletedDate'] = this.deletedDate;
    data['deletedBy'] = this.deletedBy;
    data['bankName'] = this.bankName;
    data['rateOfInterest'] = this.rateOfInterest;
    data['ksdpLpercent'] = this.ksdpLpercent;
    return data;
  }
}
