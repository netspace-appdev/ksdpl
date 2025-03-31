class GetRemindersModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetRemindersModel({this.status, this.success, this.data, this.message});

  GetRemindersModel.fromJson(Map<String, dynamic> json) {
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
  int? leadId;
  int? callStatus;
  String? callRecordingPathUrl;
  String? callStartTime;
  String? callEndTime;
  String? callDuration;
  String? feedBackRelatedToCall;
  String? callReminder;
  String? feedBackRelatedToLead;
  int? employeeId;
  int? leadStageStatus;
  double? leadPercent;
  int? moveToCommon;
  String? workDate;
  String? employeeName;
  String? leadMobileNo;
  String? leadEmail;
  String? leadCustomerName;

  Data(
      {this.id,
        this.leadId,
        this.callStatus,
        this.callRecordingPathUrl,
        this.callStartTime,
        this.callEndTime,
        this.callDuration,
        this.feedBackRelatedToCall,
        this.callReminder,
        this.feedBackRelatedToLead,
        this.employeeId,
        this.leadStageStatus,
        this.leadPercent,
        this.moveToCommon,
        this.workDate,
        this.employeeName,
        this.leadMobileNo,
        this.leadEmail,
        this.leadCustomerName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadId = json['leadId'];
    callStatus = json['callStatus'];
    callRecordingPathUrl = json['callRecordingPathUrl'];
    callStartTime = json['callStartTime'];
    callEndTime = json['callEndTime'];
    callDuration = json['callDuration'];
    feedBackRelatedToCall = json['feedBackRelatedToCall'];
    callReminder = json['callReminder'];
    feedBackRelatedToLead = json['feedBackRelatedToLead'];
    employeeId = json['employeeId'];
    leadStageStatus = json['leadStageStatus'];
    leadPercent = json['leadPercent'];
    moveToCommon = json['moveToCommon'];
    workDate = json['workDate'];
    employeeName = json['employeeName'];
    leadMobileNo = json['leadMobileNo'];
    leadEmail = json['leadEmail'];
    leadCustomerName = json['leadCustomerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leadId'] = this.leadId;
    data['callStatus'] = this.callStatus;
    data['callRecordingPathUrl'] = this.callRecordingPathUrl;
    data['callStartTime'] = this.callStartTime;
    data['callEndTime'] = this.callEndTime;
    data['callDuration'] = this.callDuration;
    data['feedBackRelatedToCall'] = this.feedBackRelatedToCall;
    data['callReminder'] = this.callReminder;
    data['feedBackRelatedToLead'] = this.feedBackRelatedToLead;
    data['employeeId'] = this.employeeId;
    data['leadStageStatus'] = this.leadStageStatus;
    data['leadPercent'] = this.leadPercent;
    data['moveToCommon'] = this.moveToCommon;
    data['workDate'] = this.workDate;
    data['employeeName'] = this.employeeName;
    data['leadMobileNo'] = this.leadMobileNo;
    data['leadEmail'] = this.leadEmail;
    data['leadCustomerName'] = this.leadCustomerName;
    return data;
  }
}
