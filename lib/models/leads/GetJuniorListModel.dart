class GetJuniorListModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetJuniorListModel({this.status, this.success, this.data, this.message});

  GetJuniorListModel.fromJson(Map<String, dynamic> json) {
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
  Null? managerName;
  String? gender;
  String? dateOfBirth;
  String? email;
  String? phoneNumber;
  String? whatsappNumber;
  String? hireDate;
  String? jobRole;
  String? workPlace;
  int? managerID;
  String? address;
  int? state;
  int? district;
  int? city;
  String? postalCode;
  bool? active;
  String? createdBy;
  Null? createdDate;
  String? stateName;
  String? districtName;
  String? cityName;
  String? image;
  Null? addressAsPerAddhar;
  Null? aadharNumber;
  String? deviceID;
  String? fcmToken;
  int? approvedByHR;
  String? docketId;
  String? documentId;
  String? signerRefId;
  String? signerId;
  String? pdfFileUrl;
  String? sIgnStatus;
  String? offerLetterURL;
  Null? expectedJoiningDate;
  int? acceptance;
  int? channelId;
  String? channelName;
  String? shortChannelName;
  String? channelLogo;
  Null? currentBankAccount;
  Null? ifsc;
  int? offerLetterId;

  Data(
      {this.id,
        this.branchId,
        this.branchName,
        this.employeeName,
        this.managerName,
        this.gender,
        this.dateOfBirth,
        this.email,
        this.phoneNumber,
        this.whatsappNumber,
        this.hireDate,
        this.jobRole,
        this.workPlace,
        this.managerID,
        this.address,
        this.state,
        this.district,
        this.city,
        this.postalCode,
        this.active,
        this.createdBy,
        this.createdDate,
        this.stateName,
        this.districtName,
        this.cityName,
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
        this.offerLetterURL,
        this.expectedJoiningDate,
        this.acceptance,
        this.channelId,
        this.channelName,
        this.shortChannelName,
        this.channelLogo,
        this.currentBankAccount,
        this.ifsc,
        this.offerLetterId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branchId'];
    branchName = json['branchName'];
    employeeName = json['employeeName'];
    managerName = json['managerName'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    whatsappNumber = json['whatsappNumber'];
    hireDate = json['hireDate'];
    jobRole = json['jobRole'];
    workPlace = json['workPlace'];
    managerID = json['managerID'];
    address = json['address'];
    state = json['state'];
    district = json['district'];
    city = json['city'];
    postalCode = json['postalCode'];
    active = json['active'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    stateName = json['stateName'];
    districtName = json['districtName'];
    cityName = json['cityName'];
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
    offerLetterURL = json['offerLetterURL'];
    expectedJoiningDate = json['expectedJoiningDate'];
    acceptance = json['acceptance'];
    channelId = json['channelId'];
    channelName = json['channelName'];
    shortChannelName = json['shortChannelName'];
    channelLogo = json['channelLogo'];
    currentBankAccount = json['currentBankAccount'];
    ifsc = json['ifsc'];
    offerLetterId = json['offerLetterId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branchId'] = this.branchId;
    data['branchName'] = this.branchName;
    data['employeeName'] = this.employeeName;
    data['managerName'] = this.managerName;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['whatsappNumber'] = this.whatsappNumber;
    data['hireDate'] = this.hireDate;
    data['jobRole'] = this.jobRole;
    data['workPlace'] = this.workPlace;
    data['managerID'] = this.managerID;
    data['address'] = this.address;
    data['state'] = this.state;
    data['district'] = this.district;
    data['city'] = this.city;
    data['postalCode'] = this.postalCode;
    data['active'] = this.active;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['stateName'] = this.stateName;
    data['districtName'] = this.districtName;
    data['cityName'] = this.cityName;
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
    data['offerLetterURL'] = this.offerLetterURL;
    data['expectedJoiningDate'] = this.expectedJoiningDate;
    data['acceptance'] = this.acceptance;
    data['channelId'] = this.channelId;
    data['channelName'] = this.channelName;
    data['shortChannelName'] = this.shortChannelName;
    data['channelLogo'] = this.channelLogo;
    data['currentBankAccount'] = this.currentBankAccount;
    data['ifsc'] = this.ifsc;
    data['offerLetterId'] = this.offerLetterId;
    return data;
  }
}
