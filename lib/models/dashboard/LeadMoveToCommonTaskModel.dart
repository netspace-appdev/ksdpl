class LeadMoveToCommonTaskModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  LeadMoveToCommonTaskModel(
      {this.status, this.success, this.data, this.message});

  LeadMoveToCommonTaskModel.fromJson(Map<String, dynamic> json) {
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
  String? s1;

  Data({this.s1});

  Data.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    return data;
  }
}
