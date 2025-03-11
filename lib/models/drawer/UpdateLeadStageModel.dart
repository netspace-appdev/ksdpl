class UpdateLeadStageModel {
  String? status;
  bool? success;
  int? data;
  String? message;

  UpdateLeadStageModel({this.status, this.success, this.data, this.message});

  UpdateLeadStageModel.fromJson(Map<String, dynamic> json) {
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
