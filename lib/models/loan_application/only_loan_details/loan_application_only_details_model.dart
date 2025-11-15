/*
import 'dart:convert';

class LoanApplicationDetailsOnlyModel {
  int? id;
  String? loanApplicationNo;
  String? addharCardNumber;
  String? panCardNumber;

  DetailForLoanApplication? detailForLoanApplication;
  List<CoApplicant> coApplicants = [];
  LoanPropertyDetails? loanDetails;
  List<FamilyMember> familyMembers = [];
  List<CreditCard> creditCards = [];
  FinancialDetails? financialDetails;
  List<ReferenceDetail> referenceDetails = [];
  ChargesDetails? chargesDetails;

  LoanApplicationDetailsOnlyModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"];

    id = data["id"];
    loanApplicationNo = data["loanApplicationNo"];
    addharCardNumber = data["addharCardNumber"];
    panCardNumber = data["panCardNumber"];

    // Decode stringified JSON
    detailForLoanApplication = DetailForLoanApplication.fromJson(
      jsonDecode(data["detailForLoanApplication"]),
    );

    coApplicants = (jsonDecode(data["coApplicantDetail"]) as List)
        .map((e) => CoApplicant.fromJson(e))
        .toList();

    loanDetails = LoanPropertyDetails.fromJson(
      jsonDecode(data["loanDetails"]),
    );

    familyMembers = (jsonDecode(data["familyMembers"]) as List)
        .map((e) => FamilyMember.fromJson(e))
        .toList();

    creditCards = (jsonDecode(data["creditCards"]) as List)
        .map((e) => CreditCard.fromJson(e))
        .toList();

    financialDetails =
        FinancialDetails.fromJson(jsonDecode(data["financialDetails"]));

    referenceDetails = (jsonDecode(data["referenceDetails"]) as List)
        .map((e) => ReferenceDetail.fromJson(e))
        .toList();

    chargesDetails =
        ChargesDetails.fromJson(jsonDecode(data["chargesDetails"]));
  }
}
class DetailForLoanApplication {
  int? branch;
  String? loanApplicationNo;
  String? loanPurpose;
  String? scheme;
  String? repaymentType;
  String? typeOfLoan;

  Applicant? applicant;

  DetailForLoanApplication.fromJson(Map<String, dynamic> json) {
    branch = json["Branch"];
    loanApplicationNo = json["LoanApplicationNo"];
    loanPurpose = json["LoanPurpose"];
    scheme = json["Scheme"];
    repaymentType = json["RepaymentType"];
    typeOfLoan = json["TypeOfLoan"];

    applicant = Applicant.fromJson(json["Applicant"]);
  }
}
class Applicant {
  String? name;
  String? fatherName;
  String? gender;
  String? qualification;
  String? maritalStatus;
  String? occupationSector;
  String? email;
  String? mobile;

  Address? presentAddress;
  Address? permanentAddress;

  Applicant.fromJson(Map<String, dynamic> json) {
    name = json["Name"];
    fatherName = json["FatherName"];
    gender = json["Gender"];
    qualification = json["Qualification"];
    maritalStatus = json["MaritalStatus"];
    occupationSector = json["OccupationSector"];
    email = json["EmailID"];
    mobile = json["Mobile"];
    presentAddress = Address.fromJson(json["PresentAddress"]);
    permanentAddress = Address.fromJson(json["PermanentAddress"]);
  }
}
class Address {
  String? houseFlatNo;
  String? societyName;
  String? city;
  String? state;
  String? pinCode;

  Address.fromJson(Map<String, dynamic> json) {
    houseFlatNo = json["HouseFlatNo"];
    societyName = json["SocietyName"];
    city = json["City"];
    state = json["State"];
    pinCode = json["PinCode"].toString();
  }
}
class CoApplicant {
  String? name;
  String? fatherName;
  String? gender;
  String? maritalStatus;
  String? qualification;
  String? mobile;

  Address? presentAddress;

  CoApplicant.fromJson(Map<String, dynamic> json) {
    name = json["Name"];
    fatherName = json["FatherName"];
    gender = json["Gender"];
    maritalStatus = json["MaritalStatus"];
    qualification = json["Qualification"];
    mobile = json["Mobile"];
    presentAddress = Address.fromJson(json["PresentAddress"]);
  }
}
class LoanPropertyDetails {
  String? propertyId;
  String? finalPlotNo;
  String? flatHouseNo;
  String? city;

  LoanPropertyDetails.fromJson(Map<String, dynamic> json) {
    propertyId = json["PropertyId"];
    finalPlotNo = json["FinalPlotNo"];
    flatHouseNo = json["FlatHouseNo"];
    city = json["City"];
  }
}
class FamilyMember {
  String? name;
  String? gender;
  String? relation;
  bool? dependent;
  int? monthlyIncome;

  FamilyMember.fromJson(Map<String, dynamic> json) {
    name = json["Name"];
    gender = json["Gender"];
    relation = json["RelationWithApplicant"];
    dependent = json["Dependent"];
    monthlyIncome = json["MonthlyIncome"];
  }
}
class CreditCard {
  String? companyBank;
  String? cardNumber;
  int? avgMonthlySpending;

  CreditCard.fromJson(Map<String, dynamic> json) {
    companyBank = json["CompanyBank"];
    cardNumber = json["CardNumber"];
    avgMonthlySpending = json["AvgMonthlySpending"];
  }
}
class FinancialDetails {
  int? grossMonthlySalary;
  int? netMonthlySalary;

  FinancialDetails.fromJson(Map<String, dynamic> json) {
    grossMonthlySalary = json["GrossMonthlySalary"];
    netMonthlySalary = json["NetMonthlySalary"];
  }
}
class ReferenceDetail {
  String? name;
  String? address;
  String? phone;

  ReferenceDetail.fromJson(Map<String, dynamic> json) {
    name = json["Name"];
    address = json["Address"];
    phone = json["Phone"];
  }
}
class ChargesDetails {
  int? processingFees;
  int? adminFeeCharges;

  ChargesDetails.fromJson(Map<String, dynamic> json) {
    processingFees = json["ProcessingFees"];
    adminFeeCharges = json["AdminFeeCharges"];
  }
}
*/


