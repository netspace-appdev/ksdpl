
class GetProductDetailsByFilterModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetProductDetailsByFilterModel(
      {this.status, this.success, this.data, this.message});

  GetProductDetailsByFilterModel.fromJson(Map<String, dynamic> json) {
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
  num? id;
  num? bankId;
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
  num? technicalFee;
  num? adminFee;
  num? foreclosureCharges;
  num? otherCharges;
  num? stampDuty;
  num? tsRYears;
  num? tsRCharges;
  num? valuationCharges;
  num? noOfDocument;
  String? productValidateFromDate;
  String? productValidateToDate;
  num? ksdplProductId;
  num? profitPercentage;
  String? bankName;
  String? productSegment;
  String? ksdplProduct;
  num? specialBranchId;
  String? autoindividual; // <-- Add this in your data model

  Data(
      {this.id,
        this.bankId,
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
        this.technicalFee,
        this.adminFee,
        this.foreclosureCharges,
        this.otherCharges,
        this.stampDuty,
        this.tsRYears,
        this.tsRCharges,
        this.valuationCharges,
        this.noOfDocument,
        this.productValidateFromDate,
        this.productValidateToDate,
        this.ksdplProductId,
        this.profitPercentage,
        this.bankName,
        this.productSegment,
        this.ksdplProduct,
        this.specialBranchId, // 👈 include in constructor
        this.autoindividual, // 👈 include in constructor
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankId = json['bankId'];
    bankersName = json['bankers_Name'];
    bankersMobileNumber = json['bankers_Mobile_Number'];
    bankersWhatsAppNumber = json['bankers_WhatsApp_Number'];
    bankersEmailID = json['bankers_email_ID'];
    minCIBIL = json['min_CIBIL'];
    segmentVertical = json['segment_Vertical'];
    product = json['product'];
    productDescription = json['productDescription'];
    customerCategory = json['customer_Category'];
    collateralSecurityCategory = json['collateral_Security_Category'];
    collateralSecurityExcluded = json['collateral_Security_Excluded'];
    incomeTypes = json['income_Types'];
    profileExcluded = json['profile_Excluded'];
    ageLimitEarningApplicants = json['age_limit_Earning_Applicants'];
    ageLimitNonEarningCoApplicant = json['age_limit_Non_Earning_Co_Applicant'];
    minimumAgeEarningApplicants = json['minimum_age_earning_applicants'];
    minimumAgeNonEarningApplicants = json['minimum_age_non_earning_applicants'];
    minimumIncomeCriteria = json['minimum_Income_Criteria'];
    minimumLoanAmount = json['minimum_Loan_Amount'];
    maximumLoanAmount = json['maximum_Loan_Amount'];
    minTenor = json['min_Tenor'];
    maximumTenor = json['maximum_Tenor'];
    minimumROI = json['minimum_ROI'];
    maximumROI = json['maximum_ROI'];
    maximumTenorEligibilityCriteria =
    json['maximum_Tenor_Eligibility_Criteria'];
    geoLimit = json['geo_Limit'];
    negativeProfiles = json['negative_Profiles'];
    negativeAreas = json['negative_Areas'];
    maximumTAT = json['maximum_TAT'];
    minimumPropertyValue = json['minimum_Property_Value'];
    maximumIIR = json['maximum_IIR'];
    maximumFOIR = json['maximum_FOIR'];
    maximumLTV = json['maximum_LTV'];
    processingFee = json['processing_Fee'];
    legalFee = json['legal_Fee'];
    technicalFee = json['technical_Fee'];
    adminFee = json['admin_Fee'];
    foreclosureCharges = json['foreclosure_Charges'];
    otherCharges = json['other_Charges'];
    stampDuty = json['stamp_Duty'];
    tsRYears = json['tsR_Years'];
    tsRCharges = json['tsR_Charges'];
    valuationCharges = json['valuation_Charges'];
    noOfDocument = json['noOfDocument'];
    productValidateFromDate = json['product_Validate_From_date'];
    productValidateToDate = json['product_Validate_To_date'];
    ksdplProductId = json['ksdplProductId'];
    profitPercentage = json['profit_Percentage'];
    bankName = json['bankName'];
    productSegment = json['productSegment'];
    ksdplProduct = json['ksdplProduct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bankId'] = this.bankId;
    data['bankers_Name'] = this.bankersName;
    data['bankers_Mobile_Number'] = this.bankersMobileNumber;
    data['bankers_WhatsApp_Number'] = this.bankersWhatsAppNumber;
    data['bankers_email_ID'] = this.bankersEmailID;
    data['min_CIBIL'] = this.minCIBIL;
    data['segment_Vertical'] = this.segmentVertical;
    data['product'] = this.product;
    data['productDescription'] = this.productDescription;
    data['customer_Category'] = this.customerCategory;
    data['collateral_Security_Category'] = this.collateralSecurityCategory;
    data['collateral_Security_Excluded'] = this.collateralSecurityExcluded;
    data['income_Types'] = this.incomeTypes;
    data['profile_Excluded'] = this.profileExcluded;
    data['age_limit_Earning_Applicants'] = this.ageLimitEarningApplicants;
    data['age_limit_Non_Earning_Co_Applicant'] =
        this.ageLimitNonEarningCoApplicant;
    data['minimum_age_earning_applicants'] = this.minimumAgeEarningApplicants;
    data['minimum_age_non_earning_applicants'] =
        this.minimumAgeNonEarningApplicants;
    data['minimum_Income_Criteria'] = this.minimumIncomeCriteria;
    data['minimum_Loan_Amount'] = this.minimumLoanAmount;
    data['maximum_Loan_Amount'] = this.maximumLoanAmount;
    data['min_Tenor'] = this.minTenor;
    data['maximum_Tenor'] = this.maximumTenor;
    data['minimum_ROI'] = this.minimumROI;
    data['maximum_ROI'] = this.maximumROI;
    data['maximum_Tenor_Eligibility_Criteria'] =
        this.maximumTenorEligibilityCriteria;
    data['geo_Limit'] = this.geoLimit;
    data['negative_Profiles'] = this.negativeProfiles;
    data['negative_Areas'] = this.negativeAreas;
    data['maximum_TAT'] = this.maximumTAT;
    data['minimum_Property_Value'] = this.minimumPropertyValue;
    data['maximum_IIR'] = this.maximumIIR;
    data['maximum_FOIR'] = this.maximumFOIR;
    data['maximum_LTV'] = this.maximumLTV;
    data['processing_Fee'] = this.processingFee;
    data['legal_Fee'] = this.legalFee;
    data['technical_Fee'] = this.technicalFee;
    data['admin_Fee'] = this.adminFee;
    data['foreclosure_Charges'] = this.foreclosureCharges;
    data['other_Charges'] = this.otherCharges;
    data['stamp_Duty'] = this.stampDuty;
    data['tsR_Years'] = this.tsRYears;
    data['tsR_Charges'] = this.tsRCharges;
    data['valuation_Charges'] = this.valuationCharges;
    data['noOfDocument'] = this.noOfDocument;
    data['product_Validate_From_date'] = this.productValidateFromDate;
    data['product_Validate_To_date'] = this.productValidateToDate;
    data['ksdplProductId'] = this.ksdplProductId;
    data['profit_Percentage'] = this.profitPercentage;
    data['bankName'] = this.bankName;
    data['productSegment'] = this.productSegment;
    data['ksdplProduct'] = this.ksdplProduct;
    return data;
  }

  Data copyWith({
    String? bankersName,
    String? bankersMobileNumber,
    String? bankersWhatsAppNumber,
    String? bankersEmailID,
    String? customerCategory,
    String? ksdplProduct,
    String? incomeTypes,
  }) {
    return Data(
      id: id,
      bankId: bankId,
      bankersName: bankersName ?? this.bankersName,
      bankersMobileNumber: bankersMobileNumber ?? this.bankersMobileNumber,
      bankersWhatsAppNumber: bankersWhatsAppNumber ?? this.bankersWhatsAppNumber,
      bankersEmailID: bankersEmailID ?? this.bankersEmailID,
      customerCategory: customerCategory ?? this.customerCategory,
      ksdplProduct: ksdplProduct ?? this.ksdplProduct,
      incomeTypes: incomeTypes ?? this.incomeTypes,
      // keep the rest same
      minCIBIL: minCIBIL,
      segmentVertical: segmentVertical,
      product: product,
      productDescription: productDescription,
      collateralSecurityCategory: collateralSecurityCategory,
      collateralSecurityExcluded: collateralSecurityExcluded,
      profileExcluded: profileExcluded,
      ageLimitEarningApplicants: ageLimitEarningApplicants,
      ageLimitNonEarningCoApplicant: ageLimitNonEarningCoApplicant,
      minimumAgeEarningApplicants: minimumAgeEarningApplicants,
      minimumAgeNonEarningApplicants: minimumAgeNonEarningApplicants,
      minimumIncomeCriteria: minimumIncomeCriteria,
      minimumLoanAmount: minimumLoanAmount,
      maximumLoanAmount: maximumLoanAmount,
      minTenor: minTenor,
      maximumTenor: maximumTenor,
      minimumROI: minimumROI,
      maximumROI: maximumROI,
      maximumTenorEligibilityCriteria: maximumTenorEligibilityCriteria,
      geoLimit: geoLimit,
      negativeProfiles: negativeProfiles,
      negativeAreas: negativeAreas,
      maximumTAT: maximumTAT,
      minimumPropertyValue: minimumPropertyValue,
      maximumIIR: maximumIIR,
      maximumFOIR: maximumFOIR,
      maximumLTV: maximumLTV,
      processingFee: processingFee,
      legalFee: legalFee,
      technicalFee: technicalFee,
      adminFee: adminFee,
      foreclosureCharges: foreclosureCharges,
      otherCharges: otherCharges,
      stampDuty: stampDuty,
      tsRYears: tsRYears,
      tsRCharges: tsRCharges,
      valuationCharges: valuationCharges,
      noOfDocument: noOfDocument,
      productValidateFromDate: productValidateFromDate,
      productValidateToDate: productValidateToDate,
      ksdplProductId: ksdplProductId,
      profitPercentage: profitPercentage,
      bankName: bankName,
      productSegment: productSegment,
      autoindividual: autoindividual,
    );
  }

}

