/*
class GetLoanApplIdModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  GetLoanApplIdModel({this.status, this.success, this.data, this.message});

  GetLoanApplIdModel.fromJson(Map<String, dynamic> json) {
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
  String? dsaCode;
  String? loanApplicationNo;
  int? bankId;
  int? branchId;
  int? typeOfLoan;
  num? loanAmountApplied;
  String? detailForLoanApplication;
  String? addharCardNumber;
  String? panCardNumber;
  String? uniqueLeadNumber;
  String? coApplicantDetail;
  String? loanDetails;
  String? familyMembers;
  String? creditCards;
  String? financialDetails;
  String? referenceDetails;
  int? channelId;
  String? channelCode;

  Data(
      {this.id,
        this.dsaCode,
        this.loanApplicationNo,
        this.bankId,
        this.branchId,
        this.typeOfLoan,
        this.loanAmountApplied,
        this.detailForLoanApplication,
        this.addharCardNumber,
        this.panCardNumber,
        this.uniqueLeadNumber,
        this.coApplicantDetail,
        this.loanDetails,
        this.familyMembers,
        this.creditCards,
        this.financialDetails,
        this.referenceDetails,
        this.channelId,
        this.channelCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dsaCode = json['dsaCode'];
    loanApplicationNo = json['loanApplicationNo'];
    bankId = json['bankId'];
    branchId = json['branchId'];
    typeOfLoan = json['typeOfLoan'];
    loanAmountApplied = json['loanAmountApplied'];
    detailForLoanApplication = json['detailForLoanApplication'];
    addharCardNumber = json['addharCardNumber'];
    panCardNumber = json['panCardNumber'];
    uniqueLeadNumber = json['uniqueLeadNumber'];
    coApplicantDetail = json['coApplicantDetail'];
    loanDetails = json['loanDetails'];
    familyMembers = json['familyMembers'];
    creditCards = json['creditCards'];
    financialDetails = json['financialDetails'];
    referenceDetails = json['referenceDetails'];
    channelId = json['channelId'];
    channelCode = json['channelCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dsaCode'] = this.dsaCode;
    data['loanApplicationNo'] = this.loanApplicationNo;
    data['bankId'] = this.bankId;
    data['branchId'] = this.branchId;
    data['typeOfLoan'] = this.typeOfLoan;
    data['loanAmountApplied'] = this.loanAmountApplied;
    data['detailForLoanApplication'] = this.detailForLoanApplication;
    data['addharCardNumber'] = this.addharCardNumber;
    data['panCardNumber'] = this.panCardNumber;
    data['uniqueLeadNumber'] = this.uniqueLeadNumber;
    data['coApplicantDetail'] = this.coApplicantDetail;
    data['loanDetails'] = this.loanDetails;
    data['familyMembers'] = this.familyMembers;
    data['creditCards'] = this.creditCards;
    data['financialDetails'] = this.financialDetails;
    data['referenceDetails'] = this.referenceDetails;
    data['channelId'] = this.channelId;
    data['channelCode'] = this.channelCode;
    return data;
  }
}
*/

class GetLoanApplIdModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  GetLoanApplIdModel({this.status, this.success, this.data, this.message});

  GetLoanApplIdModel.fromJson(Map<String, dynamic> json) {
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
  String? dsaCode;
  String? loanApplicationNo;
  int? bankId;
  int? branchId;
  int? typeOfLoan;
  num? loanAmountApplied;
  String? detailForLoanApplication;
  String? addharCardNumber;
  String? panCardNumber;
  String? uniqueLeadNumber;
  String? coApplicantDetail;
  String? loanDetails;
  String? familyMembers;
  String? creditCards;
  String? financialDetails;
  String? referenceDetails;
  int? channelId;
  String? channelCode;
  String? bankerName;
  String? bankerMobile;
  String? bankerWatsapp;
  String? bankerEmail;
  Data(
      {this.id,
        this.dsaCode,
        this.loanApplicationNo,
        this.bankId,
        this.branchId,
        this.typeOfLoan,
        this.loanAmountApplied,
        this.detailForLoanApplication,
        this.addharCardNumber,
        this.panCardNumber,
        this.uniqueLeadNumber,
        this.coApplicantDetail,
        this.loanDetails,
        this.familyMembers,
        this.creditCards,
        this.financialDetails,
        this.referenceDetails,
        this.channelId,
        this.channelCode,
        this.bankerName,
        this.bankerMobile,
        this.bankerWatsapp,
        this.bankerEmail
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dsaCode = json['dsaCode'];
    loanApplicationNo = json['loanApplicationNo'];
    bankId = json['bankId'];
    branchId = json['branchId'];
    typeOfLoan = json['typeOfLoan'];
    loanAmountApplied = json['loanAmountApplied'];
    detailForLoanApplication = json['detailForLoanApplication'];
    addharCardNumber = json['addharCardNumber'];
    panCardNumber = json['panCardNumber'];
    uniqueLeadNumber = json['uniqueLeadNumber'];
    coApplicantDetail = json['coApplicantDetail'];
    loanDetails = json['loanDetails'];
    familyMembers = json['familyMembers'];
    creditCards = json['creditCards'];
    financialDetails = json['financialDetails'];
    referenceDetails = json['referenceDetails'];
    channelId = json['channelId'];
    channelCode = json['channelCode'];
    bankerName = json['bankerName'];
    bankerMobile = json['bankerMobile'];
    bankerWatsapp = json['bankerWatsapp'];
    bankerEmail = json['bankerEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dsaCode'] = this.dsaCode;
    data['loanApplicationNo'] = this.loanApplicationNo;
    data['bankId'] = this.bankId;
    data['branchId'] = this.branchId;
    data['typeOfLoan'] = this.typeOfLoan;
    data['loanAmountApplied'] = this.loanAmountApplied;
    data['detailForLoanApplication'] = this.detailForLoanApplication;
    data['addharCardNumber'] = this.addharCardNumber;
    data['panCardNumber'] = this.panCardNumber;
    data['uniqueLeadNumber'] = this.uniqueLeadNumber;
    data['coApplicantDetail'] = this.coApplicantDetail;
    data['loanDetails'] = this.loanDetails;
    data['familyMembers'] = this.familyMembers;
    data['creditCards'] = this.creditCards;
    data['financialDetails'] = this.financialDetails;
    data['referenceDetails'] = this.referenceDetails;
    data['channelId'] = this.channelId;
    data['channelCode'] = this.channelCode;
    data['bankerName'] = this.bankerName;
    data['bankerMobile'] = this.bankerMobile;
    data['bankerWatsapp'] = this.bankerWatsapp;
    data['bankerEmail'] = this.bankerEmail;
    return data;
  }
}