
class GetToAttendanceDeEmId {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetToAttendanceDeEmId({this.status, this.success, this.data, this.message});

  GetToAttendanceDeEmId.fromJson(Map<String, dynamic> json) {
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
  int? employeeId;
  String? employeeType;
  String? attendanceDate;
  String? checkInTime;
  String? checkOutTime;
  bool? attendanceStatus;
  Null? remarks;
  String? longitudeLatitude;

  Data(
      {this.id,
        this.employeeId,
        this.employeeType,
        this.attendanceDate,
        this.checkInTime,
        this.checkOutTime,
        this.attendanceStatus,
        this.remarks,
        this.longitudeLatitude});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    employeeType = json['employeeType'];
    attendanceDate = json['attendanceDate'];
    checkInTime = json['checkInTime'];
    checkOutTime = json['checkOutTime'];
    attendanceStatus = json['attendanceStatus'];
    remarks = json['remarks'];
    longitudeLatitude = json['longitudeLatitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employeeId'] = this.employeeId;
    data['employeeType'] = this.employeeType;
    data['attendanceDate'] = this.attendanceDate;
    data['checkInTime'] = this.checkInTime;
    data['checkOutTime'] = this.checkOutTime;
    data['attendanceStatus'] = this.attendanceStatus;
    data['remarks'] = this.remarks;
    data['longitudeLatitude'] = this.longitudeLatitude;
    return data;
  }
}
