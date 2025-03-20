
class GetBreakingNewsModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetBreakingNewsModel({this.status, this.success, this.data, this.message});

  GetBreakingNewsModel.fromJson(Map<String, dynamic> json) {
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
  String? entryDate;
  String? title;
  String? description;
  String? effectiveDate;
  String? url;
  String? imageUrl;
  bool? active;
  int? createdBy;
  String? createdDate;
  int? updatedBy;
  String? updatedDate;
  Null? deletedBy;
  Null? deletedDate;

  Data(
      {this.id,
        this.entryDate,
        this.title,
        this.description,
        this.effectiveDate,
        this.url,
        this.imageUrl,
        this.active,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
        this.deletedBy,
        this.deletedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entryDate = json['entryDate'];
    title = json['title'];
    description = json['description'];
    effectiveDate = json['effectiveDate'];
    url = json['url'];
    imageUrl = json['imageUrl'];
    active = json['active'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    deletedBy = json['deletedBy'];
    deletedDate = json['deletedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entryDate'] = this.entryDate;
    data['title'] = this.title;
    data['description'] = this.description;
    data['effectiveDate'] = this.effectiveDate;
    data['url'] = this.url;
    data['imageUrl'] = this.imageUrl;
    data['active'] = this.active;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['updatedBy'] = this.updatedBy;
    data['updatedDate'] = this.updatedDate;
    data['deletedBy'] = this.deletedBy;
    data['deletedDate'] = this.deletedDate;
    return data;
  }
}