// loan_application_models.dart
import 'dart:convert';

/// Helper to safely decode a JSON string or return the original object if already decoded.
dynamic _safeDecode(dynamic value) {
  if (value == null) return null;
  if (value is String) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;
    try {
      return jsonDecode(trimmed);
    } catch (e) {
      // not a json string, return original string
      return value;
    }
  }
  return value;
}

/// Top-level API response
class LoanApplicationDetailsOnlyModel {
  final String? status;
  final bool? success;
  final LoanData? data;
  final String? message;

  LoanApplicationDetailsOnlyModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  factory LoanApplicationDetailsOnlyModel.fromJson(Map<String, dynamic> json) {
    return LoanApplicationDetailsOnlyModel(
      status: json['status']?.toString(),
      success: json['success'] is bool ? json['success'] : (json['success'] == 'true' || json['success'] == 1),
      data: json['data'] != null ? LoanData.fromJson(json['data'] as Map<String, dynamic>) : null,
      message: json['message']?.toString(),
    );
  }
}

/// Main data object (the "data" field in API)
class LoanData {
  int? id;
  String? dsaCode;
  String? loanApplicationNo;
  int? bankId;
  int? branchId;
  int? typeOfLoan;
  num? loanAmountApplied;

  // Stringified JSON fields
  DetailForLoanApplication? detailForLoanApplication;
  List<CoApplicant> coApplicants = [];
  LoanPropertyDetails? loanDetails;
  List<FamilyMember> familyMembers = [];
  List<CreditCard> creditCards = [];
  FinancialDetails? financialDetails;
  List<ReferenceDetail> referenceDetails = [];
  ChargesDetails? chargesDetails;

  // other simple fields
  String? addharCardNumber;
  String? panCardNumber;
  String? uniqueLeadNumber;
  int? channelId;
  String? channelCode;
  String? bankerName;
  String? bankerMobile;
  String? bankerWatsapp;
  String? bankerEmail;

  // created fields / metadata
  String? createdBy;
  String? createdName;
  String? createdPhoneNumber;

  LoanData();

