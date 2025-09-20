class GetProfessionalDetailModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetProfessionalDetailModel(
      {this.status, this.success, this.data, this.message});

  GetProfessionalDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? companyName;
  String? jobTitle;
  String? department;
  String? startDate;
  String? endDate;
  String? employmentType;
  String? companyAddress;
  String? responsibilities;
  int? lastDrawnSalary;
  String? reasonForLeaving;
  String? documents;
  Null? approvedByHR;
  int? isFresher;

  Data(
      {this.id,
        this.employeeId,
        this.companyName,
        this.jobTitle,
        this.department,
        this.startDate,
        this.endDate,
        this.employmentType,
        this.companyAddress,
        this.responsibilities,
        this.lastDrawnSalary,
        this.reasonForLeaving,
        this.documents,
        this.approvedByHR,
        this.isFresher});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    companyName = json['companyName'];
    jobTitle = json['jobTitle'];
    department = json['department'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    employmentType = json['employmentType'];
    companyAddress = json['companyAddress'];
    responsibilities = json['responsibilities'];

    // Handle int/double safely
    final salaryValue = json['lastDrawnSalary'];
    if (salaryValue is int) {
      lastDrawnSalary = salaryValue;
    } else if (salaryValue is double) {
      lastDrawnSalary = salaryValue.toInt(); // or store as double if needed
    } else {
      lastDrawnSalary = null;
    }

    reasonForLeaving = json['reasonForLeaving'];
    documents = json['documents'];
    approvedByHR = json['approvedByHR'];
    isFresher = json['isFresher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employeeId'] = this.employeeId;
    data['companyName'] = this.companyName;
    data['jobTitle'] = this.jobTitle;
    data['department'] = this.department;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['employmentType'] = this.employmentType;
    data['companyAddress'] = this.companyAddress;
    data['responsibilities'] = this.responsibilities;
    data['lastDrawnSalary'] = this.lastDrawnSalary;
    data['reasonForLeaving'] = this.reasonForLeaving;
    data['documents'] = this.documents;
    data['approvedByHR'] = this.approvedByHR;
    data['isFresher'] = this.isFresher;
    return data;
  }
}
