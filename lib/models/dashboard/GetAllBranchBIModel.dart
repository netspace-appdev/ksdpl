
class GetAllBranchBIModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetAllBranchBIModel({this.status, this.success, this.data, this.message});

  GetAllBranchBIModel.fromJson(Map<String, dynamic> json) {
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
  String? branchName;
  String? branchAddress;
  String? bankName;
  String? stateName;
  String? districtName;
  String? cityName;
  String? zipCode;
  String? branchPhoneNo;
  String? email;
  String? ifsc;
  String? micrCode;
  String? branchCode;
  bool? active;

  Data(
      {this.id,
        this.branchName,
        this.branchAddress,
        this.bankName,
        this.stateName,
        this.districtName,
        this.cityName,
        this.zipCode,
        this.branchPhoneNo,
        this.email,
        this.ifsc,
        this.micrCode,
        this.branchCode,
        this.active});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchName = json['branchName'];
    branchAddress = json['branchAddress'];
    bankName = json['bankName'];
    stateName = json['stateName'];
    districtName = json['districtName'];
    cityName = json['cityName'];
    zipCode = json['zipCode'];
    branchPhoneNo = json['branchPhoneNo'];
    email = json['email'];
    ifsc = json['ifsc'];
    micrCode = json['micrCode'];
    branchCode = json['branchCode'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branchName'] = this.branchName;
    data['branchAddress'] = this.branchAddress;
    data['bankName'] = this.bankName;
    data['stateName'] = this.stateName;
    data['districtName'] = this.districtName;
    data['cityName'] = this.cityName;
    data['zipCode'] = this.zipCode;
    data['branchPhoneNo'] = this.branchPhoneNo;
    data['email'] = this.email;
    data['ifsc'] = this.ifsc;
    data['micrCode'] = this.micrCode;
    data['branchCode'] = this.branchCode;
    data['active'] = this.active;
    return data;
  }
}
