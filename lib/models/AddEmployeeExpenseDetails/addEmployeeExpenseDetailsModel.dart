class AddEmployeeExpenseDetailsModel {
  String? status;
  bool? success;
  List<ExpenseData>? data;
  String? message;

  AddEmployeeExpenseDetailsModel(
      {this.status, this.success, this.data, this.message});

  AddEmployeeExpenseDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <ExpenseData>[];
      json['data'].forEach((v) {
        data!.add(new ExpenseData.fromJson(v));
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

class ExpenseData {
  int? id;
  int? employeeId;
  String? entryDate;
  String? expenseDate;
  String? description;
  String? documents;
  int? status;
  String? statusDate;
  String? employeeName;
  String? reason;

  ExpenseData(
      {this.id,
        this.employeeId,
        this.entryDate,
        this.expenseDate,
        this.description,
        this.documents,
        this.status,
        this.statusDate,
        this.employeeName,
        this.reason});

  ExpenseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    entryDate = json['entryDate'];
    expenseDate = json['expenseDate'];
    description = json['description'];
    documents = json['documents'];
    status = json['status'];
    statusDate = json['statusDate'];
    employeeName = json['employeeName'];
    reason = json['reason'];
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
    data['reason'] = this.reason;
    return data;
  }
}
