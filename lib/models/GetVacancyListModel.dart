/*
class GetVacancyListModel {
  String? status;
  bool? success;
  List<VacancyData>? data;
  String? message;

  GetVacancyListModel({this.status, this.success, this.data, this.message});

  GetVacancyListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <VacancyData>[];
      json['data'].forEach((v) {
        data!.add(VacancyData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['status'] = status;
    map['success'] = success;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }
}

class VacancyData {
  int? id;
  String? jobTitle;
  String? jobDescription;
  String? employeeRole;
  String? workLocation;
  num? salaryRangeMin;   // ✅ Changed to double
  num? salaryRangeMax;   // ✅ Changed to double
  String? experienceRequired;
  String? qualificationsRequired;
  String? skillsRequired;
  String? vacancyStatus;
  String? datePosted;
  String? closingDate;
  String? hiringManager;
  int? numberOfVacancies;
  String? jobLevel;
  bool? active;
  String? createdDate;
  String? createdBy;
  String? updatedDate;
  String? updatedBy;
  String? deletedDate;
  String? deletedBy;

  VacancyData({
    this.id,
    this.jobTitle,
    this.jobDescription,
    this.employeeRole,
    this.workLocation,
    this.salaryRangeMin,
    this.salaryRangeMax,
    this.experienceRequired,
    this.qualificationsRequired,
    this.skillsRequired,
    this.vacancyStatus,
    this.datePosted,
    this.closingDate,
    this.hiringManager,
    this.numberOfVacancies,
    this.jobLevel,
    this.active,
    this.createdDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
    this.deletedDate,
    this.deletedBy,
  });

  VacancyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobTitle = json['jobTitle'];
    jobDescription = json['jobDescription'];
    employeeRole = json['employeeRole'];
    workLocation = json['workLocation'];
    salaryRangeMin = (json['salaryRangeMin'] as num?)?.toDouble(); // ✅ Safe cast
    salaryRangeMax = (json['salaryRangeMax'] as num?)?.toDouble(); // ✅ Safe cast
    experienceRequired = json['experienceRequired'];
    qualificationsRequired = json['qualificationsRequired'];
    skillsRequired = json['skillsRequired'];
    vacancyStatus = json['vacancyStatus'];
    datePosted = json['datePosted'];
    closingDate = json['closingDate'];
    hiringManager = json['hiringManager'];
    numberOfVacancies = json['numberOfVacancies'];
    jobLevel = json['jobLevel'];
    active = json['active'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    updatedDate = json['updatedDate'];
    updatedBy = json['updatedBy'];
    deletedDate = json['deletedDate'];
    deletedBy = json['deletedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['jobTitle'] = jobTitle;
    map['jobDescription'] = jobDescription;
    map['employeeRole'] = employeeRole;
    map['workLocation'] = workLocation;
    map['salaryRangeMin'] = salaryRangeMin;
    map['salaryRangeMax'] = salaryRangeMax;
    map['experienceRequired'] = experienceRequired;
    map['qualificationsRequired'] = qualificationsRequired;
    map['skillsRequired'] = skillsRequired;
    map['vacancyStatus'] = vacancyStatus;
    map['datePosted'] = datePosted;
    map['closingDate'] = closingDate;
    map['hiringManager'] = hiringManager;
    map['numberOfVacancies'] = numberOfVacancies;
    map['jobLevel'] = jobLevel;
    map['active'] = active;
    map['createdDate'] = createdDate;
    map['createdBy'] = createdBy;
    map['updatedDate'] = updatedDate;
    map['updatedBy'] = updatedBy;
    map['deletedDate'] = deletedDate;
    map['deletedBy'] = deletedBy;
    return map;
  }
}
*/


class GetVacancyListModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetVacancyListModel({this.status, this.success, this.data, this.message});

  GetVacancyListModel.fromJson(Map<String, dynamic> json) {
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
  String? jobTitle;
  String? jobDescription;
  String? employeeRole;
  String? workLocation;
  num? salaryRangeMin;
  num? salaryRangeMax;
  String? experienceRequired;
  String? qualificationsRequired;
  String? skillsRequired;
  String? vacancyStatus;
  String? datePosted;
  String? closingDate;
  String? hiringManager;
  num? numberOfVacancies;
  String? jobLevel;
  bool? active;
  String? createdDate;
  num? createdBy;
  String? updatedDate;
  String? updatedBy;
  String? deletedDate;
  String? deletedBy;

  Data(
      {this.id,
        this.jobTitle,
        this.jobDescription,
        this.employeeRole,
        this.workLocation,
        this.salaryRangeMin,
        this.salaryRangeMax,
        this.experienceRequired,
        this.qualificationsRequired,
        this.skillsRequired,
        this.vacancyStatus,
        this.datePosted,
        this.closingDate,
        this.hiringManager,
        this.numberOfVacancies,
        this.jobLevel,
        this.active,
        this.createdDate,
        this.createdBy,
        this.updatedDate,
        this.updatedBy,
        this.deletedDate,
        this.deletedBy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobTitle = json['jobTitle'];
    jobDescription = json['jobDescription'];
    employeeRole = json['employeeRole'];
    workLocation = json['workLocation'];
    salaryRangeMin = json['salaryRangeMin'];
    salaryRangeMax = json['salaryRangeMax'];
    experienceRequired = json['experienceRequired'];
    qualificationsRequired = json['qualificationsRequired'];
    skillsRequired = json['skillsRequired'];
    vacancyStatus = json['vacancyStatus'];
    datePosted = json['datePosted'];
    closingDate = json['closingDate'];
    hiringManager = json['hiringManager'];
    numberOfVacancies = json['numberOfVacancies'];
    jobLevel = json['jobLevel'];
    active = json['active'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    updatedDate = json['updatedDate'];
    updatedBy = json['updatedBy'];
    deletedDate = json['deletedDate'];
    deletedBy = json['deletedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jobTitle'] = this.jobTitle;
    data['jobDescription'] = this.jobDescription;
    data['employeeRole'] = this.employeeRole;
    data['workLocation'] = this.workLocation;
    data['salaryRangeMin'] = this.salaryRangeMin;
    data['salaryRangeMax'] = this.salaryRangeMax;
    data['experienceRequired'] = this.experienceRequired;
    data['qualificationsRequired'] = this.qualificationsRequired;
    data['skillsRequired'] = this.skillsRequired;
    data['vacancyStatus'] = this.vacancyStatus;
    data['datePosted'] = this.datePosted;
    data['closingDate'] = this.closingDate;
    data['hiringManager'] = this.hiringManager;
    data['numberOfVacancies'] = this.numberOfVacancies;
    data['jobLevel'] = this.jobLevel;
    data['active'] = this.active;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['updatedDate'] = this.updatedDate;
    data['updatedBy'] = this.updatedBy;
    data['deletedDate'] = this.deletedDate;
    data['deletedBy'] = this.deletedBy;
    return data;
  }
}
