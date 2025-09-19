class GetEducationDetail {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetEducationDetail({this.status, this.success, this.data, this.message});

  GetEducationDetail.fromJson(Map<String, dynamic> json) {
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
  String? qualification;
  String? specialization;
  String? institutionName;
  String? universityName;
  int? yearOfPassing;
  String? gradeOrPercentage;
  String? educationType;
  String? documents;
  Null? approvedByHR;

  Data(
      {this.id,
        this.employeeId,
        this.qualification,
        this.specialization,
        this.institutionName,
        this.universityName,
        this.yearOfPassing,
        this.gradeOrPercentage,
        this.educationType,
        this.documents,
        this.approvedByHR});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    qualification = json['qualification'];
    specialization = json['specialization'];
    institutionName = json['institutionName'];
    universityName = json['universityName'];
    yearOfPassing = json['yearOfPassing'];
    gradeOrPercentage = json['gradeOrPercentage'];
    educationType = json['educationType'];
    documents = json['documents'];
    approvedByHR = json['approvedByHR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employeeId'] = this.employeeId;
    data['qualification'] = this.qualification;
    data['specialization'] = this.specialization;
    data['institutionName'] = this.institutionName;
    data['universityName'] = this.universityName;
    data['yearOfPassing'] = this.yearOfPassing;
    data['gradeOrPercentage'] = this.gradeOrPercentage;
    data['educationType'] = this.educationType;
    data['documents'] = this.documents;
    data['approvedByHR'] = this.approvedByHR;
    return data;
  }
}
