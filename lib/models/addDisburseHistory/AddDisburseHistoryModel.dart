class AddDisburseHistoryModel {
  String? status;
  bool? success;
  List<dynamic>? data; // Keeping it dynamic since API sends an empty array
  String? message;

  AddDisburseHistoryModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  AddDisburseHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = List<dynamic>.from(json['data']);
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['status'] = status;
    map['success'] = success;
    if (data != null) {
      map['data'] = data;
    }
    map['message'] = message;
    return map;
  }
}