  factory LoanData.fromJson(Map<String, dynamic> json) {
    final obj = LoanData();

    obj.id = json['id'] is int ? json['id'] as int : (json['id'] != null ? int.tryParse(json['id'].toString()) : null);
    obj.dsaCode = json['dsaCode']?.toString();
    obj.loanApplicationNo = json['loanApplicationNo']?.toString();
    obj.bankId = json['bankId'] is int ? json['bankId'] as int : (json['bankId'] != null ? int.tryParse(json['bankId'].toString()) : null);
    obj.branchId = json['branchId'] is int ? json['branchId'] as int : (json['branchId'] != null ? int.tryParse(json['branchId'].toString()) : null);
    obj.typeOfLoan = json['typeOfLoan'] is int ? json['typeOfLoan'] as int : (json['typeOfLoan'] != null ? int.tryParse(json['typeOfLoan'].toString()) : null);
    obj.loanAmountApplied = json['loanAmountApplied'] is num ? json['loanAmountApplied'] as num : (json['loanAmountApplied'] != null ? num.tryParse(json['loanAmountApplied'].toString()) : null);

    obj.addharCardNumber = json['addharCardNumber']?.toString();
    obj.panCardNumber = json['panCardNumber']?.toString();
    obj.uniqueLeadNumber = json['uniqueLeadNumber']?.toString();
    obj.channelId = json['channelId'] is int ? json['channelId'] as int : (json['channelId'] != null ? int.tryParse(json['channelId'].toString()) : null);
    obj.channelCode = json['channelCode']?.toString();
    obj.bankerName = json['bankerName']?.toString();
    obj.bankerMobile = json['bankerMobile']?.toString();
    obj.bankerWatsapp = json['bankerWatsapp']?.toString();
    obj.bankerEmail = json['bankerEmail']?.toString();

    obj.createdBy = json['createdBy']?.toString();
    obj.createdName = json['createdName']?.toString();
    obj.createdPhoneNumber = json['createdPhoneNumber']?.toString();

    // ----- Now decode nested/stringified fields safely -----

    // detailForLoanApplication (object)
    final dfaRaw = _safeDecode(json['detailForLoanApplication']);
    if (dfaRaw != null && dfaRaw is Map<String, dynamic>) {
      obj.detailForLoanApplication = DetailForLoanApplication.fromJson(dfaRaw);
    }

    // coApplicantDetail (array)
    final coRaw = _safeDecode(json['coApplicantDetail']);
    if (coRaw != null && coRaw is List) {
      obj.coApplicants = coRaw.map((e) {
        if (e is Map<String, dynamic>) return CoApplicant.fromJson(e);
        if (e is String) {
          try {
            final m = jsonDecode(e);
            if (m is Map<String, dynamic>) return CoApplicant.fromJson(m);
          } catch (_) {}
        }
        return CoApplicant(); // fallback empty
      }).toList();
    }

    // loanDetails (object)
    final loanDetailsRaw = _safeDecode(json['loanDetails']);
    if (loanDetailsRaw != null && loanDetailsRaw is Map<String, dynamic>) {
      obj.loanDetails = LoanPropertyDetails.fromJson(loanDetailsRaw);
    }

    // familyMembers (array)
    final famRaw = _safeDecode(json['familyMembers']);
    if (famRaw != null && famRaw is List) {
      obj.familyMembers = famRaw.map((e) {
        if (e is Map<String, dynamic>) return FamilyMember.fromJson(e);
        return FamilyMember();
      }).toList();
    }

    // creditCards (array)
    final ccRaw = _safeDecode(json['creditCards']);
    if (ccRaw != null && ccRaw is List) {
      obj.creditCards = ccRaw.map((e) {
        if (e is Map<String, dynamic>) return CreditCard.fromJson(e);
        return CreditCard();
      }).toList();
    }

    // financialDetails (object)
    final finRaw = _safeDecode(json['financialDetails']);
    if (finRaw != null && finRaw is Map<String, dynamic>) {
      obj.financialDetails = FinancialDetails.fromJson(finRaw);
    }

    // referenceDetails (array)
    final refRaw = _safeDecode(json['referenceDetails']);
    if (refRaw != null && refRaw is List) {
      obj.referenceDetails = refRaw.map((e) {
        if (e is Map<String, dynamic>) return ReferenceDetail.fromJson(e);
        return ReferenceDetail();
      }).toList();
    }

    // chargesDetails (object)
    final chRaw = _safeDecode(json['chargesDetails']);
    if (chRaw != null && chRaw is Map<String, dynamic>) {
      obj.chargesDetails = ChargesDetails.fromJson(chRaw);
    }

    return obj;
  }
}

