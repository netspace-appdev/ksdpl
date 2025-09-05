
import 'dart:convert';

class GetLoanApplIdModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  GetLoanApplIdModel({this.status, this.success, this.data, this.message});

  GetLoanApplIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
  List<ReferenceDetail>? referenceDetails;
  int? channelId;
  String? channelCode;
  String? bankerName;
  String? bankerMobile;
  String? bankerWatsapp;
  String? bankerEmail;
  ChargesDetails?  chargesDetails;

  Data({
    this.id,
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
    this.bankerEmail,
    required this.chargesDetails,

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
    if (json['referenceDetails'] != null &&
        json['referenceDetails'].toString().isNotEmpty) {
      try {
        final parsed = jsonDecode(json['referenceDetails']);
        if (parsed is List) {
          referenceDetails =
              parsed.map((e) => ReferenceDetail.fromJson(e)).toList();
        }
      } catch (e) {
        referenceDetails = [];
      }
    }
    channelId = json['channelId'];
    channelCode = json['channelCode'];
    bankerName = json['bankerName'];
    bankerMobile = json['bankerMobile'];
    bankerWatsapp = json['bankerWatsapp'];
    bankerEmail = json['bankerEmail'];
    if (json['chargesDetails'] != null && json['chargesDetails'].toString().isNotEmpty) {
      chargesDetails = ChargesDetails.fromJson(jsonDecode(json['chargesDetails']));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
    if (referenceDetails != null) {
      data['referenceDetails'] =
          jsonEncode(referenceDetails!.map((e) => e.toJson()).toList());
    }
    data['channelId'] = this.channelId;
    data['channelCode'] = this.channelCode;
    data['bankerName'] = this.bankerName;
    data['bankerMobile'] = this.bankerMobile;
    data['bankerWatsapp'] = this.bankerWatsapp;
    data['bankerEmail'] = this.bankerEmail;
    if (this.chargesDetails != null) {
      data['chargesDetails'] = jsonEncode(this.chargesDetails!.toJson());
    }
    return data;
  }
}

class ReferenceDetail {
  String? name;
  String? address;
  String? city;
  String? district;
  String? state;
  String? country;
  String? pinCode;
  String? phone;
  String? mobile;
  String? relationWithApplicant;

  ReferenceDetail({
    this.name,
    this.address,
    this.city,
    this.district,
    this.state,
    this.country,
    this.pinCode,
    this.phone,
    this.mobile,
    this.relationWithApplicant,
  });

  factory ReferenceDetail.fromJson(Map<String, dynamic> json) {
    return ReferenceDetail(
      name: json['Name'],
      address: json['Address'],
      city: json['City'],
      district: json['District'],
      state: json['State'],
      country: json['Country'],
      pinCode: json['PinCode'],
      phone: json['Phone'],
      mobile: json['Mobile'],
      relationWithApplicant: json['RelationWithApplicant'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Address': address,
      'City': city,
      'District': district,
      'State': state,
      'Country': country,
      'PinCode': pinCode,
      'Phone': phone,
      'Mobile': mobile,
      'RelationWithApplicant': relationWithApplicant,
    };
  }
}



class ChargesDetails {
  num? processingFees;
  num? adminFeeCharges;
  num? foreclosureChargesCharges;
  num? stampDutyPercentage;
  num? legalVettingCharges;
  num? technicalInspectionCharges;
  num? otherCharges;
  num? tsrLegalCharges;
  num? valuationCharges;
  num? processingCharges;

  ChargesDetails({
    this.processingFees,
    this.adminFeeCharges,
    this.foreclosureChargesCharges,
    this.stampDutyPercentage,
    this.legalVettingCharges,
    this.technicalInspectionCharges,
    this.otherCharges,
    this.tsrLegalCharges,
    this.valuationCharges,
    this.processingCharges,
  });

  ChargesDetails.fromJson(Map<String, dynamic> json) {
    processingFees = json['ProcessingFees'];
    adminFeeCharges = json['AdminFeeCharges'];
    foreclosureChargesCharges = json['ForeclosureChargesCharges'];
    stampDutyPercentage = json['StampDutyPercentage'];
    legalVettingCharges = json['LegalVettingCharges'];
    technicalInspectionCharges = json['TechnicalInspectionCharges'];
    otherCharges = json['OtherCharges'];
    tsrLegalCharges = json['TsrLegalCharges'];
    valuationCharges = json['ValuationCharges'];
    processingCharges = json['ProcessingCharges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['ProcessingFees'] = processingFees;
    data['AdminFeeCharges'] = adminFeeCharges;
    data['ForeclosureChargesCharges'] = foreclosureChargesCharges;
    data['StampDutyPercentage'] = stampDutyPercentage;
    data['LegalVettingCharges'] = legalVettingCharges;
    data['TechnicalInspectionCharges'] = technicalInspectionCharges;
    data['OtherCharges'] = otherCharges;
    data['TsrLegalCharges'] = tsrLegalCharges;
    data['ValuationCharges'] = valuationCharges;
    data['ProcessingCharges'] = processingCharges;
    return data;
  }
}
