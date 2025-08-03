class UploadDocumentModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  UploadDocumentModel({this.status, this.success, this.data, this.message});

  UploadDocumentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  int? loanId;
  String? imageName;
  String? imagePath;

  Data({this.id, this.loanId, this.imageName, this.imagePath});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loanId = json['loanId'];
    imageName = json['imageName'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['loanId'] = this.loanId;
    data['imageName'] = this.imageName;
    data['imagePath'] = this.imagePath;
    return data;
  }
}
