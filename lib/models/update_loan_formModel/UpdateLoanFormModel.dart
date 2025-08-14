class UpdateLoanFormModel {
  String? status;
  bool? success;
  List<dynamic>? data;
  String? message;

  UpdateLoanFormModel({this.status, this.success, this.data, this.message});

  UpdateLoanFormModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? List<dynamic>.from(json['data']) : [];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['status'] = status;
    map['success'] = success;
    map['data'] = data;
    map['message'] = message;
    return map;
  }
}
