class RequestForFinancialServicesModel {
  final String status;
  final bool success;
  final OuterData data;
  final String message;

  RequestForFinancialServicesModel({
    required this.status,
    required this.success,
    required this.data,
    required this.message,
  });

  factory RequestForFinancialServicesModel.fromJson(Map<String, dynamic> json) {
    return RequestForFinancialServicesModel(
      status: json['status'],
      success: json['success'],
      data: OuterData.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class OuterData {
  final int code;
  final int timestamp;
  final String transactionId;
  final String subCode;
  final String message;
  final InnerData data;

  OuterData({
    required this.code,
    required this.timestamp,
    required this.transactionId,
    required this.subCode,
    required this.message,
    required this.data,
  });

  factory OuterData.fromJson(Map<String, dynamic> json) {
    return OuterData(
      code: json['code'],
      timestamp: json['timestamp'],
      transactionId: json['transaction_id'],
      subCode: json['sub_code'],
      message: json['message'],
      data: InnerData.fromJson(json['data']),
    );
  }
}

class InnerData {
  final String redirectUrl;

  InnerData({required this.redirectUrl});

  factory InnerData.fromJson(Map<String, dynamic> json) {
    return InnerData(
      redirectUrl: json['redirect_url'],
    );
  }
}
