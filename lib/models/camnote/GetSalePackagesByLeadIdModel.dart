class GetSalePackagesByLeadIdModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetSalePackagesByLeadIdModel(
      {this.status, this.success, this.data, this.message});

  GetSalePackagesByLeadIdModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? mobile;
  num? amount;
  String? receiveDate;
  String? utr;
  String? transactionId;
  String? userId;
  String? filePath;
  num? invoiceGenerate;
  String? invoiceReferenceNo;
  String? invoiceReport;
  num? receiptGenerate;
  String? receiptReferenceNo;
  String? receiptReport;
  int? packageId;
  String? receiptDate;
  String? invoiceDate;
  int? leadId;
  int? merchantId;
  num? subMerchantId;
  num? terminalId;
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
  num? payerAmount;
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
  num? refundAmount;
  String? onlineRefund;
  String? note;
  String? refundMerchantTranId;
  num? totalRefundedAmount;
  num? remainingAmount;
  num? lastRefundAmount;
  String? qRImage;
  String? apiResponseJson;
  String? packageName;
  num? noOfBank;

  Data(
      {this.id,
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
        this.noOfBank});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    amount = json['amount'];
    receiveDate = json['receiveDate'];
    utr = json['utr'];
    transactionId = json['transactionId'];
    userId = json['userId'];
    filePath = json['filePath'];
    invoiceGenerate = json['invoiceGenerate'];
    invoiceReferenceNo = json['invoiceReferenceNo'];
    invoiceReport = json['invoiceReport'];
    receiptGenerate = json['receiptGenerate'];
    receiptReferenceNo = json['receiptReferenceNo'];
    receiptReport = json['receiptReport'];
    packageId = json['packageId'];
    receiptDate = json['receiptDate'];
    invoiceDate = json['invoiceDate'];
    leadId = json['leadId'];
    merchantId = json['merchantId'];
    subMerchantId = json['subMerchantId'];
    terminalId = json['terminalId'];
    transactionType = json['transactionType'];
    merchantTranId = json['merchantTranId'];
    transactionDate = json['transactionDate'];
    bankRrn = json['bankRrn'];
    refId = json['refId'];
    billNumber = json['billNumber'];
    payerAccount = json['payerAccount'];
    payerIfsc = json['payerIfsc'];
    validityStart = json['validityStart'];
    validityEnd = json['validityEnd'];
    payerName = json['payerName'];
    payerMobile = json['payerMobile'];
    payerAmount = json['payerAmount'];
    txnStatus = json['txnStatus'];
    txnInitDate = json['txnInitDate'];
    txnCompletionDate = json['txnCompletionDate'];
    payerVa = json['payerVa'];
    payerAccountType = json['payerAccountType'];
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    successFlag = json['successFlag'];
    qrstring = json['qrstring'];
    refundJson = json['refundJson'];
    statusCheckJson = json['statusCheckJson'];
    originalMerchantTranId = json['originalMerchantTranId'];
    originalBankRrn = json['originalBankRrn'];
    refundAmount = json['refundAmount'];
    onlineRefund = json['onlineRefund'];
    note = json['note'];
    refundMerchantTranId = json['refundMerchantTranId'];
    totalRefundedAmount = json['totalRefundedAmount'];
    remainingAmount = json['remainingAmount'];
    lastRefundAmount = json['lastRefundAmount'];
    qRImage = json['qR_Image'];
    apiResponseJson = json['apiResponseJson'];
    packageName = json['packageName'];
    noOfBank = json['noOfBank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['amount'] = this.amount;
    data['receiveDate'] = this.receiveDate;
    data['utr'] = this.utr;
    data['transactionId'] = this.transactionId;
    data['userId'] = this.userId;
    data['filePath'] = this.filePath;
    data['invoiceGenerate'] = this.invoiceGenerate;
    data['invoiceReferenceNo'] = this.invoiceReferenceNo;
    data['invoiceReport'] = this.invoiceReport;
    data['receiptGenerate'] = this.receiptGenerate;
    data['receiptReferenceNo'] = this.receiptReferenceNo;
    data['receiptReport'] = this.receiptReport;
    data['packageId'] = this.packageId;
    data['receiptDate'] = this.receiptDate;
    data['invoiceDate'] = this.invoiceDate;
    data['leadId'] = this.leadId;
    data['merchantId'] = this.merchantId;
    data['subMerchantId'] = this.subMerchantId;
    data['terminalId'] = this.terminalId;
    data['transactionType'] = this.transactionType;
    data['merchantTranId'] = this.merchantTranId;
    data['transactionDate'] = this.transactionDate;
    data['bankRrn'] = this.bankRrn;
    data['refId'] = this.refId;
    data['billNumber'] = this.billNumber;
    data['payerAccount'] = this.payerAccount;
    data['payerIfsc'] = this.payerIfsc;
    data['validityStart'] = this.validityStart;
    data['validityEnd'] = this.validityEnd;
    data['payerName'] = this.payerName;
    data['payerMobile'] = this.payerMobile;
    data['payerAmount'] = this.payerAmount;
    data['txnStatus'] = this.txnStatus;
    data['txnInitDate'] = this.txnInitDate;
    data['txnCompletionDate'] = this.txnCompletionDate;
    data['payerVa'] = this.payerVa;
    data['payerAccountType'] = this.payerAccountType;
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    data['successFlag'] = this.successFlag;
    data['qrstring'] = this.qrstring;
    data['refundJson'] = this.refundJson;
    data['statusCheckJson'] = this.statusCheckJson;
    data['originalMerchantTranId'] = this.originalMerchantTranId;
    data['originalBankRrn'] = this.originalBankRrn;
    data['refundAmount'] = this.refundAmount;
    data['onlineRefund'] = this.onlineRefund;
    data['note'] = this.note;
    data['refundMerchantTranId'] = this.refundMerchantTranId;
    data['totalRefundedAmount'] = this.totalRefundedAmount;
    data['remainingAmount'] = this.remainingAmount;
    data['lastRefundAmount'] = this.lastRefundAmount;
    data['qR_Image'] = this.qRImage;
    data['apiResponseJson'] = this.apiResponseJson;
    data['packageName'] = this.packageName;
    data['noOfBank'] = this.noOfBank;
    return data;
  }
}