/// ------------ Sub-models ------------

class DetailForLoanApplication {
  int? branch;
  String? dsaStaffName;
  String? loanApplicationNo;
  num? processingFee;
  String? chqDdSlipNo;
  String? loanPurpose;
  String? scheme;
  String? repaymentType;
  String? typeOfLoan;
  num? loanAmountApplied;
  num? loanTenureYears;
  Applicant? applicant;

  DetailForLoanApplication();

  factory DetailForLoanApplication.fromJson(Map<String, dynamic> json) {
    final obj = DetailForLoanApplication();
    obj.branch = json['Branch'] is int ? json['Branch'] as int : (json['Branch'] != null ? int.tryParse(json['Branch'].toString()) : null);
    obj.dsaStaffName = json['DsaStaffName']?.toString();
    obj.loanApplicationNo = json['LoanApplicationNo']?.toString();
    obj.processingFee = json['ProcessingFee'] is num ? json['ProcessingFee'] as num : (json['ProcessingFee'] != null ? num.tryParse(json['ProcessingFee'].toString()) : null);
    obj.chqDdSlipNo = json['ChqDdSlipNo']?.toString();
    obj.loanPurpose = json['LoanPurpose']?.toString();
    obj.scheme = json['Scheme']?.toString();
    obj.repaymentType = json['RepaymentType']?.toString();
    obj.typeOfLoan = json['TypeOfLoan']?.toString();
    obj.loanAmountApplied = json['LoanAmountApplied'] is num ? json['LoanAmountApplied'] as num : (json['LoanAmountApplied'] != null ? num.tryParse(json['LoanAmountApplied'].toString()) : null);
    obj.loanTenureYears = json['LoanTenureYears'] is num ? json['LoanTenureYears'] as num : (json['LoanTenureYears'] != null ? num.tryParse(json['LoanTenureYears'].toString()) : null);

    if (json['Applicant'] != null && json['Applicant'] is Map<String, dynamic>) {
      obj.applicant = Applicant.fromJson(json['Applicant'] as Map<String, dynamic>);
    }
    return obj;
  }
}

class Applicant {
  String? name;
  String? fatherName;
  String? gender;
  DateTime? dateOfBirth;
  String? qualification;
  String? maritalStatus;
  String? status;
  String? nationality;
  String? occupation;
  String? occupationSector;
  Address? presentAddress;
  Address? permanentAddress;
  String? email;
  String? mobile;
  EmployerDetails? employerDetails;

  Applicant();

  factory Applicant.fromJson(Map<String, dynamic> json) {
    final obj = Applicant();
    obj.name = json['Name']?.toString();
    obj.fatherName = json['FatherName']?.toString();
    obj.gender = json['Gender']?.toString();
    if (json['DateOfBirth'] != null) {
      try {
        obj.dateOfBirth = DateTime.parse(json['DateOfBirth'].toString());
      } catch (_) {}
    }
    obj.qualification = json['Qualification']?.toString();
    obj.maritalStatus = json['MaritalStatus']?.toString();
    obj.maritalStatus = json['status']?.toString();
    obj.nationality = json['Nationality']?.toString();
    obj.occupation = json['Occupation']?.toString();
    obj.occupationSector = json['OccupationSector']?.toString();
    if (json['PresentAddress'] != null && json['PresentAddress'] is Map<String, dynamic>) {
      obj.presentAddress = Address.fromJson(json['PresentAddress'] as Map<String, dynamic>);
    }
    if (json['PermanentAddress'] != null && json['PermanentAddress'] is Map<String, dynamic>) {
      obj.permanentAddress = Address.fromJson(json['PermanentAddress'] as Map<String, dynamic>);
    }
    obj.email = json['EmailID']?.toString();
    obj.mobile = json['Mobile']?.toString();
    if (json['EmployerDetails'] != null && json['EmployerDetails'] is Map<String, dynamic>) {
      obj.employerDetails = EmployerDetails.fromJson(json['EmployerDetails'] as Map<String, dynamic>);
    }
    return obj;
  }
}

