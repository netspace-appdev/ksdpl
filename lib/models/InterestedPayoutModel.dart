class InterestedPayoutModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  InterestedPayoutModel({this.status, this.success, this.data, this.message});

  InterestedPayoutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

}

class Data {
  int? id;
  String? name;
  String? mobile;

  double? amount;
  String? receiveDate;
  String? utr;
  String? transactionId;
  String? userId;
  String? filePath;

  String? invoiceGenerate;
  String? invoiceReferenceNo;
  String? invoiceReport;

  String? receiptGenerate;
  String? receiptReferenceNo;
  String? receiptReport;

  int? packageId;
  String? receiptDate;
  String? invoiceDate;

  double? leadId;
  double? merchantId;
  double? subMerchantId;
  double? terminalId;

  String? transactionType;
  String? merchantTranId;
  String? transactionDate;
  String? bankRrn;
  String? refId;
  String? billNumber;

  String? payerAccount;
  String? payerIfsc;
  String? validityStart;
  String? validityEnd;
  String? payerName;
  String? payerMobile;
  double? payerAmount;

  String? txnStatus;
  String? txnInitDate;
  String? txnCompletionDate;

  String? payerVa;
  String? payerAccountType;
  String? responseCode;
  String? responseMessage;
  String? successFlag;

  String? qrstring;
  String? refundJson;
  String? statusCheckJson;

  String? originalMerchantTranId;
  String? originalBankRrn;

  double? refundAmount;
  String? onlineRefund;
  String? note;

  String? refundMerchantTranId;
  double? totalRefundedAmount;
  double? remainingAmount;
  double? lastRefundAmount;

  String? qRImage;
  String? apiResponseJson;

  String? packageName;
  int? noOfBank;
  int? noOfBankSendCamNote;

  Data({
    this.id,
    this.name,
    this.mobile,
    this.amount,
    this.receiveDate,
    this.utr,
    this.transactionId,
    this.userId,
    this.filePath,
    this.invoiceGenerate,
    this.invoiceReferenceNo,
    this.invoiceReport,
    this.receiptGenerate,
    this.receiptReferenceNo,
    this.receiptReport,
    this.packageId,
    this.receiptDate,
    this.invoiceDate,
    this.leadId,
    this.merchantId,
    this.subMerchantId,
    this.terminalId,
    this.transactionType,
    this.merchantTranId,
    this.transactionDate,
    this.bankRrn,
    this.refId,
    this.billNumber,
    this.payerAccount,
    this.payerIfsc,
    this.validityStart,
    this.validityEnd,
    this.payerName,
    this.payerMobile,
    this.payerAmount,
    this.txnStatus,
    this.txnInitDate,
    this.txnCompletionDate,
    this.payerVa,
    this.payerAccountType,
    this.responseCode,
    this.responseMessage,
    this.successFlag,
    this.qrstring,
    this.refundJson,
    this.statusCheckJson,
    this.originalMerchantTranId,
    this.originalBankRrn,
    this.refundAmount,
    this.onlineRefund,
    this.note,
    this.refundMerchantTranId,
    this.totalRefundedAmount,
    this.remainingAmount,
    this.lastRefundAmount,
    this.qRImage,
    this.apiResponseJson,
    this.packageName,
    this.noOfBank,
    this.noOfBankSendCamNote,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name']?.toString(),
      mobile: json['mobile']?.toString(),

      amount: (json['amount'] as num?)?.toDouble(),
      receiveDate: json['receiveDate']?.toString(),
      utr: json['utr']?.toString(),
      transactionId: json['transactionId']?.toString(),
      userId: json['userId']?.toString(),
      filePath: json['filePath']?.toString(),

      invoiceGenerate: json['invoiceGenerate']?.toString(),
      invoiceReferenceNo: json['invoiceReferenceNo']?.toString(),
      invoiceReport: json['invoiceReport']?.toString(),

      receiptGenerate: json['receiptGenerate']?.toString(),
      receiptReferenceNo: json['receiptReferenceNo']?.toString(),
      receiptReport: json['receiptReport']?.toString(),

      packageId: json['packageId'],
      receiptDate: json['receiptDate']?.toString(),
      invoiceDate: json['invoiceDate']?.toString(),

      leadId: (json['leadId'] as num?)?.toDouble(),
      merchantId: (json['merchantId'] as num?)?.toDouble(),
      subMerchantId: (json['subMerchantId'] as num?)?.toDouble(),
      terminalId: (json['terminalId'] as num?)?.toDouble(),

      transactionType: json['transactionType']?.toString(),
      merchantTranId: json['merchantTranId']?.toString(),
      transactionDate: json['transactionDate']?.toString(),
      bankRrn: json['bankRrn']?.toString(),
      refId: json['refId']?.toString(),
      billNumber: json['billNumber']?.toString(),

      payerAccount: json['payerAccount']?.toString(),
      payerIfsc: json['payerIfsc']?.toString(),
      validityStart: json['validityStart']?.toString(),
      validityEnd: json['validityEnd']?.toString(),
      payerName: json['payerName']?.toString(),
      payerMobile: json['payerMobile']?.toString(),
      payerAmount: (json['payerAmount'] as num?)?.toDouble(),

      txnStatus: json['txnStatus']?.toString(),
      txnInitDate: json['txnInitDate']?.toString(),
      txnCompletionDate: json['txnCompletionDate']?.toString(),

      payerVa: json['payerVa']?.toString(),
      payerAccountType: json['payerAccountType']?.toString(),
      responseCode: json['responseCode']?.toString(),
      responseMessage: json['responseMessage']?.toString(),
      successFlag: json['successFlag']?.toString(),

      qrstring: json['qrstring']?.toString(),
      refundJson: json['refundJson']?.toString(),
      statusCheckJson: json['statusCheckJson']?.toString(),

      originalMerchantTranId: json['originalMerchantTranId']?.toString(),
      originalBankRrn: json['originalBankRrn']?.toString(),

      refundAmount: (json['refundAmount'] as num?)?.toDouble(),
      onlineRefund: json['onlineRefund']?.toString(),
      note: json['note']?.toString(),

      refundMerchantTranId: json['refundMerchantTranId']?.toString(),
      totalRefundedAmount:
      (json['totalRefundedAmount'] as num?)?.toDouble(),
      remainingAmount:
      (json['remainingAmount'] as num?)?.toDouble(),
      lastRefundAmount:
      (json['lastRefundAmount'] as num?)?.toDouble(),

      qRImage: json['qR_Image']?.toString(),
      apiResponseJson: json['apiResponseJson']?.toString(),

      packageName: json['packageName']?.toString(),
      noOfBank: json['noOfBank'],
      noOfBankSendCamNote: json['noOfBankSendCamNote'],
    );
  }
}
