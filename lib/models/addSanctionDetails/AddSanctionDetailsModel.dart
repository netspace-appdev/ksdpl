class AddSanctionDetailsModel {
  String? status;
  bool? success;
  List<dynamic>? data; // dynamic if no defined structure
  String? message;

  AddSanctionDetailsModel({this.status, this.success, this.data, this.message});

  AddSanctionDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? List<dynamic>.from(json['data']) : [];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['status'] = status;
    dataMap['success'] = success;
    dataMap['data'] = data;
    dataMap['message'] = message;
    return dataMap;
  }
}