class EmployerDetails {
  String? organizationName;
  String? ownershipType;
  String? natureOfBusiness;
  int? staffStrength;
  DateTime? dateOfSalary;
  EmployerDetails();

  factory EmployerDetails.fromJson(Map<String, dynamic> json) {
    final obj = EmployerDetails();
    obj.organizationName = json['OrganizationName']?.toString();
    obj.ownershipType = json['OwnershipType']?.toString();
    obj.natureOfBusiness = json['NatureOfBusiness']?.toString();
    obj.staffStrength = json['StaffStrength'] is int ? json['StaffStrength'] as int : (json['StaffStrength'] != null ? int.tryParse(json['StaffStrength'].toString()) : null);

    // NEW: date of salary (safe DateTime parsing)
    obj.dateOfSalary = json['DateOfSalary'] != null &&
        json['DateOfSalary'].toString().isNotEmpty
        ? DateTime.tryParse(json['DateOfSalary'].toString())
        : null;
    return obj;
  }
}

class Address {
  String? houseFlatNo;
  String? buildingNo;
  String? societyName;
  String? locality;
  String? streetName;
  String? city;
  String? taluka;
  String? district;
  String? state;
  String? country;
  String? pinCode;

  Address();

  factory Address.fromJson(Map<String, dynamic> json) {
    final obj = Address();
    obj.houseFlatNo = json['HouseFlatNo']?.toString();
    obj.buildingNo = json['BuildingNo']?.toString();
    obj.societyName = json['SocietyName']?.toString();
    obj.locality = json['Locality']?.toString();
    obj.streetName = json['StreetName']?.toString();
    obj.city = json['City']?.toString();
    obj.taluka = json['Taluka']?.toString();
    obj.district = json['District']?.toString();
    obj.state = json['State']?.toString();
    obj.country = json['Country']?.toString();
    obj.pinCode = json['PinCode']?.toString();
    return obj;
  }
}

class CoApplicant {
  String? name;
  String? fatherName;
  String? gender;
  DateTime? dateOfBirth;
  String? qualification;
  String? maritalStatus;
  String? status;
  String? nationality;
  String? occupation;
  String? occupationSector;
  Address? presentAddress;
  Address? permanentAddress;
  String? email;
  String? mobile;
  EmployerDetails? employerDetails;

  CoApplicant();

  factory CoApplicant.fromJson(Map<String, dynamic> json) {
    final obj = CoApplicant();
    obj.name = json['Name']?.toString();
    obj.fatherName = json['FatherName']?.toString();
    obj.gender = json['Gender']?.toString();
    if (json['DateOfBirth'] != null) {
      try {
        obj.dateOfBirth = DateTime.parse(json['DateOfBirth'].toString());
      } catch (_) {}
    }
    obj.qualification = json['Qualification']?.toString();
    obj.maritalStatus = json['MaritalStatus']?.toString();
    obj.status = json['Status']?.toString();
    obj.nationality = json['Nationality']?.toString();
    obj.occupation = json['Occupation']?.toString();
    obj.occupationSector = json['OccupationSector']?.toString();
    if (json['PresentAddress'] != null && json['PresentAddress'] is Map<String, dynamic>) {
      obj.presentAddress = Address.fromJson(json['PresentAddress'] as Map<String, dynamic>);
    }
    if (json['PermanentAddress'] != null && json['PermanentAddress'] is Map<String, dynamic>) {
      obj.permanentAddress = Address.fromJson(json['PermanentAddress'] as Map<String, dynamic>);
    }
    obj.email = json['EmailID']?.toString();
    obj.mobile = json['Mobile']?.toString();
    if (json['EmployerDetails'] != null && json['EmployerDetails'] is Map<String, dynamic>) {
      obj.employerDetails = EmployerDetails.fromJson(json['EmployerDetails'] as Map<String, dynamic>);
    }
    return obj;
  }
}

