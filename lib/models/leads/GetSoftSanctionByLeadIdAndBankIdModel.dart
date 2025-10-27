class GetSoftSanctionByLeadIdAndBankIdModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  GetSoftSanctionByLeadIdAndBankIdModel(
      {this.status, this.success, this.data, this.message});

  GetSoftSanctionByLeadIdAndBankIdModel.fromJson(Map<String, dynamic> json) {
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
  num? leadId;
  num? bankId;
  String? bankersName;
  String? bankersMobileNumber;
  String? bankersWhatsAppNumber;
  String? bankersEmailId;
  num? cibil;
  num? totalLoanAvailedOnCibil;
  num? totalLiveLoan;
  num? totalEmi;
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
  num? proposedEmi;
  num? propertyValueAsPerCustomer;
  num? foir;
  num? ltv;
  num? softsanction;
  num? sanctionAmount;
  num? sanctionTenor;
  num? sanctionRoi;
  String? sanctionCondition;
  num? sanctionProcessingFees;
  num? sanctionStampDuty;
  String? documents;
  String? softsanctionDate;
  String? rejectReason;
  num? branchId;
  String? createdDate;
  num? sanctionEstimatedEmi;
  num? sanctionApplicableLegalFee;
  num? sanctionApplicableTechnicalFee;
  num? sanctionApplicableAdminFee;
  num? sanctionApplicableForeclosureCharges;
  num? sanctionApplicableOtherCharges;
  num? sanctionTsryears;
  num? sanctionApplicableTsrcharges;
  num? sanctionApplicableValuationCharges;
  num? sanctionProcessingCharges;
  String? lastUpdatedDate;
  String? geoLocationOfResidence;
  String? geoLocationOfOffice;
  String? photosOfProperty;
  String? photosOfResidence;
  String? photosOfOffice;
  num? autoIndividual;
  num? closedCases;
  num? writtenOffCases;
  num? settlementCases;
  num? suitFiledWillfulDefaultCases;
  num? totalSanctionedAmount;
  num? currentBalance;
  num? closedAmount;
  num? writtenOffAmount;
  num? settlementAmount;
  num? suitFiledWillfulDefaultAmount;
  num? standardCount;
  num? numberOfDaysPastDueCount;
  num? lossCount;
  num? substandardCount;
  num? doubtfulCount;
  num? specialMentionAccountCount;
  num? npt;
  num? totalCounts;
  num? currentlyCasesBeingServed;
  num? casesToBeForeclosedOnOrBeforeDisb;
  num? casesToBeContenued;
  num? emIsOfExistingLiabilities;
  num? iir;

  Data(
      {this.id,
        this.leadId,
        this.bankId,
        this.bankersName,
        this.bankersMobileNumber,
        this.bankersWhatsAppNumber,
        this.bankersEmailId,
        this.cibil,
        this.totalLoanAvailedOnCibil,
        this.totalLiveLoan,
        this.totalEmi,
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
        this.proposedEmi,
        this.propertyValueAsPerCustomer,
        this.foir,
        this.ltv,
        this.softsanction,
        this.sanctionAmount,
        this.sanctionTenor,
        this.sanctionRoi,
        this.sanctionCondition,
        this.sanctionProcessingFees,
        this.sanctionStampDuty,
        this.documents,
        this.softsanctionDate,
        this.rejectReason,
        this.branchId,
        this.createdDate,
        this.sanctionEstimatedEmi,
        this.sanctionApplicableLegalFee,
        this.sanctionApplicableTechnicalFee,
        this.sanctionApplicableAdminFee,
        this.sanctionApplicableForeclosureCharges,
        this.sanctionApplicableOtherCharges,
        this.sanctionTsryears,
        this.sanctionApplicableTsrcharges,
        this.sanctionApplicableValuationCharges,
        this.sanctionProcessingCharges,
        this.lastUpdatedDate,
        this.geoLocationOfResidence,
        this.geoLocationOfOffice,
        this.photosOfProperty,
        this.photosOfResidence,
        this.photosOfOffice,
        this.autoIndividual,
        this.closedCases,
        this.writtenOffCases,
        this.settlementCases,
        this.suitFiledWillfulDefaultCases,
        this.totalSanctionedAmount,
        this.currentBalance,
        this.closedAmount,
        this.writtenOffAmount,
        this.settlementAmount,
        this.suitFiledWillfulDefaultAmount,
        this.standardCount,
        this.numberOfDaysPastDueCount,
        this.lossCount,
        this.substandardCount,
        this.doubtfulCount,
        this.specialMentionAccountCount,
        this.npt,
        this.totalCounts,
        this.currentlyCasesBeingServed,
        this.casesToBeForeclosedOnOrBeforeDisb,
        this.casesToBeContenued,
        this.emIsOfExistingLiabilities,
        this.iir});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadId = json['leadId'];
    bankId = json['bankId'];
    bankersName = json['bankersName'];
    bankersMobileNumber = json['bankersMobileNumber'];
    bankersWhatsAppNumber = json['bankersWhatsAppNumber'];
    bankersEmailId = json['bankersEmailId'];
    cibil = json['cibil'];
    totalLoanAvailedOnCibil = json['totalLoanAvailedOnCibil'];
    totalLiveLoan = json['totalLiveLoan'];
    totalEmi = json['totalEmi'];
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
    proposedEmi = json['proposedEmi'];
    propertyValueAsPerCustomer = json['propertyValueAsPerCustomer'];
    foir = json['foir'];
    ltv = json['ltv'];
    softsanction = json['softsanction'];
    sanctionAmount = json['sanctionAmount'];
    sanctionTenor = json['sanctionTenor'];
    sanctionRoi = json['sanctionRoi'];
    sanctionCondition = json['sanctionCondition'];
    sanctionProcessingFees = json['sanctionProcessingFees'];
    sanctionStampDuty = json['sanctionStampDuty'];
    documents = json['documents'];
    softsanctionDate = json['softsanctionDate'];
    rejectReason = json['rejectReason'];
    branchId = json['branchId'];
    createdDate = json['createdDate'];
    sanctionEstimatedEmi = json['sanctionEstimatedEmi'];
    sanctionApplicableLegalFee = json['sanctionApplicableLegalFee'];
    sanctionApplicableTechnicalFee = json['sanctionApplicableTechnicalFee'];
    sanctionApplicableAdminFee = json['sanctionApplicableAdminFee'];
    sanctionApplicableForeclosureCharges =
    json['sanctionApplicableForeclosureCharges'];
    sanctionApplicableOtherCharges = json['sanctionApplicableOtherCharges'];
    sanctionTsryears = json['sanctionTsryears'];
    sanctionApplicableTsrcharges = json['sanctionApplicableTsrcharges'];
    sanctionApplicableValuationCharges =
    json['sanctionApplicableValuationCharges'];
    sanctionProcessingCharges = json['sanctionProcessingCharges'];
    lastUpdatedDate = json['lastUpdatedDate'];
    geoLocationOfResidence = json['geoLocationOfResidence'];
    geoLocationOfOffice = json['geoLocationOfOffice'];
    photosOfProperty = json['photosOfProperty'];
    photosOfResidence = json['photosOfResidence'];
    photosOfOffice = json['photosOfOffice'];
    autoIndividual = json['auto_individual'];
    closedCases = json['closedCases'];
    writtenOffCases = json['writtenOffCases'];
    settlementCases = json['settlementCases'];
    suitFiledWillfulDefaultCases = json['suit_Filed_Willful_Default_Cases'];
    totalSanctionedAmount = json['totalSanctionedAmount'];
    currentBalance = json['currentBalance'];
    closedAmount = json['closedAmount'];
    writtenOffAmount = json['writtenOffAmount'];
    settlementAmount = json['settlementAmount'];
    suitFiledWillfulDefaultAmount = json['suit_Filed_Willful_Default_Amount'];
    standardCount = json['standard_Count'];
    numberOfDaysPastDueCount = json['number_of_days_past_due_Count'];
    lossCount = json['loss_Count'];
    substandardCount = json['substandard_Count'];
    doubtfulCount = json['doubtful_Count'];
    specialMentionAccountCount = json['special_Mention_account_Count'];
    npt = json['npt'];
    totalCounts = json['totalCounts'];
    currentlyCasesBeingServed = json['currentlyCasesBeingServed'];
    casesToBeForeclosedOnOrBeforeDisb =
    json['casesToBeForeclosedOnOrBeforeDisb'];
    casesToBeContenued = json['casesToBeContenued'];
    emIsOfExistingLiabilities = json['emIsOfExistingLiabilities'];
    iir = json['iir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leadId'] = this.leadId;
    data['bankId'] = this.bankId;
    data['bankersName'] = this.bankersName;
    data['bankersMobileNumber'] = this.bankersMobileNumber;
    data['bankersWhatsAppNumber'] = this.bankersWhatsAppNumber;
    data['bankersEmailId'] = this.bankersEmailId;
    data['cibil'] = this.cibil;
    data['totalLoanAvailedOnCibil'] = this.totalLoanAvailedOnCibil;
    data['totalLiveLoan'] = this.totalLiveLoan;
    data['totalEmi'] = this.totalEmi;
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
    data['proposedEmi'] = this.proposedEmi;
    data['propertyValueAsPerCustomer'] = this.propertyValueAsPerCustomer;
    data['foir'] = this.foir;
    data['ltv'] = this.ltv;
    data['softsanction'] = this.softsanction;
    data['sanctionAmount'] = this.sanctionAmount;
    data['sanctionTenor'] = this.sanctionTenor;
    data['sanctionRoi'] = this.sanctionRoi;
    data['sanctionCondition'] = this.sanctionCondition;
    data['sanctionProcessingFees'] = this.sanctionProcessingFees;
    data['sanctionStampDuty'] = this.sanctionStampDuty;
    data['documents'] = this.documents;
    data['softsanctionDate'] = this.softsanctionDate;
    data['rejectReason'] = this.rejectReason;
    data['branchId'] = this.branchId;
    data['createdDate'] = this.createdDate;
    data['sanctionEstimatedEmi'] = this.sanctionEstimatedEmi;
    data['sanctionApplicableLegalFee'] = this.sanctionApplicableLegalFee;
    data['sanctionApplicableTechnicalFee'] =
        this.sanctionApplicableTechnicalFee;
    data['sanctionApplicableAdminFee'] = this.sanctionApplicableAdminFee;
    data['sanctionApplicableForeclosureCharges'] =
        this.sanctionApplicableForeclosureCharges;
    data['sanctionApplicableOtherCharges'] =
        this.sanctionApplicableOtherCharges;
    data['sanctionTsryears'] = this.sanctionTsryears;
    data['sanctionApplicableTsrcharges'] = this.sanctionApplicableTsrcharges;
    data['sanctionApplicableValuationCharges'] =
        this.sanctionApplicableValuationCharges;
    data['sanctionProcessingCharges'] = this.sanctionProcessingCharges;
    data['lastUpdatedDate'] = this.lastUpdatedDate;
    data['geoLocationOfResidence'] = this.geoLocationOfResidence;
    data['geoLocationOfOffice'] = this.geoLocationOfOffice;
    data['photosOfProperty'] = this.photosOfProperty;
    data['photosOfResidence'] = this.photosOfResidence;
    data['photosOfOffice'] = this.photosOfOffice;
    data['auto_individual'] = this.autoIndividual;
    data['closedCases'] = this.closedCases;
    data['writtenOffCases'] = this.writtenOffCases;
    data['settlementCases'] = this.settlementCases;
    data['suit_Filed_Willful_Default_Cases'] =
        this.suitFiledWillfulDefaultCases;
    data['totalSanctionedAmount'] = this.totalSanctionedAmount;
    data['currentBalance'] = this.currentBalance;
    data['closedAmount'] = this.closedAmount;
    data['writtenOffAmount'] = this.writtenOffAmount;
    data['settlementAmount'] = this.settlementAmount;
    data['suit_Filed_Willful_Default_Amount'] =
        this.suitFiledWillfulDefaultAmount;
    data['standard_Count'] = this.standardCount;
    data['number_of_days_past_due_Count'] = this.numberOfDaysPastDueCount;
    data['loss_Count'] = this.lossCount;
    data['substandard_Count'] = this.substandardCount;
    data['doubtful_Count'] = this.doubtfulCount;
    data['special_Mention_account_Count'] = this.specialMentionAccountCount;
    data['npt'] = this.npt;
    data['totalCounts'] = this.totalCounts;
    data['currentlyCasesBeingServed'] = this.currentlyCasesBeingServed;
    data['casesToBeForeclosedOnOrBeforeDisb'] =
        this.casesToBeForeclosedOnOrBeforeDisb;
    data['casesToBeContenued'] = this.casesToBeContenued;
    data['emIsOfExistingLiabilities'] = this.emIsOfExistingLiabilities;
    data['iir'] = this.iir;
    return data;
  }
}
