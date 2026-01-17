class AddTicketModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  AddTicketModel({this.status, this.success, this.data, this.message});

  AddTicketModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? panelId;
  String? ticketNo;
  String? subject;
  String? category;
  String? priority;
  String? image;
  String? issueDetails;
  Null? response;
  String? createdBy;
  String? createdDate;
  Null? updatedBy;
  Null? updatedDate;
  Null? closeBy;
  Null? closingDate;
  Null? reopenDate;
  Null? recloseBy;
  Null? recloseDate;
  int? status;
  int? channelId;

  Data(
      {this.id,
        this.panelId,
        this.ticketNo,
        this.subject,
        this.category,
        this.priority,
        this.image,
        this.issueDetails,
        this.response,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
        this.closeBy,
        this.closingDate,
        this.reopenDate,
        this.recloseBy,
        this.recloseDate,
        this.status,
        this.channelId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    panelId = json['panelId'];
    ticketNo = json['ticketNo'];
    subject = json['subject'];
    category = json['category'];
    priority = json['priority'];
    image = json['image'];
    issueDetails = json['issueDetails'];
    response = json['response'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    closeBy = json['closeBy'];
    closingDate = json['closingDate'];
    reopenDate = json['reopenDate'];
    recloseBy = json['recloseBy'];
    recloseDate = json['recloseDate'];
    status = json['status'];
    channelId = json['channelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['panelId'] = this.panelId;
    data['ticketNo'] = this.ticketNo;
    data['subject'] = this.subject;
    data['category'] = this.category;
    data['priority'] = this.priority;
    data['image'] = this.image;
    data['issueDetails'] = this.issueDetails;
    data['response'] = this.response;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['updatedBy'] = this.updatedBy;
    data['updatedDate'] = this.updatedDate;
    data['closeBy'] = this.closeBy;
    data['closingDate'] = this.closingDate;
    data['reopenDate'] = this.reopenDate;
    data['recloseBy'] = this.recloseBy;
    data['recloseDate'] = this.recloseDate;
    data['status'] = this.status;
    data['channelId'] = this.channelId;
    return data;
  }
}
