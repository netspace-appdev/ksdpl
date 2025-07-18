
class TodayWorkStatusRBModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  TodayWorkStatusRBModel({this.status, this.success, this.data, this.message});

  TodayWorkStatusRBModel.fromJson(Map<String, dynamic> json) {
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
  String? branchName;
  String? managerName;
  String? employeeName;
  int? employeeId;
  int? todayCall;
  int? todayConnectedCall;
  int? todayConvertToInterested;
  String? todayCallDuration;
  int? leadsCalledInYear;
  int? todayNotConnectedCall;
  Data(
      {this.branchName,
        this.managerName,
        this.employeeName,
        this.employeeId,
        this.todayCall,
        this.todayConnectedCall,
        this.todayConvertToInterested,
        this.todayCallDuration,
        this.todayNotConnectedCall,
        this.leadsCalledInYear});

  Data.fromJson(Map<String, dynamic> json) {
    branchName = json['branchName'];
    managerName = json['managerName'];
    employeeName = json['employeeName'];
    employeeId = json['employeeId'];
    todayCall = json['todayCall'];
    todayConnectedCall = json['todayConnectedCall'];
    todayConvertToInterested = json['todayConvertToInterested'];
    todayCallDuration = json['todayCallDuration'];
    leadsCalledInYear = json['leadsCalledInYear'];
    todayNotConnectedCall = json['todayNotConnectedCall'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchName'] = this.branchName;
    data['managerName'] = this.managerName;
    data['employeeName'] = this.employeeName;
    data['employeeId'] = this.employeeId;
    data['todayCall'] = this.todayCall;
    data['todayConnectedCall'] = this.todayConnectedCall;
    data['todayConvertToInterested'] = this.todayConvertToInterested;
    data['todayCallDuration'] = this.todayCallDuration;
    data['leadsCalledInYear'] = this.leadsCalledInYear;
    data['todayNotConnectedCall'] = this.todayNotConnectedCall;
    return data;
  }
}

