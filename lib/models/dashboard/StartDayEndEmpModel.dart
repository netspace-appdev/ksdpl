class StartDayEndEmpModel {
  String? status;
  bool? success;
  List<dynamic>? data; // Empty array, type can change if you ever return actual objects
  String? message;

  StartDayEndEmpModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  factory StartDayEndEmpModel.fromJson(Map<String, dynamic> json) {
    return StartDayEndEmpModel(
      status: json['status'],
      success: json['success'],
      data: json['data'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'success': success,
      'data': data,
      'message': message,
    };
  }
}
