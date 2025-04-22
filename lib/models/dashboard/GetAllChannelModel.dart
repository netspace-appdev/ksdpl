
class GetAllChannelModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetAllChannelModel({this.status, this.success, this.data, this.message});

  GetAllChannelModel.fromJson(Map<String, dynamic> json) {
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
  String? channelName;
  String? channelCode;
  String? contactPersonName;
  String? address;
  String? contactNumber;
  String? emailId;
  int? workPercentageWithChannel;
  bool? active;
  int? createdBy;
  String? createdDate;
  int? updatedBy;
  String? updatedDate;
  Null? deletedBy;
  Null? deletedDate;

  Data(
      {this.id,
        this.channelName,
        this.channelCode,
        this.contactPersonName,
        this.address,
        this.contactNumber,
        this.emailId,
        this.workPercentageWithChannel,
        this.active,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
        this.deletedBy,
        this.deletedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    channelName = json['channelName'];
    channelCode = json['channelCode'];
    contactPersonName = json['contactPersonName'];
    address = json['address'];
    contactNumber = json['contactNumber'];
    emailId = json['emailId'];
    workPercentageWithChannel = json['workPercentageWithChannel'];
    active = json['active'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    deletedBy = json['deletedBy'];
    deletedDate = json['deletedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['channelName'] = this.channelName;
    data['channelCode'] = this.channelCode;
    data['contactPersonName'] = this.contactPersonName;
    data['address'] = this.address;
    data['contactNumber'] = this.contactNumber;
    data['emailId'] = this.emailId;
    data['workPercentageWithChannel'] = this.workPercentageWithChannel;
    data['active'] = this.active;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['updatedBy'] = this.updatedBy;
    data['updatedDate'] = this.updatedDate;
    data['deletedBy'] = this.deletedBy;
    data['deletedDate'] = this.deletedDate;
    return data;
  }
}
