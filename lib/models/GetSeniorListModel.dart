class GetSeniorListModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetSeniorListModel({this.status, this.success, this.data, this.message});

  GetSeniorListModel.fromJson(Map<String, dynamic> json) {
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
  int? branchId;
  String? branchName;
  String? employeeName;
  String? gender;
  String? dateOfBirth;
  String? email;
  String? phoneNumber;
  String? whatsappNumber;
  String? hireDate;
  String? jobRole;
  String? workPlace;
  int? managerId;
  String? address;
  int? state;
  int? district;
  int? city;
  String? postalCode;
  bool? active;
  String? stateName;
  String? districtName;
  String? cityName;
  String? managerName;
  String? image;
  String? addressAsPerAddhar;
  String? aadharNumber;
  String? deviceID;
  String? fcmToken;
  int? approvedByHR;
  String? docketId;
  String? documentId;
  String? signerRefId;
  String? signerId;
  String? pdfFileUrl;
  String? sIgnStatus;
  String? offerLetterUrl;
  int? acceptanceStatus;
  String? acceptanceDate;
  Null? leftDate;
  int? channelId;
  String? channelName;
  String? channelCode;
  String? channelLogo;
  int? currentBankAccount;
  String? ifsc;

  Data(
      {this.id,
        this.branchId,
        this.branchName,
        this.employeeName,
        this.gender,
        this.dateOfBirth,
        this.email,
        this.phoneNumber,
        this.whatsappNumber,
        this.hireDate,
        this.jobRole,
        this.workPlace,
        this.managerId,
        this.address,
        this.state,
        this.district,
        this.city,
        this.postalCode,
        this.active,
        this.stateName,
        this.districtName,
        this.cityName,
        this.managerName,
        this.image,
        this.addressAsPerAddhar,
        this.aadharNumber,
        this.deviceID,
        this.fcmToken,
        this.approvedByHR,
        this.docketId,
        this.documentId,
        this.signerRefId,
        this.signerId,
        this.pdfFileUrl,
        this.sIgnStatus,
        this.offerLetterUrl,
        this.acceptanceStatus,
        this.acceptanceDate,
        this.leftDate,
        this.channelId,
        this.channelName,
        this.channelCode,
        this.channelLogo,
        this.currentBankAccount,
        this.ifsc});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branchId'];
    branchName = json['branchName'];
    employeeName = json['employeeName'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    whatsappNumber = json['whatsappNumber'];
    hireDate = json['hireDate'];
    jobRole = json['jobRole'];
    workPlace = json['workPlace'];
    managerId = json['managerId'];
    address = json['address'];
    state = json['state'];
    district = json['district'];
    city = json['city'];
    postalCode = json['postalCode'];
    active = json['active'];
    stateName = json['stateName'];
    districtName = json['districtName'];
    cityName = json['cityName'];
    managerName = json['managerName'];
    image = json['image'];
    addressAsPerAddhar = json['addressAsPerAddhar'];
    aadharNumber = json['aadharNumber'];
    deviceID = json['deviceID'];
    fcmToken = json['fcmToken'];
    approvedByHR = json['approvedByHR'];
    docketId = json['docketId'];
    documentId = json['documentId'];
    signerRefId = json['signer_Ref_id'];
    signerId = json['signerId'];
    pdfFileUrl = json['pdfFileUrl'];
    sIgnStatus = json['sIgnStatus'];
    offerLetterUrl = json['offerLetterUrl'];
    acceptanceStatus = json['acceptanceStatus'];
    acceptanceDate = json['acceptanceDate'];
    leftDate = json['leftDate'];
    channelId = json['channelId'];
    channelName = json['channelName'];
    channelCode = json['channelCode'];
    channelLogo = json['channelLogo'];
    currentBankAccount = json['currentBankAccount'];
    ifsc = json['ifsc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branchId'] = this.branchId;
    data['branchName'] = this.branchName;
    data['employeeName'] = this.employeeName;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['whatsappNumber'] = this.whatsappNumber;
    data['hireDate'] = this.hireDate;
    data['jobRole'] = this.jobRole;
    data['workPlace'] = this.workPlace;
    data['managerId'] = this.managerId;
    data['address'] = this.address;
    data['state'] = this.state;
    data['district'] = this.district;
    data['city'] = this.city;
    data['postalCode'] = this.postalCode;
    data['active'] = this.active;
    data['stateName'] = this.stateName;
    data['districtName'] = this.districtName;
    data['cityName'] = this.cityName;
    data['managerName'] = this.managerName;
    data['image'] = this.image;
    data['addressAsPerAddhar'] = this.addressAsPerAddhar;
    data['aadharNumber'] = this.aadharNumber;
    data['deviceID'] = this.deviceID;
    data['fcmToken'] = this.fcmToken;
    data['approvedByHR'] = this.approvedByHR;
    data['docketId'] = this.docketId;
    data['documentId'] = this.documentId;
    data['signer_Ref_id'] = this.signerRefId;
    data['signerId'] = this.signerId;
    data['pdfFileUrl'] = this.pdfFileUrl;
    data['sIgnStatus'] = this.sIgnStatus;
    data['offerLetterUrl'] = this.offerLetterUrl;
    data['acceptanceStatus'] = this.acceptanceStatus;
    data['acceptanceDate'] = this.acceptanceDate;
    data['leftDate'] = this.leftDate;
    data['channelId'] = this.channelId;
    data['channelName'] = this.channelName;
    data['channelCode'] = this.channelCode;
    data['channelLogo'] = this.channelLogo;
    data['currentBankAccount'] = this.currentBankAccount;
    data['ifsc'] = this.ifsc;
    return data;
  }
}