class LoanPropertyDetails {
  String? propertyId;
  String? surveyNo;
  String? finalPlotNo;
  String? blockNo;
  String? flatHouseNo;
  String? societyBuildingName;
  String? streetName;
  String? locality;
  String? city;
  String? taluka;
  String? district;
  String? state;
  String? pincode;

  LoanPropertyDetails();

  factory LoanPropertyDetails.fromJson(Map<String, dynamic> json) {
    final obj = LoanPropertyDetails();
    obj.propertyId = json['PropertyId']?.toString();
    obj.surveyNo = json['SurveyNo']?.toString();
    obj.finalPlotNo = json['FinalPlotNo']?.toString();
    obj.blockNo = json['BlockNo']?.toString();
    obj.flatHouseNo = json['FlatHouseNo']?.toString();
    obj.societyBuildingName = json['SocietyBuildingName']?.toString();
    obj.streetName = json['StreetName']?.toString();
    obj.locality = json['Locality']?.toString();
    obj.city = json['City']?.toString();
    obj.taluka = json['Taluka']?.toString();
    obj.district = json['District']?.toString();
    obj.state = json['State']?.toString();
    obj.pincode = json['Pincode']?.toString();
    return obj;
  }
}

class FamilyMember {
  String? name;
  DateTime? birthDate;
  String? gender;
  String? relationWithApplicant;
  bool? dependent;
  num? monthlyIncome;
  String? employedWith;

  FamilyMember();

  factory FamilyMember.fromJson(Map<String, dynamic> json) {
    final obj = FamilyMember();
    obj.name = json['Name']?.toString();
    if (json['BirthDate'] != null) {
      try {
        obj.birthDate = DateTime.parse(json['BirthDate'].toString());
      } catch (_) {}
    }
    obj.gender = json['Gender']?.toString();
    obj.relationWithApplicant = json['RelationWithApplicant']?.toString();
    obj.dependent = json['Dependent'] is bool ? json['Dependent'] as bool : (json['Dependent'] != null ? (json['Dependent'].toString().toLowerCase() == 'true') : null);
    obj.monthlyIncome = json['MonthlyIncome'] is num ? json['MonthlyIncome'] as num : (json['MonthlyIncome'] != null ? num.tryParse(json['MonthlyIncome'].toString()) : null);
    obj.employedWith = json['EmployedWith']?.toString();
    return obj;
  }
}

class CreditCard {
  String? companyBank;
  String? cardNumber;
  DateTime? havingSince;
  num? avgMonthlySpending;

  CreditCard();

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    final obj = CreditCard();
    obj.companyBank = json['CompanyBank']?.toString();
    obj.cardNumber = json['CardNumber']?.toString();
    if (json['HavingSince'] != null) {
      try {
        obj.havingSince = DateTime.parse(json['HavingSince'].toString());
      } catch (_) {}
    }
    obj.avgMonthlySpending = json['AvgMonthlySpending'] is num ? json['AvgMonthlySpending'] as num : (json['AvgMonthlySpending'] != null ? num.tryParse(json['AvgMonthlySpending'].toString()) : null);
    return obj;
  }
}

class FinancialDetails {
  num? grossMonthlySalary;
  num? netMonthlySalary;
  num? annualBonus;
  num? avgMonthlyOvertime;
  num? avgMonthlyCommission;
  num? monthlyPFDeduction;
  num? otherMonthlyIncome;

  FinancialDetails();

