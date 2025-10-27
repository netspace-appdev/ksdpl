
class SendQRCodeOnWACustModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  SendQRCodeOnWACustModel({this.status, this.success, this.data, this.message});

  SendQRCodeOnWACustModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  bool? status;
  Response? response;

  Data({this.status, this.response});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  String? status;
  bool? hasError;
  String? data;
  String? errors;
  String? requestId;

  Response(
      {this.status, this.hasError, this.data, this.errors, this.requestId});

  Response.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    hasError = json['hasError'];
    data = json['data'];
    errors = json['errors'];
    requestId = json['request_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['hasError'] = this.hasError;
    data['data'] = this.data;
    data['errors'] = this.errors;
    data['request_id'] = this.requestId;
    return data;
  }
}
