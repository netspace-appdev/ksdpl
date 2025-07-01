
class AddEmployeeLeaveDetailModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  AddEmployeeLeaveDetailModel(
      {this.status, this.success, this.data, this.message});

  AddEmployeeLeaveDetailModel.fromJson(Map<String, dynamic> json) {
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
  int? employeeId;
  String? employeeName;
  int? leaveType;
  String? leaveTypeName;
  String? startDate;
  String? endDate;
  int? totalDays;
  String? reason;
  String? status;
  String? appliedDate;
  Null? approvedBy;
  Null? approvedDate;
  Null? comments;
  String? approvedByName;

  Data(
      {this.id,
        this.employeeId,
        this.employeeName,
        this.leaveType,
        this.leaveTypeName,
        this.startDate,
        this.endDate,
        this.totalDays,
        this.reason,
        this.status,
        this.appliedDate,
        this.approvedBy,
        this.approvedDate,
        this.comments,
        this.approvedByName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    employeeName = json['employeeName'];
    leaveType = json['leaveType'];
    leaveTypeName = json['leaveTypeName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    totalDays = json['totalDays'];
    reason = json['reason'];
    status = json['status'];
    appliedDate = json['appliedDate'];
    approvedBy = json['approvedBy'];
    approvedDate = json['approvedDate'];
    comments = json['comments'];
    approvedByName = json['approvedByName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employeeId'] = this.employeeId;
    data['employeeName'] = this.employeeName;
    data['leaveType'] = this.leaveType;
    data['leaveTypeName'] = this.leaveTypeName;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['totalDays'] = this.totalDays;
    data['reason'] = this.reason;
    data['status'] = this.status;
    data['appliedDate'] = this.appliedDate;
    data['approvedBy'] = this.approvedBy;
    data['approvedDate'] = this.approvedDate;
    data['comments'] = this.comments;
    data['approvedByName'] = this.approvedByName;
    return data;
  }
}
