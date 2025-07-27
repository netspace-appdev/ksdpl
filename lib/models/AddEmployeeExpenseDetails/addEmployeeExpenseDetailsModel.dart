class AddEmployeeExpenseDetailsModel {
  String? status;
  bool? success;
  List<ExpenseData>? data;
  String? message;

  AddEmployeeExpenseDetailsModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  factory AddEmployeeExpenseDetailsModel.fromJson(Map<String, dynamic> json) {
    return AddEmployeeExpenseDetailsModel(
      status: json['status'],
      success: json['success'],
      data: (json['data'] != null && json['data'] is List)
          ? (json['data'] as List)
          .map((item) => ExpenseData.fromJson(item))
          .toList()
          : [],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['status'] = status;
    result['success'] = success;
    result['message'] = message;

    if (data != null) {
      result['data'] = data!.map((e) => e.toJson()).toList();
    }

    return result;
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
  dynamic statusDate;
  String? employeeName;

  ExpenseData({
    this.id,
    this.employeeId,
    this.entryDate,
    this.expenseDate,
    this.description,
    this.documents,
    this.status,
    this.statusDate,
    this.employeeName,
  });

  factory ExpenseData.fromJson(Map<String, dynamic> json) {
    return ExpenseData(
      id: json['id'],
      employeeId: json['employeeId'],
      entryDate: json['entryDate'],
      expenseDate: json['expenseDate'],
      description: json['description'],
      documents: json['documents'],
      status: json['status'],
      statusDate: json['statusDate'],
      employeeName: json['employeeName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['employeeId'] = employeeId;
    data['entryDate'] = entryDate;
    data['expenseDate'] = expenseDate;
    data['description'] = description;
    data['documents'] = documents;
    data['status'] = status;
    data['statusDate'] = statusDate;
    data['employeeName'] = employeeName;
    return data;
  }
}