  factory FinancialDetails.fromJson(Map<String, dynamic> json) {
    final obj = FinancialDetails();
    obj.grossMonthlySalary = json['GrossMonthlySalary'] is num ? json['GrossMonthlySalary'] as num : (json['GrossMonthlySalary'] != null ? num.tryParse(json['GrossMonthlySalary'].toString()) : null);
    obj.netMonthlySalary = json['NetMonthlySalary'] is num ? json['NetMonthlySalary'] as num : (json['NetMonthlySalary'] != null ? num.tryParse(json['NetMonthlySalary'].toString()) : null);
    obj.annualBonus = json['AnnualBonus'] is num ? json['AnnualBonus'] as num : (json['AnnualBonus'] != null ? num.tryParse(json['AnnualBonus'].toString()) : null);
    obj.avgMonthlyOvertime = json['AvgMonthlyOvertime'] is num ? json['AvgMonthlyOvertime'] as num : (json['AvgMonthlyOvertime'] != null ? num.tryParse(json['AvgMonthlyOvertime'].toString()) : null);
    obj.avgMonthlyCommission = json['AvgMonthlyCommission'] is num ? json['AvgMonthlyCommission'] as num : (json['AvgMonthlyCommission'] != null ? num.tryParse(json['AvgMonthlyCommission'].toString()) : null);
    obj.monthlyPFDeduction = json['MonthlyPFDeduction'] is num ? json['MonthlyPFDeduction'] as num : (json['MonthlyPFDeduction'] != null ? num.tryParse(json['MonthlyPFDeduction'].toString()) : null);
    obj.otherMonthlyIncome = json['OtherMonthlyIncome'] is num ? json['OtherMonthlyIncome'] as num : (json['OtherMonthlyIncome'] != null ? num.tryParse(json['OtherMonthlyIncome'].toString()) : null);
    return obj;
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

  ReferenceDetail();

  factory ReferenceDetail.fromJson(Map<String, dynamic> json) {
    final obj = ReferenceDetail();
    obj.name = json['Name']?.toString();
    obj.address = json['Address']?.toString();
    obj.city = json['City']?.toString();
    obj.district = json['District']?.toString();
    obj.state = json['State']?.toString();
    obj.country = json['Country']?.toString();
    obj.pinCode = json['PinCode']?.toString();
    obj.phone = json['Phone']?.toString();
    obj.mobile = json['Mobile']?.toString();
    obj.relationWithApplicant = json['RelationWithApplicant']?.toString();
    return obj;
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

  ChargesDetails();

  factory ChargesDetails.fromJson(Map<String, dynamic> json) {
    final obj = ChargesDetails();
    obj.processingFees = json['ProcessingFees'] is num ? json['ProcessingFees'] as num : (json['ProcessingFees'] != null ? num.tryParse(json['ProcessingFees'].toString()) : null);
    obj.adminFeeCharges = json['AdminFeeCharges'] is num ? json['AdminFeeCharges'] as num : (json['AdminFeeCharges'] != null ? num.tryParse(json['AdminFeeCharges'].toString()) : null);
    obj.foreclosureChargesCharges = json['ForeclosureChargesCharges'] is num ? json['ForeclosureChargesCharges'] as num : (json['ForeclosureChargesCharges'] != null ? num.tryParse(json['ForeclosureChargesCharges'].toString()) : null);
    obj.stampDutyPercentage = json['StampDutyPercentage'] is num ? json['StampDutyPercentage'] as num : (json['StampDutyPercentage'] != null ? num.tryParse(json['StampDutyPercentage'].toString()) : null);
    obj.legalVettingCharges = json['LegalVettingCharges'] is num ? json['LegalVettingCharges'] as num : (json['LegalVettingCharges'] != null ? num.tryParse(json['LegalVettingCharges'].toString()) : null);
    obj.technicalInspectionCharges = json['TechnicalInspectionCharges'] is num ? json['TechnicalInspectionCharges'] as num : (json['TechnicalInspectionCharges'] != null ? num.tryParse(json['TechnicalInspectionCharges'].toString()) : null);
    obj.otherCharges = json['OtherCharges'] is num ? json['OtherCharges'] as num : (json['OtherCharges'] != null ? num.tryParse(json['OtherCharges'].toString()) : null);
    obj.tsrLegalCharges = json['TsrLegalCharges'] is num ? json['TsrLegalCharges'] as num : (json['TsrLegalCharges'] != null ? num.tryParse(json['TsrLegalCharges'].toString()) : null);
    obj.valuationCharges = json['ValuationCharges'] is num ? json['ValuationCharges'] as num : (json['ValuationCharges'] != null ? num.tryParse(json['ValuationCharges'].toString()) : null);
    obj.processingCharges = json['ProcessingCharges'] is num ? json['ProcessingCharges'] as num : (json['ProcessingCharges'] != null ? num.tryParse(json['ProcessingCharges'].toString()) : null);
    return obj;
  }
}
