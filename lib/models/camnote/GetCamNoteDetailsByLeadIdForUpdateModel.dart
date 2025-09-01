class GetCamNoteDetailsByLeadIdForUpdateModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  GetCamNoteDetailsByLeadIdForUpdateModel(
      {this.status, this.success, this.data, this.message});

  GetCamNoteDetailsByLeadIdForUpdateModel.fromJson(Map<String, dynamic> json) {
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
  num? leadId;
  num? cibil;
  num? totalLoanAvailedOnCibil;
  num? totalLiveLoan;
  num? totalEMI;
  num? emiStoppedOnBeforeThisLoan;
  num? emiWillContinue;
  num? totalOverdueAmountAsPerCibil;
  num? totalEnquiriesMadeAsPerCibil;
  num? loanSegment;
  num? loanProduct;
  String? offeredSecurityType;
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
  num? totalOverdueCasesAsPerCibil;

  Data(
      {this.leadId,
        this.cibil,
        this.totalLoanAvailedOnCibil,
        this.totalLiveLoan,
        this.totalEMI,
        this.emiStoppedOnBeforeThisLoan,
        this.emiWillContinue,
        this.totalOverdueAmountAsPerCibil,
        this.totalEnquiriesMadeAsPerCibil,
        this.loanSegment,
        this.loanProduct,
        this.offeredSecurityType,
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
        this.totalOverdueCasesAsPerCibil});

  Data.fromJson(Map<String, dynamic> json) {
    leadId = json['leadId'];
    cibil = json['cibil'];
    totalLoanAvailedOnCibil = json['totalLoanAvailedOnCibil'];
    totalLiveLoan = json['totalLiveLoan'];
    totalEMI = json['totalEMI'];
    emiStoppedOnBeforeThisLoan = json['emiStoppedOnBeforeThisLoan'];
    emiWillContinue = json['emiWillContinue'];
    totalOverdueAmountAsPerCibil = json['totalOverdueAmountAsPerCibil'];
    totalEnquiriesMadeAsPerCibil = json['totalEnquiriesMadeAsPerCibil'];
    loanSegment = json['loanSegment'];
    loanProduct = json['loanProduct'];
    offeredSecurityType = json['offeredSecurityType'];
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
    totalOverdueCasesAsPerCibil = json['totalOverdueCasesAsPerCibil'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leadId'] = this.leadId;
    data['cibil'] = this.cibil;
    data['totalLoanAvailedOnCibil'] = this.totalLoanAvailedOnCibil;
    data['totalLiveLoan'] = this.totalLiveLoan;
    data['totalEMI'] = this.totalEMI;
    data['emiStoppedOnBeforeThisLoan'] = this.emiStoppedOnBeforeThisLoan;
    data['emiWillContinue'] = this.emiWillContinue;
    data['totalOverdueAmountAsPerCibil'] = this.totalOverdueAmountAsPerCibil;
    data['totalEnquiriesMadeAsPerCibil'] = this.totalEnquiriesMadeAsPerCibil;
    data['loanSegment'] = this.loanSegment;
    data['loanProduct'] = this.loanProduct;
    data['offeredSecurityType'] = this.offeredSecurityType;
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
    data['totalOverdueCasesAsPerCibil'] = this.totalOverdueCasesAsPerCibil;
    return data;
  }
}
