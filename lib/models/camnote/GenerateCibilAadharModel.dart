class GenerateCibilAadharModel {
  final String status;
  final bool success;
  final CreditReportData data;
  final String? message;

  GenerateCibilAadharModel({
    required this.status,
    required this.success,
    required this.data,
    this.message,
  });

  factory GenerateCibilAadharModel.fromMap(Map<String, dynamic> map) {
    return GenerateCibilAadharModel(
      status: map['status'],
      success: map['success'],
      data: CreditReportData.fromMap(map['data']),
      message: map['message'],
    );
  }
}

class CreditReportData {
  final int code;
  final int timestamp;
  final String transactionId;
  final String subCode;
  final String message;
  final CreditReportInnerData data;

  CreditReportData({
    required this.code,
    required this.timestamp,
    required this.transactionId,
    required this.subCode,
    required this.message,
    required this.data,
  });

  factory CreditReportData.fromMap(Map<String, dynamic> map) {
    return CreditReportData(
      code: map['code'],
      timestamp: map['timestamp'],
      transactionId: map['transaction_id'],
      subCode: map['sub_code'],
      message: map['message'],
      data: CreditReportInnerData.fromMap(map['data']),
    );
  }
}

class CreditReportInnerData {
  final String pan;
  final String mobile;
  final String name;
  final String creditScore;
  final String pdfUrl;
  final CreditReport creditReport;

  CreditReportInnerData({
    required this.pan,
    required this.mobile,
    required this.name,
    required this.creditScore,
    required this.pdfUrl,
    required this.creditReport,
  });

  factory CreditReportInnerData.fromMap(Map<String, dynamic> map) {
    return CreditReportInnerData(
      pan: map['pan'],
      mobile: map['mobile'],
      name: map['name'],
      creditScore: map['credit_score'],
      pdfUrl: map['pdf_url'],
      creditReport: CreditReport.fromMap(map['credit_report']),
    );
  }
}

class CreditReport {
  final InquiryResponseHeader inquiryResponseHeader;
  final dynamic inquiryRequestInfo;
  final List<Score> score;
  final CcrResponse ccrResponse;

  CreditReport({
    required this.inquiryResponseHeader,
    this.inquiryRequestInfo,
    required this.score,
    required this.ccrResponse,
  });

  factory CreditReport.fromMap(Map<String, dynamic> map) {
    return CreditReport(
      inquiryResponseHeader: InquiryResponseHeader.fromMap(map['inquiryResponseHeader']),
      inquiryRequestInfo: map['inquiryRequestInfo'],
      score: List<Score>.from(map['score']?.map((x) => Score.fromMap(x)) ?? []),
      ccrResponse: CcrResponse.fromMap(map['ccrResponse']),
    );
  }
}

class Score {
  final String type;
  final String version;

  Score({required this.type, required this.version});

  factory Score.fromMap(Map<String, dynamic> map) {
    return Score(
      type: map['type'],
      version: map['version'],
    );
  }
}

class CcrResponse {
  final dynamic status;
  final List<ReportDataList> cirReportDataLst;

  CcrResponse({this.status, required this.cirReportDataLst});

  factory CcrResponse.fromMap(Map<String, dynamic> map) {
    return CcrResponse(
      status: map['status'],
      cirReportDataLst: List<ReportDataList>.from(
        map['cirReportDataLst']?.map((x) => ReportDataList.fromMap(x)) ?? [],
      ),
    );
  }
}

class ReportDataList {
  final InquiryResponseHeader inquiryResponseHeader;
  final dynamic inquiryRequestInfo;
  final dynamic score;
  final CirReportData cirReportData;

  ReportDataList({
    required this.inquiryResponseHeader,
    this.inquiryRequestInfo,
    this.score,
    required this.cirReportData,
  });

  factory ReportDataList.fromMap(Map<String, dynamic> map) {
    return ReportDataList(
      inquiryResponseHeader: InquiryResponseHeader.fromMap(map['inquiryResponseHeader']),
      inquiryRequestInfo: map['inquiryRequestInfo'],
      score: map['score'],
      cirReportData: CirReportData.fromMap(map['cirReportData']),
    );
  }
}

