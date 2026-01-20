class ViewChatDetailModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  ViewChatDetailModel({this.status, this.success, this.data, this.message});

  ViewChatDetailModel.fromJson(Map<String, dynamic> json) {
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
  List<Message>? message;
  String? createdBy;
  int? status;
  String? name;

  Data(
      {this.id,
        this.panelId,
        this.ticketNo,
        this.subject,
        this.category,
        this.priority,
        this.message,
        this.createdBy,
        this.status,
        this.name});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    panelId = json['panelId'];
    ticketNo = json['ticketNo'];
    subject = json['subject'];
    category = json['category'];
    priority = json['priority'];
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(new Message.fromJson(v));
      });
    }
    createdBy = json['createdBy'];
    status = json['status'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['panelId'] = this.panelId;
    data['ticketNo'] = this.ticketNo;
    data['subject'] = this.subject;
    data['category'] = this.category;
    data['priority'] = this.priority;
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    data['createdBy'] = this.createdBy;
    data['status'] = this.status;
    data['name'] = this.name;
    return data;
  }
}

class Message {
  String? messageText;
  String? type;
  String? time;
  String? image;

  Message({this.messageText, this.type, this.time, this.image});

  Message.fromJson(Map<String, dynamic> json) {
    messageText = json['messageText'];
    type = json['type'];
    time = json['time'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageText'] = this.messageText;
    data['type'] = this.type;
    data['time'] = this.time;
    data['image'] = this.image;
    return data;
  }
}
