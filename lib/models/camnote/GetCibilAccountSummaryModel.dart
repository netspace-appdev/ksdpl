import 'package:get/get_rx/src/rx_types/rx_types.dart';

class GetCibilAccountSummaryModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;
  RxBool isSelected = false.obs;
  GetCibilAccountSummaryModel(
      {this.status, this.success, this.data, this.message});

  GetCibilAccountSummaryModel.fromJson(Map<String, dynamic> json) {
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
  int? leadId;
  String? seq;
  String? institution;
  String? accountNumber;
  String? accountType;
  String? ownershipType;
  String? accountStatus;
  String? sanctionAmount;
  String? balance;
  String? installmentAmount;
  String? paymentStatusDpd;
  String? pastDueAmount;
  bool? markForForeclosure;
  String? createdDate;
  String? updatedDate;

  Data(
      {this.id,
        this.leadId,
        this.seq,
        this.institution,
        this.accountNumber,
        this.accountType,
        this.ownershipType,
        this.accountStatus,
        this.sanctionAmount,
        this.balance,
        this.installmentAmount,
        this.paymentStatusDpd,
        this.pastDueAmount,
        this.markForForeclosure,
        this.createdDate,
        this.updatedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadId = json['leadId'];
    seq = json['seq'];
    institution = json['institution'];
    accountNumber = json['accountNumber'];
    accountType = json['accountType'];
    ownershipType = json['ownershipType'];
    accountStatus = json['accountStatus'];
    sanctionAmount = json['sanctionAmount'];
    balance = json['balance'];
    installmentAmount = json['installmentAmount'];
    paymentStatusDpd = json['paymentStatusDpd'];
    pastDueAmount = json['pastDueAmount'];
    markForForeclosure = json['markForForeclosure'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leadId'] = this.leadId;
    data['seq'] = this.seq;
    data['institution'] = this.institution;
    data['accountNumber'] = this.accountNumber;
    data['accountType'] = this.accountType;
    data['ownershipType'] = this.ownershipType;
    data['accountStatus'] = this.accountStatus;
    data['sanctionAmount'] = this.sanctionAmount;
    data['balance'] = this.balance;
    data['installmentAmount'] = this.installmentAmount;
    data['paymentStatusDpd'] = this.paymentStatusDpd;
    data['pastDueAmount'] = this.pastDueAmount;
    data['markForForeclosure'] = this.markForForeclosure;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}