class InquiryResponseHeader {
  final String? clientID;
  final String? custRefField;
  final String? reportOrderNO;
  final String? productCode;
  final String? successCode;
  final String? date;
  final String? time;
  final String? hitCode;
  final String? customerName;

  InquiryResponseHeader({
    this.clientID,
    this.custRefField,
    this.reportOrderNO,
    this.productCode,
    this.successCode,
    this.date,
    this.time,
    this.hitCode,
    this.customerName,
  });

  factory InquiryResponseHeader.fromMap(Map<String, dynamic> map) {
    return InquiryResponseHeader(
      clientID: map['clientID'],
      custRefField: map['custRefField'],
      reportOrderNO: map['reportOrderNO'],
      productCode: map['productCode'],
      successCode: map['successCode'],
      date: map['date'],
      time: map['time'],
      hitCode: map['hitCode'],
      customerName: map['customerName'],
    );
  }
}

class CirReportData {
  final IdAndContactInfo idAndContactInfo;
  final List<RetailAccountDetail> retailAccountDetails;

  CirReportData({
    required this.idAndContactInfo,
    required this.retailAccountDetails,
  });

  factory CirReportData.fromMap(Map<String, dynamic> map) {
    return CirReportData(
      idAndContactInfo: IdAndContactInfo.fromMap(map['idAndContactInfo']),
      retailAccountDetails: List<RetailAccountDetail>.from(
        map['retailAccountDetails']?.map((x) => RetailAccountDetail.fromMap(x)) ?? [],
      ),
    );
  }
}

class IdAndContactInfo {
  final PersonalInfo personalInfo;
  final IdentityInfo identityInfo;
  final List<AddressInfo> addressInfo;
  final List<PhoneInfo> phoneInfo;

  IdAndContactInfo({
    required this.personalInfo,
    required this.identityInfo,
    required this.addressInfo,
    required this.phoneInfo,
  });

  factory IdAndContactInfo.fromMap(Map<String, dynamic> map) {
    return IdAndContactInfo(
      personalInfo: PersonalInfo.fromMap(map['personalInfo']),
      identityInfo: IdentityInfo.fromMap(map['identityInfo']),
      addressInfo: List<AddressInfo>.from(
        map['addressInfo']?.map((x) => AddressInfo.fromMap(x)) ?? [],
      ),
      phoneInfo: List<PhoneInfo>.from(
        map['phoneInfo']?.map((x) => PhoneInfo.fromMap(x)) ?? [],
      ),
    );
  }
}

class PersonalInfo {
  final Name name;
  final String? aliasName;
  final String dateOfBirth;
  final String gender;
  final Age age;

  PersonalInfo({
    required this.name,
    this.aliasName,
    required this.dateOfBirth,
    required this.gender,
    required this.age,
  });

  factory PersonalInfo.fromMap(Map<String, dynamic> map) {
    return PersonalInfo(
      name: Name.fromMap(map['name']),
      aliasName: map['aliasName'],
      dateOfBirth: map['dateOfBirth'],
      gender: map['gender'],
      age: Age.fromMap(map['age']),
    );
  }
}

class Name {
  final String fullName;
  final String firstName;
  final String? middleName;
  final String lastName;

  Name({
    required this.fullName,
    required this.firstName,
    this.middleName,
    required this.lastName,
  });

  factory Name.fromMap(Map<String, dynamic> map) {
    return Name(
      fullName: map['fullName'],
      firstName: map['firstName'],
      middleName: map['middleName'],
      lastName: map['lastName'],
    );
  }
}

class Age {
  final String age;

  Age({required this.age});

  factory Age.fromMap(Map<String, dynamic> map) {
    return Age(age: map['age']);
  }
}

class IdentityInfo {
  final List<PanId> panId;

  IdentityInfo({required this.panId});

  factory IdentityInfo.fromMap(Map<String, dynamic> map) {
    return IdentityInfo(
      panId: List<PanId>.from(
        map['panId']?.map((x) => PanId.fromMap(x)) ?? [],
      ),
    );
  }
}

