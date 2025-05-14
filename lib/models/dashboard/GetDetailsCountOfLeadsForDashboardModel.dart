class GetDetailsCountOfLeadsForDashboardModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetDetailsCountOfLeadsForDashboardModel(
      {this.status, this.success, this.data, this.message});

  GetDetailsCountOfLeadsForDashboardModel.fromJson(Map<String, dynamic> json) {
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
  String? headingName;
  int? count;
  int? amount;

  Data({this.headingName, this.count, this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    headingName = json['headingName'];
    count = json['count'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['headingName'] = this.headingName;
    data['count'] = this.count;
    data['amount'] = this.amount;
    return data;
  }
}
