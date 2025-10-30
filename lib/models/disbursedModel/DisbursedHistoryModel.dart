class DisbursedHistoryModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  DisbursedHistoryModel({this.status, this.success, this.data, this.message});

  DisbursedHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    success = json['success'] ?? false;
    if (json['data'] != null && json['data'] is List) {
      data = <Data>[];
      for (var v in json['data']) {
        data!.add(Data.fromJson(v));
      }
    }
    message = json['message']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['status'] = status;
    dataMap['success'] = success;
    if (data != null) {
      dataMap['data'] = data!.map((v) => v.toJson()).toList();
    }
    dataMap['message'] = message;
    return dataMap;
  }
}

class Data {
  int? id;
  String? uniqueLeadNo;
  String? date;
  double? amount;
  String? actualDate;
  int? actualAmount;
  String? transactionDetails;
  String? disbursedBy;
  String? contactNo;
  String? loanAccountNo;
  String? invoiceGenerate;
  String? invoiceReferenceNo;
  String? invoiceReport;
  String? receiptGenerate;
  String? receiptReferenceNo;
  String? receiptReport;
  String? invoiceDate;
  String? receiptDate;
  String? confirmationDocument;
  String? confirmationStatus;
  String? bankerEmail;
  String? superiorName;
  String? superiorEmail;
  String? superiorContact;

  Data({
    this.id,
    this.uniqueLeadNo,
    this.date,
    this.amount,
    this.actualDate,
    this.actualAmount,
    this.transactionDetails,
    this.disbursedBy,
    this.contactNo,
    this.loanAccountNo,
    this.invoiceGenerate,
    this.invoiceReferenceNo,
    this.invoiceReport,
    this.receiptGenerate,
    this.receiptReferenceNo,
    this.receiptReport,
    this.invoiceDate,
    this.receiptDate,
    this.confirmationDocument,
    this.confirmationStatus,
    this.bankerEmail,
    this.superiorName,
    this.superiorEmail,
    this.superiorContact,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = _parseInt(json['id']);
    uniqueLeadNo = json['uniqueLeadNo']?.toString();
    date = json['date']?.toString();
    amount = _parseDouble(json['amount']);
    actualDate = json['actualDate']?.toString();
    actualAmount = _parseInt(json['actualAmount']);
    transactionDetails = json['transactionDetails']?.toString();
    disbursedBy = json['disbursedBy']?.toString();
    contactNo = json['contactNo']?.toString();
    loanAccountNo = json['loanAccountNo']?.toString();
    invoiceGenerate = json['invoiceGenerate']?.toString();
    invoiceReferenceNo = json['invoiceReferenceNo']?.toString();
    invoiceReport = json['invoiceReport']?.toString();
    receiptGenerate = json['receiptGenerate']?.toString();
    receiptReferenceNo = json['receiptReferenceNo']?.toString();
    receiptReport = json['receiptReport']?.toString();
    invoiceDate = json['invoiceDate']?.toString();
    receiptDate = json['receiptDate']?.toString();
    confirmationDocument =
        json['confirmation_Document']?.toString() ?? json['confirmationDocument']?.toString();
    confirmationStatus =
        json['confirmation_Status']?.toString() ?? json['confirmationStatus']?.toString();
    bankerEmail = json['bankerEmail']?.toString();
    superiorName = json['superiorName']?.toString();
    superiorEmail = json['superiorEmail']?.toString();
    superiorContact = json['superiorContact']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['id'] = id;
    dataMap['uniqueLeadNo'] = uniqueLeadNo;
    dataMap['date'] = date;
    dataMap['amount'] = amount;
    dataMap['actualDate'] = actualDate;
    dataMap['actualAmount'] = actualAmount;
    dataMap['transactionDetails'] = transactionDetails;
    dataMap['disbursedBy'] = disbursedBy;
    dataMap['contactNo'] = contactNo;
    dataMap['loanAccountNo'] = loanAccountNo;
    dataMap['invoiceGenerate'] = invoiceGenerate;
    dataMap['invoiceReferenceNo'] = invoiceReferenceNo;
    dataMap['invoiceReport'] = invoiceReport;
    dataMap['receiptGenerate'] = receiptGenerate;
    dataMap['receiptReferenceNo'] = receiptReferenceNo;
    dataMap['receiptReport'] = receiptReport;
    dataMap['invoiceDate'] = invoiceDate;
    dataMap['receiptDate'] = receiptDate;
    dataMap['confirmation_Document'] = confirmationDocument;
    dataMap['confirmation_Status'] = confirmationStatus;
    dataMap['bankerEmail'] = bankerEmail;
    dataMap['superiorName'] = superiorName;
    dataMap['superiorEmail'] = superiorEmail;
    dataMap['superiorContact'] = superiorContact;
    return dataMap;
  }

  /// 🔹 Safe number parsing helpers
  int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString());
  }

  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString());
  }
}
