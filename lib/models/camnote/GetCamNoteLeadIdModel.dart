import '../../common/safe_json_helper.dart';

class GetCamNoteLeadIdModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetCamNoteLeadIdModel({this.status, this.success, this.data, this.message});

  GetCamNoteLeadIdModel.fromJson(Map<String, dynamic> json) {
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
  int? leadID;
  int? bankId;
  String? bankersName;
  String? bankersMobileNumber;
  String? bankersWhatsAppNumber;
  String? bankersEmailID;
  num? cibil;
  num? totalLoanAvailedOnCibil;
  num? totalLiveLoan;
  num? totalEMI;
  num? emiStoppedOnBeforeThisLoan;
  num? emiWillContinue;
  num? totalOverdueCasesAsPerCibil;
  num? totalOverdueAmountAsPerCibil;
  num? totalEnquiriesMadeAsPerCibil;
  num? loanSegment;
  num? loanProduct;
  String? offeredSecurityType;
  String? geoLocationOfProperty;
  String? incomeType;
  num? earningCustomerAge;
  num? nonEarningCustomerAge;
  num? totalFamilyIncome;
  num? incomeCanBeConsidered;
  num? loanAmountRequested;
  num? loanTenorRequested;
  num? roi;
  num? proposedEMI;
  num? propertyValueAsPerCustomer;
  num? foir;
  num? ltv;
  String? documents;
  num? softsanction;
  num? sanctionStampDuty;
  num? sanctionProcessingFees;
  String? sanctionCondition;
  num? sanctionROI;
  num? sanctionTenor;
  num? sanctionAmount;
  String? softsanctionDate;
  String? rejectReason;
  String? bankName;
  String? productCategoryName;
  String? product;
  num? branchId;
  String? branchName;
  String? geoLocationOfResidence;
  String? geoLocationOfOffice;
  String? photosOfProperty;
  String? photosOfResidence;
  String? photosOfOffice;

  Data(
      {this.id,
        this.leadID,
        this.bankId,
        this.bankersName,
        this.bankersMobileNumber,
        this.bankersWhatsAppNumber,
        this.bankersEmailID,
        this.cibil,
        this.totalLoanAvailedOnCibil,
        this.totalLiveLoan,
        this.totalEMI,
        this.emiStoppedOnBeforeThisLoan,
        this.emiWillContinue,
        this.totalOverdueCasesAsPerCibil,
        this.totalOverdueAmountAsPerCibil,
        this.totalEnquiriesMadeAsPerCibil,
        this.loanSegment,
        this.loanProduct,
        this.offeredSecurityType,
        this.geoLocationOfProperty,
        this.incomeType,
        this.earningCustomerAge,
        this.nonEarningCustomerAge,
        this.totalFamilyIncome,
        this.incomeCanBeConsidered,
        this.loanAmountRequested,
        this.loanTenorRequested,
        this.roi,
        this.proposedEMI,
        this.propertyValueAsPerCustomer,
        this.foir,
        this.ltv,
        this.documents,
        this.softsanction,
        this.sanctionStampDuty,
        this.sanctionProcessingFees,
        this.sanctionCondition,
        this.sanctionROI,
        this.sanctionTenor,
        this.sanctionAmount,
        this.softsanctionDate,
        this.rejectReason,
        this.bankName,
        this.productCategoryName,
        this.product,
        this.branchId,
        this.branchName,
        this.geoLocationOfResidence,
        this.geoLocationOfOffice,
        this.photosOfProperty,
        this.photosOfResidence,
        this.photosOfOffice});

  Data.fromJson(Map<String, dynamic> json) {


    id = json['id'];
    leadID = json['leadID'];
    bankId = json['bankId'];
    bankersName = json['bankersName'];
    bankersMobileNumber = json['bankersMobileNumber'];
    bankersWhatsAppNumber = json['bankersWhatsAppNumber'];
    bankersEmailID = json['bankersEmailID'];
    cibil = json['cibil'];
    totalLoanAvailedOnCibil = json['totalLoanAvailedOnCibil'];
    totalLiveLoan = json['totalLiveLoan'];
    totalEMI = json['totalEMI'];
    emiStoppedOnBeforeThisLoan = json['emiStoppedOnBeforeThisLoan'];
    emiWillContinue = json['emiWillContinue'];
    totalOverdueCasesAsPerCibil = json['totalOverdueCasesAsPerCibil'];
    totalOverdueAmountAsPerCibil = json['totalOverdueAmountAsPerCibil'];
    totalEnquiriesMadeAsPerCibil = json['totalEnquiriesMadeAsPerCibil'];
    loanSegment = json['loanSegment'];
    loanProduct = json['loanProduct'];
    offeredSecurityType = json['offeredSecurityType'];
    geoLocationOfProperty = json['geoLocationOfProperty'];
    incomeType = json['incomeType'];
    earningCustomerAge = json['earningCustomerAge'];
    nonEarningCustomerAge = json['nonEarningCustomerAge'];
    totalFamilyIncome = json['totalFamilyIncome'];
    incomeCanBeConsidered = json['incomeCanBeConsidered'];
    loanAmountRequested = json['loanAmountRequested'];
    loanTenorRequested = json['loanTenorRequested'];
    roi = json['roi'];
    proposedEMI = json['proposedEMI'];
    propertyValueAsPerCustomer = json['propertyValueAsPerCustomer'];
    foir = json['foir'];
    ltv = json['ltv'];
    documents = json['documents'];
    softsanction = json['softsanction'];
    sanctionStampDuty = json['sanctionStampDuty'];
    sanctionProcessingFees = json['sanctionProcessingFees'];
    sanctionCondition = json['sanctionCondition'];
    sanctionROI = json['sanctionROI'];
    sanctionTenor = json['sanctionTenor'];
    sanctionAmount = json['sanctionAmount'];
    softsanctionDate = json['softsanctionDate'];
    rejectReason = json['rejectReason'];
    bankName = json['bankName'];
    productCategoryName = json['productCategoryName'];
    product = json['product'];
    branchId = json['branchId'];
    branchName = json['branchName'];
    geoLocationOfResidence = json['geoLocationOfResidence'];
    geoLocationOfOffice = json['geoLocationOfOffice'];
    photosOfProperty = json['photosOfProperty'];
    photosOfResidence = json['photosOfResidence'];
    photosOfOffice = json['photosOfOffice'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leadID'] = this.leadID;
    data['bankId'] = this.bankId;
    data['bankersName'] = this.bankersName;
    data['bankersMobileNumber'] = this.bankersMobileNumber;
    data['bankersWhatsAppNumber'] = this.bankersWhatsAppNumber;
    data['bankersEmailID'] = this.bankersEmailID;
    data['cibil'] = this.cibil;
    data['totalLoanAvailedOnCibil'] = this.totalLoanAvailedOnCibil;
    data['totalLiveLoan'] = this.totalLiveLoan;
    data['totalEMI'] = this.totalEMI;
    data['emiStoppedOnBeforeThisLoan'] = this.emiStoppedOnBeforeThisLoan;
    data['emiWillContinue'] = this.emiWillContinue;
    data['totalOverdueCasesAsPerCibil'] = this.totalOverdueCasesAsPerCibil;
    data['totalOverdueAmountAsPerCibil'] = this.totalOverdueAmountAsPerCibil;
    data['totalEnquiriesMadeAsPerCibil'] = this.totalEnquiriesMadeAsPerCibil;
    data['loanSegment'] = this.loanSegment;
    data['loanProduct'] = this.loanProduct;
    data['offeredSecurityType'] = this.offeredSecurityType;
    data['geoLocationOfProperty'] = this.geoLocationOfProperty;
    data['incomeType'] = this.incomeType;
    data['earningCustomerAge'] = this.earningCustomerAge;
    data['nonEarningCustomerAge'] = this.nonEarningCustomerAge;
    data['totalFamilyIncome'] = this.totalFamilyIncome;
    data['incomeCanBeConsidered'] = this.incomeCanBeConsidered;
    data['loanAmountRequested'] = this.loanAmountRequested;
    data['loanTenorRequested'] = this.loanTenorRequested;
    data['roi'] = this.roi;
    data['proposedEMI'] = this.proposedEMI;
    data['propertyValueAsPerCustomer'] = this.propertyValueAsPerCustomer;
    data['foir'] = this.foir;
    data['ltv'] = this.ltv;
    data['documents'] = this.documents;
    data['softsanction'] = this.softsanction;
    data['sanctionStampDuty'] = this.sanctionStampDuty;
    data['sanctionProcessingFees'] = this.sanctionProcessingFees;
    data['sanctionCondition'] = this.sanctionCondition;
    data['sanctionROI'] = this.sanctionROI;
    data['sanctionTenor'] = this.sanctionTenor;
    data['sanctionAmount'] = this.sanctionAmount;
    data['softsanctionDate'] = this.softsanctionDate;
    data['rejectReason'] = this.rejectReason;
    data['bankName'] = this.bankName;
    data['productCategoryName'] = this.productCategoryName;
    data['product'] = this.product;
    data['branchId'] = this.branchId;
    data['branchName'] = this.branchName;
    data['geoLocationOfResidence'] = this.geoLocationOfResidence;
    data['geoLocationOfOffice'] = this.geoLocationOfOffice;
    data['photosOfProperty'] = this.photosOfProperty;
    data['photosOfResidence'] = this.photosOfResidence;
    data['photosOfOffice'] = this.photosOfOffice;
    return data;
  }
}
