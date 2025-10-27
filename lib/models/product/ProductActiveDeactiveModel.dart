class ProductActiveDeactiveModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  ProductActiveDeactiveModel(
      {this.status, this.success, this.data, this.message});

  ProductActiveDeactiveModel.fromJson(Map<String, dynamic> json) {
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
  int? bankId;
  String? bankName;
  String? bankersName;
  String? bankersMobileNumber;
  String? bankersWhatsAppNumber;
  String? bankersEmailID;
  num? minCIBIL;
  num? segmentVertical;
  String? product;
  String? productDescription;
  String? customerCategory;
  String? collateralSecurityCategory;
  String? collateralSecurityExcluded;
  String? incomeTypes;
  String? profileExcluded;
  num? ageLimitEarningApplicants;
  num? ageLimitNonEarningCoApplicant;
  num? minimumAgeEarningApplicants;
  num? minimumAgeNonEarningApplicants;
  num? minimumIncomeCriteria;
  num? minimumLoanAmount;
  num? maximumLoanAmount;
  num? minTenor;
  num? maximumTenor;
  num? minimumROI;
  num? maximumROI;
  num? maximumTenorEligibilityCriteria;
  String? geoLimit;
  String? negativeProfiles;
  String? negativeAreas;
  num? maximumTAT;
  num? minimumPropertyValue;
  num? maximumIIR;
  num? maximumFOIR;
  num? maximumLTV;
  num? processingFee;
  num? legalFee;
  num? technicalInspectionFee;
  num? adminFee;
  num? foreclosureCharges;
  num? otherCharges;
  num? stampDuty;
  num? tSRYears;
  num? tSRCharges;
  num? valuationCharges;
  num? noOfDocument;
  String? productValidateFromDate;
  String? productValidateToDate;
  num? kSDPLProductId;
  String? kSDPLProductName;
  num? profitPercentage;
  bool? active;
  String? createdDate;
  String? createdBy;
  String? updatedDate;
  String? updatedBy;
  String? deletedDate;
  String? deletedBy;
  String? productCategoryName;
  num? processingCharges;
  num? fromAmountRange;
  num? toAmountRange;
  num? totalOverdueCases;
  num? totalOverdueAmount;
  num? totalEnquiries;
  String? superiorName;
  String? superiorMobileNo;
  String? superiorWhatsappNo;
  String? superiorEmail;

  Data(
      {this.id,
        this.bankId,
        this.bankName,
        this.bankersName,
        this.bankersMobileNumber,
        this.bankersWhatsAppNumber,
        this.bankersEmailID,
        this.minCIBIL,
        this.segmentVertical,
        this.product,
        this.productDescription,
        this.customerCategory,
        this.collateralSecurityCategory,
        this.collateralSecurityExcluded,
        this.incomeTypes,
        this.profileExcluded,
        this.ageLimitEarningApplicants,
        this.ageLimitNonEarningCoApplicant,
        this.minimumAgeEarningApplicants,
        this.minimumAgeNonEarningApplicants,
        this.minimumIncomeCriteria,
        this.minimumLoanAmount,
        this.maximumLoanAmount,
        this.minTenor,
        this.maximumTenor,
        this.minimumROI,
        this.maximumROI,
        this.maximumTenorEligibilityCriteria,
        this.geoLimit,
        this.negativeProfiles,
        this.negativeAreas,
        this.maximumTAT,
        this.minimumPropertyValue,
        this.maximumIIR,
        this.maximumFOIR,
        this.maximumLTV,
        this.processingFee,
        this.legalFee,
        this.technicalInspectionFee,
        this.adminFee,
        this.foreclosureCharges,
        this.otherCharges,
        this.stampDuty,
        this.tSRYears,
        this.tSRCharges,
        this.valuationCharges,
        this.noOfDocument,
        this.productValidateFromDate,
        this.productValidateToDate,
        this.kSDPLProductId,
        this.kSDPLProductName,
        this.profitPercentage,
        this.active,
        this.createdDate,
        this.createdBy,
        this.updatedDate,
        this.updatedBy,
        this.deletedDate,
        this.deletedBy,
        this.productCategoryName,
        this.processingCharges,
        this.fromAmountRange,
        this.toAmountRange,
        this.totalOverdueCases,
        this.totalOverdueAmount,
        this.totalEnquiries,
        this.superiorName,
        this.superiorMobileNo,
        this.superiorWhatsappNo,
        this.superiorEmail});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    bankId = json['BankId'];
    bankName = json['BankName'];
    bankersName = json['Bankers_Name'];
    bankersMobileNumber = json['Bankers_Mobile_Number'];
    bankersWhatsAppNumber = json['Bankers_WhatsApp_Number'];
    bankersEmailID = json['Bankers_email_ID'];
    minCIBIL = json['Min_CIBIL'];
    segmentVertical = json['Segment_Vertical'];
    product = json['Product'];
    productDescription = json['ProductDescription'];
    customerCategory = json['Customer_Category'];
    collateralSecurityCategory = json['Collateral_Security_Category'];
    collateralSecurityExcluded = json['Collateral_Security_Excluded'];
    incomeTypes = json['Income_Types'];
    profileExcluded = json['Profile_Excluded'];
    ageLimitEarningApplicants = json['Age_limit_Earning_Applicants'];
    ageLimitNonEarningCoApplicant = json['Age_limit_Non_Earning_Co_Applicant'];
    minimumAgeEarningApplicants = json['Minimum_age_earning_applicants'];
    minimumAgeNonEarningApplicants = json['Minimum_age_non_earning_applicants'];
    minimumIncomeCriteria = json['Minimum_Income_Criteria'];
    minimumLoanAmount = json['Minimum_Loan_Amount'];
    maximumLoanAmount = json['Maximum_Loan_Amount'];
    minTenor = json['Min_Tenor'];
    maximumTenor = json['Maximum_Tenor'];
    minimumROI = json['Minimum_ROI'];
    maximumROI = json['Maximum_ROI'];
    maximumTenorEligibilityCriteria =
    json['Maximum_Tenor_Eligibility_Criteria'];
    geoLimit = json['Geo_Limit'];
    negativeProfiles = json['Negative_Profiles'];
    negativeAreas = json['Negative_Areas'];
    maximumTAT = json['Maximum_TAT'];
    minimumPropertyValue = json['Minimum_Property_Value'];
    maximumIIR = json['Maximum_IIR'];
    maximumFOIR = json['Maximum_FOIR'];
    maximumLTV = json['Maximum_LTV'];
    processingFee = json['Processing_Fee'];
    legalFee = json['Legal_Fee'];
    technicalInspectionFee = json['TechnicalInspectionFee'];
    adminFee = json['Admin_Fee'];
    foreclosureCharges = json['Foreclosure_Charges'];
    otherCharges = json['Other_Charges'];
    stampDuty = json['Stamp_Duty'];
    tSRYears = json['TSR_Years'];
    tSRCharges = json['TSR_Charges'];
    valuationCharges = json['Valuation_Charges'];
    noOfDocument = json['NoOfDocument'];
    productValidateFromDate = json['Product_Validate_From_date'];
    productValidateToDate = json['Product_Validate_To_date'];
    kSDPLProductId = json['KSDPLProductId'];
    kSDPLProductName = json['KSDPLProductName'];
    profitPercentage = json['Profit_Percentage'];
    active = json['Active'];
    createdDate = json['CreatedDate'];
    createdBy = json['CreatedBy'];
    updatedDate = json['UpdatedDate'];
    updatedBy = json['UpdatedBy'];
    deletedDate = json['DeletedDate'];
    deletedBy = json['DeletedBy'];
    productCategoryName = json['ProductCategoryName'];
    processingCharges = json['ProcessingCharges'];
    fromAmountRange = json['FromAmountRange'];
    toAmountRange = json['ToAmountRange'];
    totalOverdueCases = json['TotalOverdueCases'];
    totalOverdueAmount = json['TotalOverdueAmount'];
    totalEnquiries = json['TotalEnquiries'];
    superiorName = json['SuperiorName'];
    superiorMobileNo = json['SuperiorMobileNo'];
    superiorWhatsappNo = json['SuperiorWhatsappNo'];
    superiorEmail = json['SuperiorEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['BankId'] = this.bankId;
    data['BankName'] = this.bankName;
    data['Bankers_Name'] = this.bankersName;
    data['Bankers_Mobile_Number'] = this.bankersMobileNumber;
    data['Bankers_WhatsApp_Number'] = this.bankersWhatsAppNumber;
    data['Bankers_email_ID'] = this.bankersEmailID;
    data['Min_CIBIL'] = this.minCIBIL;
    data['Segment_Vertical'] = this.segmentVertical;
    data['Product'] = this.product;
    data['ProductDescription'] = this.productDescription;
    data['Customer_Category'] = this.customerCategory;
    data['Collateral_Security_Category'] = this.collateralSecurityCategory;
    data['Collateral_Security_Excluded'] = this.collateralSecurityExcluded;
    data['Income_Types'] = this.incomeTypes;
    data['Profile_Excluded'] = this.profileExcluded;
    data['Age_limit_Earning_Applicants'] = this.ageLimitEarningApplicants;
    data['Age_limit_Non_Earning_Co_Applicant'] =
        this.ageLimitNonEarningCoApplicant;
    data['Minimum_age_earning_applicants'] = this.minimumAgeEarningApplicants;
    data['Minimum_age_non_earning_applicants'] =
        this.minimumAgeNonEarningApplicants;
    data['Minimum_Income_Criteria'] = this.minimumIncomeCriteria;
    data['Minimum_Loan_Amount'] = this.minimumLoanAmount;
    data['Maximum_Loan_Amount'] = this.maximumLoanAmount;
    data['Min_Tenor'] = this.minTenor;
    data['Maximum_Tenor'] = this.maximumTenor;
    data['Minimum_ROI'] = this.minimumROI;
    data['Maximum_ROI'] = this.maximumROI;
    data['Maximum_Tenor_Eligibility_Criteria'] =
        this.maximumTenorEligibilityCriteria;
    data['Geo_Limit'] = this.geoLimit;
    data['Negative_Profiles'] = this.negativeProfiles;
    data['Negative_Areas'] = this.negativeAreas;
    data['Maximum_TAT'] = this.maximumTAT;
    data['Minimum_Property_Value'] = this.minimumPropertyValue;
    data['Maximum_IIR'] = this.maximumIIR;
    data['Maximum_FOIR'] = this.maximumFOIR;
    data['Maximum_LTV'] = this.maximumLTV;
    data['Processing_Fee'] = this.processingFee;
    data['Legal_Fee'] = this.legalFee;
    data['TechnicalInspectionFee'] = this.technicalInspectionFee;
    data['Admin_Fee'] = this.adminFee;
    data['Foreclosure_Charges'] = this.foreclosureCharges;
    data['Other_Charges'] = this.otherCharges;
    data['Stamp_Duty'] = this.stampDuty;
    data['TSR_Years'] = this.tSRYears;
    data['TSR_Charges'] = this.tSRCharges;
    data['Valuation_Charges'] = this.valuationCharges;
    data['NoOfDocument'] = this.noOfDocument;
    data['Product_Validate_From_date'] = this.productValidateFromDate;
    data['Product_Validate_To_date'] = this.productValidateToDate;
    data['KSDPLProductId'] = this.kSDPLProductId;
    data['KSDPLProductName'] = this.kSDPLProductName;
    data['Profit_Percentage'] = this.profitPercentage;
    data['Active'] = this.active;
    data['CreatedDate'] = this.createdDate;
    data['CreatedBy'] = this.createdBy;
    data['UpdatedDate'] = this.updatedDate;
    data['UpdatedBy'] = this.updatedBy;
    data['DeletedDate'] = this.deletedDate;
    data['DeletedBy'] = this.deletedBy;
    data['ProductCategoryName'] = this.productCategoryName;
    data['ProcessingCharges'] = this.processingCharges;
    data['FromAmountRange'] = this.fromAmountRange;
    data['ToAmountRange'] = this.toAmountRange;
    data['TotalOverdueCases'] = this.totalOverdueCases;
    data['TotalOverdueAmount'] = this.totalOverdueAmount;
    data['TotalEnquiries'] = this.totalEnquiries;
    data['SuperiorName'] = this.superiorName;
    data['SuperiorMobileNo'] = this.superiorMobileNo;
    data['SuperiorWhatsappNo'] = this.superiorWhatsappNo;
    data['SuperiorEmail'] = this.superiorEmail;
    return data;
  }
}

