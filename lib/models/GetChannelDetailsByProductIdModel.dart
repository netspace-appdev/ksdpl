class GetChannelDetailsByProductIdModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetChannelDetailsByProductIdModel(
      {this.status, this.success, this.data, this.message});

  GetChannelDetailsByProductIdModel.fromJson(Map<String, dynamic> json) {
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
  int? productId;
  int? channelId;
  String? channelName;
  String? contactPersonName;
  String? contactNumber;
  String? emailId;
  String? channelCode;

  Data(
      {this.productId,
        this.channelId,
        this.channelName,
        this.contactPersonName,
        this.contactNumber,
        this.emailId,
        this.channelCode});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    channelId = json['channelId'];
    channelName = json['channelName'];
    contactPersonName = json['contactPersonName'];
    contactNumber = json['contactNumber'];
    emailId = json['emailId'];
    channelCode = json['channelCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['channelId'] = this.channelId;
    data['channelName'] = this.channelName;
    data['contactPersonName'] = this.contactPersonName;
    data['contactNumber'] = this.contactNumber;
    data['emailId'] = this.emailId;
    data['channelCode'] = this.channelCode;
    return data;
  }
}
