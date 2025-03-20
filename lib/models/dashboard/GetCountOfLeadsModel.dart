
class GetCountOfLeadsModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetCountOfLeadsModel({this.status, this.success, this.data, this.message});

  GetCountOfLeadsModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? stageName;
  int? leadCount;

  Data({this.id, this.stageName, this.leadCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stageName = json['stageName'];
    leadCount = json['leadCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stageName'] = this.stageName;
    data['leadCount'] = this.leadCount;
    return data;
  }
}
