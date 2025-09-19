class GetUserByIdModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  GetUserByIdModel({this.status, this.success, this.data, this.message});

  factory GetUserByIdModel.fromJson(Map<String, dynamic> json) {
    return GetUserByIdModel(
      status: json['status'],
      success: json['success'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['status'] = status;
    result['success'] = success;
    if (data != null) {
      result['data'] = data!.toJson();
    }
    result['message'] = message;
    return result;
  }
}

class Data {
  int? id;
  int? branchId;
  String? branchName;
  String? employeeName;
  String? managerName;
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
  dynamic createdBy;
  dynamic createdDate;
  String? stateName;
  String? districtName;
  String? cityName;
  String? image;
  String? addressAsPerAddhar;
  String? aadharNumber;
  dynamic deviceID;
  dynamic fcmToken;
  int? approvedByHR;
  String? docketId;
  String? documentId;
  String? signerRefId;
  String? signerId;
  String? pdfFileUrl;
  String? signStatus;
  dynamic offerLetterURL;
  dynamic expectedJoiningDate;
  int? acceptance;

  Data({
    this.id,
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
    this.signStatus,
    this.offerLetterURL,
    this.expectedJoiningDate,
    this.acceptance,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      branchId: json['branchId'],
      branchName: json['branchName'],
      employeeName: json['employeeName'],
      managerName: json['managerName'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      whatsappNumber: json['whatsappNumber'],
      hireDate: json['hireDate'],
      jobRole: json['jobRole'],
      workPlace: json['workPlace'],
      managerID: json['managerID'],
      address: json['address'],
      state: json['state'],
      district: json['district'],
      city: json['city'],
      postalCode: json['postalCode'],
      active: json['active'],
      createdBy: json['createdBy'],
      createdDate: json['createdDate'],
      stateName: json['stateName'],
      districtName: json['districtName'],
      cityName: json['cityName'],
      image: json['image'],
      addressAsPerAddhar: json['addressAsPerAddhar'],
      aadharNumber: json['aadharNumber'],
      deviceID: json['deviceID'],
      fcmToken: json['fcmToken'],
      approvedByHR: json['approvedByHR'],
      docketId: json['docketId'],
      documentId: json['documentId'],
      signerRefId: json['signer_Ref_id'],
      signerId: json['signerId'],
      pdfFileUrl: json['pdfFileUrl'],
      signStatus: json['sIgnStatus'], // normalized in Dart, kept raw for JSON
      offerLetterURL: json['offerLetterURL'],
      expectedJoiningDate: json['expectedJoiningDate'],
      acceptance: json['acceptance'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['branchId'] = branchId;
    result['branchName'] = branchName;
    result['employeeName'] = employeeName;
    result['managerName'] = managerName;
    result['gender'] = gender;
    result['dateOfBirth'] = dateOfBirth;
    result['email'] = email;
    result['phoneNumber'] = phoneNumber;
    result['whatsappNumber'] = whatsappNumber;
    result['hireDate'] = hireDate;
    result['jobRole'] = jobRole;
    result['workPlace'] = workPlace;
    result['managerID'] = managerID;
    result['address'] = address;
    result['state'] = state;
    result['district'] = district;
    result['city'] = city;
    result['postalCode'] = postalCode;
    result['active'] = active;
    result['createdBy'] = createdBy;
    result['createdDate'] = createdDate;
    result['stateName'] = stateName;
    result['districtName'] = districtName;
    result['cityName'] = cityName;
    result['image'] = image;
    result['addressAsPerAddhar'] = addressAsPerAddhar;
    result['aadharNumber'] = aadharNumber;
    result['deviceID'] = deviceID;
    result['fcmToken'] = fcmToken;
    result['approvedByHR'] = approvedByHR;
    result['docketId'] = docketId;
    result['documentId'] = documentId;
    result['signer_Ref_id'] = signerRefId;
    result['signerId'] = signerId;
    result['pdfFileUrl'] = pdfFileUrl;
    result['sIgnStatus'] = signStatus; // keep backend key exact
    result['offerLetterURL'] = offerLetterURL;
    result['expectedJoiningDate'] = expectedJoiningDate;
    result['acceptance'] = acceptance;
    return result;
  }
}