class PanId {
  final String seq;
  final String reportedDate;
  final String idNumber;

  PanId({
    required this.seq,
    required this.reportedDate,
    required this.idNumber,
  });

  factory PanId.fromMap(Map<String, dynamic> map) {
    return PanId(
      seq: map['seq'],
      reportedDate: map['reportedDate'],
      idNumber: map['idNumber'],
    );
  }
}

class AddressInfo {
  final String seq;
  final String reportedDate;
  final String address;
  final String state;
  final String postal;
  final String type;

  AddressInfo({
    required this.seq,
    required this.reportedDate,
    required this.address,
    required this.state,
    required this.postal,
    required this.type,
  });

  factory AddressInfo.fromMap(Map<String, dynamic> map) {
    return AddressInfo(
      seq: map['seq'],
      reportedDate: map['reportedDate'],
      address: map['address'],
      state: map['state'],
      postal: map['postal'],
      type: map['type'],
    );
  }
}

class PhoneInfo {
  final String seq;
  final String typeCode;
  final String reportedDate;
  final String number;

  PhoneInfo({
    required this.seq,
    required this.typeCode,
    required this.reportedDate,
    required this.number,
  });

  factory PhoneInfo.fromMap(Map<String, dynamic> map) {
    return PhoneInfo(
      seq: map['seq'],
      typeCode: map['typeCode'],
      reportedDate: map['reportedDate'],
      number: map['number'],
    );
  }
}

class RetailAccountDetail {
  final String seq;
  final String accountNumber;
  final String institution;
  final String accountType;
  final String ownershipType;
  final String balance;
  final String pastDueAmount;
  final String open;
  final String sanctionAmount;
  final String lastPaymentDate;
  final String dateReported;
  final String dateOpened;
  final String dateClosed;
  final String? reason;
  final String termFrequency;
  final String accountStatus;
  final String assetClassification;
  final String source;
  final List<History48Months> history48Months;

  RetailAccountDetail({
    required this.seq,
    required this.accountNumber,
    required this.institution,
    required this.accountType,
    required this.ownershipType,
    required this.balance,
    required this.pastDueAmount,
    required this.open,
    required this.sanctionAmount,
    required this.lastPaymentDate,
    required this.dateReported,
    required this.dateOpened,
    required this.dateClosed,
    this.reason,
    required this.termFrequency,
    required this.accountStatus,
    required this.assetClassification,
    required this.source,
    required this.history48Months,
  });

  factory RetailAccountDetail.fromMap(Map<String, dynamic> map) {
    return RetailAccountDetail(
      seq: map['seq'],
      accountNumber: map['accountNumber'],
      institution: map['institution'],
      accountType: map['accountType'],
      ownershipType: map['ownershipType'],
      balance: map['balance'],
      pastDueAmount: map['pastDueAmount'],
      open: map['open'],
      sanctionAmount: map['sanctionAmount'],
      lastPaymentDate: map['lastPaymentDate'],
      dateReported: map['dateReported'],
      dateOpened: map['dateOpened'],
      dateClosed: map['dateClosed'],
      reason: map['reason'],
      termFrequency: map['termFrequency'],
      accountStatus: map['accountStatus'],
      assetClassification: map['assetClassification'],
      source: map['source'],
      history48Months: List<History48Months>.from(
        map['history48Months']?.map((x) => History48Months.fromMap(x)) ?? [],
      ),
    );
  }
}

class History48Months {
  final String key;
  final String paymentStatus;
  final String suitFiledStatus;
  final String assetClassificationStatus;

  History48Months({
    required this.key,
    required this.paymentStatus,
    required this.suitFiledStatus,
    required this.assetClassificationStatus,
  });

  factory History48Months.fromMap(Map<String, dynamic> map) {
    return History48Months(
      key: map['key'],
      paymentStatus: map['paymentStatus'],
      suitFiledStatus: map['suitFiledStatus'],
      assetClassificationStatus: map['assetClassificationStatus'],
    );
  }
}
