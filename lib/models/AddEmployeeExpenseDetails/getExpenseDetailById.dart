class GetExpenseDetailByIdModel {
  String? status;
  bool? success;
  ExpenceDataById? data;
  String? message;

  GetExpenseDetailByIdModel({this.status, this.success, this.data, this.message});

  GetExpenseDetailByIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? new ExpenceDataById.fromJson(json['data']) : null;
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

class ExpenceDataById {
  int? id;
  int? employeeId;
  String? entryDate;
  String? expenseDate;
  String? description;
  String? documents;
  int? status;
  Null? statusDate;
  String? employeeName;

  ExpenceDataById(
      {this.id,
        this.employeeId,
        this.entryDate,
        this.expenseDate,
        this.description,
        this.documents,
        this.status,
        this.statusDate,
        this.employeeName});

  ExpenceDataById.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    entryDate = json['entryDate'];
    expenseDate = json['expenseDate'];
    description = json['description'];
    documents = json['documents'];
    status = json['status'];
    statusDate = json['statusDate'];
    employeeName = json['employeeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employeeId'] = this.employeeId;
    data['entryDate'] = this.entryDate;
    data['expenseDate'] = this.expenseDate;
    data['description'] = this.description;
    data['documents'] = this.documents;
    data['status'] = this.status;
    data['statusDate'] = this.statusDate;
    data['employeeName'] = this.employeeName;
    return data;
  }
}
