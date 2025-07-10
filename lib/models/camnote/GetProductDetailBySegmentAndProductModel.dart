class GetProductDetailBySegmentAndProductModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetProductDetailBySegmentAndProductModel(
      {this.status, this.success, this.data, this.message});

  GetProductDetailBySegmentAndProductModel.fromJson(Map<String, dynamic> json) {
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
  String? bankersName;
  String? bankersMobileNumber;
  String? bankersWhatsAppNumber;
  String? bankersEmailId;
  num? minCibil;
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
  num? minimumRoi;
  num? maximumRoi;
  num? maximumTenorEligibilityCriteria;
  String? geoLimit;
  String? negativeProfiles;
  String? negativeAreas;
  num? maximumTat;
  num? minimumPropertyValue;
  num? maximumIir;
  num? maximumFoir;
  num? maximumLtv;
  double? processingFee;
  num? legalFee;
  num? technicalFee;
  num? adminFee;
  num? foreclosureCharges;
  num? otherCharges;
  double? stampDuty;
  num? tsrYears;
  num? tsrCharges;
  num? valuationCharges;
  num? noOfDocument;
  Null? productValidateFromDate;
  Null? productValidateToDate;
  int? ksdplproductId;
  num? profitPercentage;
  bool? active;
  String? createdDate;
  String? createdBy;
  String? updatedDate;
  String? updatedBy;
  Null? deletedDate;
  Null? deletedBy;
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
        this.bankersName,
        this.bankersMobileNumber,
        this.bankersWhatsAppNumber,
        this.bankersEmailId,
        this.minCibil,
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
        this.minimumRoi,
        this.maximumRoi,
        this.maximumTenorEligibilityCriteria,
        this.geoLimit,
        this.negativeProfiles,
        this.negativeAreas,
        this.maximumTat,
        this.minimumPropertyValue,
        this.maximumIir,
        this.maximumFoir,
        this.maximumLtv,
        this.processingFee,
        this.legalFee,
        this.technicalFee,
        this.adminFee,
        this.foreclosureCharges,
        this.otherCharges,
        this.stampDuty,
        this.tsrYears,
        this.tsrCharges,
        this.valuationCharges,
        this.noOfDocument,
        this.productValidateFromDate,
        this.productValidateToDate,
        this.ksdplproductId,
        this.profitPercentage,
        this.active,
        this.createdDate,
        this.createdBy,
        this.updatedDate,
        this.updatedBy,
        this.deletedDate,
        this.deletedBy,
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
    id = json['id'];
    bankId = json['bankId'];
    bankersName = json['bankersName'];
    bankersMobileNumber = json['bankersMobileNumber'];
    bankersWhatsAppNumber = json['bankersWhatsAppNumber'];
    bankersEmailId = json['bankersEmailId'];
    minCibil = json['minCibil'];
    segmentVertical = json['segmentVertical'];
    product = json['product'];
    productDescription = json['productDescription'];
    customerCategory = json['customerCategory'];
    collateralSecurityCategory = json['collateralSecurityCategory'];
    collateralSecurityExcluded = json['collateralSecurityExcluded'];
    incomeTypes = json['incomeTypes'];
    profileExcluded = json['profileExcluded'];
    ageLimitEarningApplicants = json['ageLimitEarningApplicants'];
    ageLimitNonEarningCoApplicant = json['ageLimitNonEarningCoApplicant'];
    minimumAgeEarningApplicants = json['minimumAgeEarningApplicants'];
    minimumAgeNonEarningApplicants = json['minimumAgeNonEarningApplicants'];
    minimumIncomeCriteria = json['minimumIncomeCriteria'];
    minimumLoanAmount = json['minimumLoanAmount'];
    maximumLoanAmount = json['maximumLoanAmount'];
    minTenor = json['minTenor'];
    maximumTenor = json['maximumTenor'];
    minimumRoi = json['minimumRoi'];
    maximumRoi = json['maximumRoi'];
    maximumTenorEligibilityCriteria = json['maximumTenorEligibilityCriteria'];
    geoLimit = json['geoLimit'];
    negativeProfiles = json['negativeProfiles'];
    negativeAreas = json['negativeAreas'];
    maximumTat = json['maximumTat'];
    minimumPropertyValue = json['minimumPropertyValue'];
    maximumIir = json['maximumIir'];
    maximumFoir = json['maximumFoir'];
    maximumLtv = json['maximumLtv'];
    processingFee = json['processingFee'];
    legalFee = json['legalFee'];
    technicalFee = json['technicalFee'];
    adminFee = json['adminFee'];
    foreclosureCharges = json['foreclosureCharges'];
    otherCharges = json['otherCharges'];
    stampDuty = json['stampDuty'];
    tsrYears = json['tsrYears'];
    tsrCharges = json['tsrCharges'];
    valuationCharges = json['valuationCharges'];
    noOfDocument = json['noOfDocument'];
    productValidateFromDate = json['productValidateFromDate'];
    productValidateToDate = json['productValidateToDate'];
    ksdplproductId = json['ksdplproductId'];
    profitPercentage = json['profitPercentage'];
    active = json['active'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    updatedDate = json['updatedDate'];
    updatedBy = json['updatedBy'];
    deletedDate = json['deletedDate'];
    deletedBy = json['deletedBy'];
    processingCharges = json['processingCharges'];
    fromAmountRange = json['fromAmountRange'];
    toAmountRange = json['toAmountRange'];
    totalOverdueCases = json['totalOverdueCases'];
    totalOverdueAmount = json['totalOverdueAmount'];
    totalEnquiries = json['totalEnquiries'];
    superiorName = json['superiorName'];
    superiorMobileNo = json['superiorMobileNo'];
    superiorWhatsappNo = json['superiorWhatsappNo'];
    superiorEmail = json['superiorEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bankId'] = this.bankId;
    data['bankersName'] = this.bankersName;
    data['bankersMobileNumber'] = this.bankersMobileNumber;
    data['bankersWhatsAppNumber'] = this.bankersWhatsAppNumber;
    data['bankersEmailId'] = this.bankersEmailId;
    data['minCibil'] = this.minCibil;
    data['segmentVertical'] = this.segmentVertical;
    data['product'] = this.product;
    data['productDescription'] = this.productDescription;
    data['customerCategory'] = this.customerCategory;
    data['collateralSecurityCategory'] = this.collateralSecurityCategory;
    data['collateralSecurityExcluded'] = this.collateralSecurityExcluded;
    data['incomeTypes'] = this.incomeTypes;
    data['profileExcluded'] = this.profileExcluded;
    data['ageLimitEarningApplicants'] = this.ageLimitEarningApplicants;
    data['ageLimitNonEarningCoApplicant'] = this.ageLimitNonEarningCoApplicant;
    data['minimumAgeEarningApplicants'] = this.minimumAgeEarningApplicants;
    data['minimumAgeNonEarningApplicants'] =
        this.minimumAgeNonEarningApplicants;
    data['minimumIncomeCriteria'] = this.minimumIncomeCriteria;
    data['minimumLoanAmount'] = this.minimumLoanAmount;
    data['maximumLoanAmount'] = this.maximumLoanAmount;
    data['minTenor'] = this.minTenor;
    data['maximumTenor'] = this.maximumTenor;
    data['minimumRoi'] = this.minimumRoi;
    data['maximumRoi'] = this.maximumRoi;
    data['maximumTenorEligibilityCriteria'] =
        this.maximumTenorEligibilityCriteria;
    data['geoLimit'] = this.geoLimit;
    data['negativeProfiles'] = this.negativeProfiles;
    data['negativeAreas'] = this.negativeAreas;
    data['maximumTat'] = this.maximumTat;
    data['minimumPropertyValue'] = this.minimumPropertyValue;
    data['maximumIir'] = this.maximumIir;
    data['maximumFoir'] = this.maximumFoir;
    data['maximumLtv'] = this.maximumLtv;
    data['processingFee'] = this.processingFee;
    data['legalFee'] = this.legalFee;
    data['technicalFee'] = this.technicalFee;
    data['adminFee'] = this.adminFee;
    data['foreclosureCharges'] = this.foreclosureCharges;
    data['otherCharges'] = this.otherCharges;
    data['stampDuty'] = this.stampDuty;
    data['tsrYears'] = this.tsrYears;
    data['tsrCharges'] = this.tsrCharges;
    data['valuationCharges'] = this.valuationCharges;
    data['noOfDocument'] = this.noOfDocument;
    data['productValidateFromDate'] = this.productValidateFromDate;
    data['productValidateToDate'] = this.productValidateToDate;
    data['ksdplproductId'] = this.ksdplproductId;
    data['profitPercentage'] = this.profitPercentage;
    data['active'] = this.active;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['updatedDate'] = this.updatedDate;
    data['updatedBy'] = this.updatedBy;
    data['deletedDate'] = this.deletedDate;
    data['deletedBy'] = this.deletedBy;
    data['processingCharges'] = this.processingCharges;
    data['fromAmountRange'] = this.fromAmountRange;
    data['toAmountRange'] = this.toAmountRange;
    data['totalOverdueCases'] = this.totalOverdueCases;
    data['totalOverdueAmount'] = this.totalOverdueAmount;
    data['totalEnquiries'] = this.totalEnquiries;
    data['superiorName'] = this.superiorName;
    data['superiorMobileNo'] = this.superiorMobileNo;
    data['superiorWhatsappNo'] = this.superiorWhatsappNo;
    data['superiorEmail'] = this.superiorEmail;
    return data;
  }
}
