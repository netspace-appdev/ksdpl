
class ForgotPassModel {
  String? status;
  bool? success;
  String? data;
  Null? message;

  ForgotPassModel({this.status, this.success, this.data, this.message});

  ForgotPassModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}
