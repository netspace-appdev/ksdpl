class GetAllCommonDocumentModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetAllCommonDocumentModel(
      {this.status, this.success, this.data, this.message});

  GetAllCommonDocumentModel.fromJson(Map<String, dynamic> json) {
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
  String? commonDocument1;
  String? documentType;
  int? active;

  Data({this.id, this.commonDocument1, this.documentType, this.active});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commonDocument1 = json['commonDocument1'];
    documentType = json['documentType'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['commonDocument1'] = this.commonDocument1;
    data['documentType'] = this.documentType;
    data['active'] = this.active;
    return data;
  }
}
