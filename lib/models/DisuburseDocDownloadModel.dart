class DisuburseDocDownloadModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  DisuburseDocDownloadModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  DisuburseDocDownloadModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    success = json['success'];
    if (json['data'] != null) {
      data = List<Data>.from(json['data'].map((v) => Data.fromJson(v)));
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['status'] = status;
    map['success'] = success;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }
}

class Data {
  int? id;
  String? name;
  int? leadSegment;
  String? bankName;
  String? loanType;
  double? sanctionAmount;
  double? disburseAmount;
  String? loanApplicationNo;
  String? dsaCode;
  String? branchName;
  String? branchAddress;
  double? sanctionROI;
  double? amount;
  String? firmName;
  String? uniqueLeadNo;
  String? stageName;
  String? date;
  String? reportingManagerName;
  String? reportingManagerNumber;

  Data({
    this.id,
    this.name,
    this.leadSegment,
    this.bankName,
    this.loanType,
    this.sanctionAmount,
    this.disburseAmount,
    this.loanApplicationNo,
    this.dsaCode,
    this.branchName,
    this.branchAddress,
    this.sanctionROI,
    this.amount,
    this.firmName,
    this.uniqueLeadNo,
    this.stageName,
    this.date,
    this.reportingManagerName,
    this.reportingManagerNumber,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '');
    name = json['name'];
    leadSegment = json['leadSegment'] is int ? json['leadSegment'] : int.tryParse(json['leadSegment']?.toString() ?? '');
    bankName = json['bankName'];
    loanType = json['loanType']?.toString();
    sanctionAmount = (json['sanctionAmount'] != null) ? double.tryParse(json['sanctionAmount'].toString()) : null;
    disburseAmount = (json['disburseAmount'] != null) ? double.tryParse(json['disburseAmount'].toString()) : null;
    loanApplicationNo = json['loanApplicationNo'];
    dsaCode = json['dsaCode'];
    branchName = json['branchName'];
    branchAddress = json['branchAddress'];
    sanctionROI = (json['sanctionROI'] != null) ? double.tryParse(json['sanctionROI'].toString()) : null;
    amount = (json['amount'] != null) ? double.tryParse(json['amount'].toString()) : null;
    firmName = json['firmName'];
    uniqueLeadNo = json['uniqueLeadNo'];
    stageName = json['stageName'];
    date = json['date'];
    reportingManagerName = json['reportingManagerName'];
    reportingManagerNumber = json['reportingManagerNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['leadSegment'] = leadSegment;
    map['bankName'] = bankName;
    map['loanType'] = loanType;
    map['sanctionAmount'] = sanctionAmount;
    map['disburseAmount'] = disburseAmount;
    map['loanApplicationNo'] = loanApplicationNo;
    map['dsaCode'] = dsaCode;
    map['branchName'] = branchName;
    map['branchAddress'] = branchAddress;
    map['sanctionROI'] = sanctionROI;
    map['amount'] = amount;
    map['firmName'] = firmName;
    map['uniqueLeadNo'] = uniqueLeadNo;
    map['stageName'] = stageName;
    map['date'] = date;
    map['reportingManagerName'] = reportingManagerName;
    map['reportingManagerNumber'] = reportingManagerNumber;
    return map;
  }
}
