class RemovedLoanApplicationDocumentModel {
  String? status;
  bool? success;
  List<DataModel>? data;
  String? message;

  RemovedLoanApplicationDocumentModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  RemovedLoanApplicationDocumentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach((v) {
        data!.add(DataModel.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['status'] = status;
    dataMap['success'] = success;
    if (data != null) {
      dataMap['data'] = data!.map((v) => v.toJson()).toList();
    }
    dataMap['message'] = message;
    return dataMap;
  }
}
class DataModel {
  String? id;
  String? name;

  DataModel({this.id, this.name});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

