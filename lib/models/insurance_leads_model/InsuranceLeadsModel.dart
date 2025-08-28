class InsuranceLeadsModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  InsuranceLeadsModel({this.status, this.success, this.data, this.message});

  InsuranceLeadsModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? stageName;
  String? mobileNumber;
  String? email;
  String? pincode;
  String? source;
  int? leadStage;
  int? assignedEmployeeId;
  String? assignedEmployeeDate;
  bool? active;
  String? uploadedBy;
  String? uploadedDate;
  int? interested;
  int? doable;
  String? interestedDate;
  String? doableDate;
  String? campaign;
  String? uniqueLeadNumber;
  String? dateOfBirth;
  String? gender;
  String? loanAmountRequested;
  String? adharCard;
  String? panCard;
  String? streetAddress;
  int? state;
  int? district;
  int? city;
  String? stateName;
  String? districtName;
  String? cityName;
  String? nationality;
  String? currentEmploymentStatus;
  String? employerName;
  String? monthlyIncome;
  String? additionalSourceOfIncome;
  String? prefferedBank;
  String? existinRelaationshipWithBank;
  String? branch;
  String? productType;
  String? loanApplicationNo;
  int? pickedUpEmployeeId;
  String? connectorName;
  String? connectorMobileNo;
  int? connectorPercentage;
  String? existingLoans;
  int? noOfExistingLoans;
  String? moveToCommon;
  String? pickedUpEmployeeName;
  String? pickedUpEmployeeEmail;
  String? pickedUpEmployeePhoneNumber;
  String? assignedEmployeeName;
  String? assignedEmployeeEmail;
  String? assignedEmployeePhoneNumber;
  int? paymentstatus;
  int? statusUpdatedBy;
  String? bankName;
  String? branchName;
  String? segmentName;
  int? assignedEmployeePercentage;
  int? camNoteCount;
  int? loanDetail;
  int? disburseDetail;
  String? bankId;
  bool? illustration;
  String? softsanctionStatus;
  String? lastUpdatedDate;
  String? geoLocationOfOffice;
  String? geoLocationOfResidence;
  String? geoLocationOfProperty;
  String? photosOfProperty;
  String? photosOfResidence;
  String? photosOfOffice;
  String? reminderDate;

  Data({
    this.id,
    this.name,
    this.stageName,
    this.mobileNumber,
    this.email,
    this.pincode,
    this.source,
    this.leadStage,
    this.assignedEmployeeId,
    this.assignedEmployeeDate,
    this.active,
    this.uploadedBy,
    this.uploadedDate,
    this.interested,
    this.doable,
    this.interestedDate,
    this.doableDate,
    this.campaign,
    this.uniqueLeadNumber,
    this.dateOfBirth,
    this.gender,
    this.loanAmountRequested,
    this.adharCard,
    this.panCard,
    this.streetAddress,
    this.state,
    this.district,
    this.city,
    this.stateName,
    this.districtName,
    this.cityName,
    this.nationality,
    this.currentEmploymentStatus,
    this.employerName,
    this.monthlyIncome,
    this.additionalSourceOfIncome,
    this.prefferedBank,
    this.existinRelaationshipWithBank,
    this.branch,
    this.productType,
    this.loanApplicationNo,
    this.pickedUpEmployeeId,
    this.connectorName,
    this.connectorMobileNo,
    this.connectorPercentage,
    this.existingLoans,
    this.noOfExistingLoans,
    this.moveToCommon,
    this.pickedUpEmployeeName,
    this.pickedUpEmployeeEmail,
    this.pickedUpEmployeePhoneNumber,
    this.assignedEmployeeName,
    this.assignedEmployeeEmail,
    this.assignedEmployeePhoneNumber,
    this.paymentstatus,
    this.statusUpdatedBy,
    this.bankName,
    this.branchName,
    this.segmentName,
    this.assignedEmployeePercentage,
    this.camNoteCount,
    this.loanDetail,
    this.disburseDetail,
    this.bankId,
    this.illustration,
    this.softsanctionStatus,
    this.lastUpdatedDate,
    this.geoLocationOfOffice,
    this.geoLocationOfResidence,
    this.geoLocationOfProperty,
    this.photosOfProperty,
    this.photosOfResidence,
    this.photosOfOffice,
    this.reminderDate,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stageName = json['stageName'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    pincode = json['pincode'];
    source = json['source'];
    leadStage = (json['leadStage'] as num?)?.toInt();
    assignedEmployeeId = (json['assignedEmployeeId'] as num?)?.toInt();
    assignedEmployeeDate = json['assignedEmployeeDate'];
    active = json['active'];
    uploadedBy = json['uploadedBy'];
    uploadedDate = json['uploadedDate'];
    interested = (json['interested'] as num?)?.toInt();
    doable = (json['doable'] as num?)?.toInt();
    interestedDate = json['interestedDate'];
    doableDate = json['doableDate'];
    campaign = json['campaign'];
    uniqueLeadNumber = json['uniqueLeadNumber'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    loanAmountRequested = json['loanAmountRequested'];
    adharCard = json['adharCard'];
    panCard = json['panCard'];
    streetAddress = json['streetAddress'];
    state = (json['state'] as num?)?.toInt();
    district = (json['district'] as num?)?.toInt();
    city = (json['city'] as num?)?.toInt();
    stateName = json['stateName'];
    districtName = json['districtName'];
    cityName = json['cityName'];
    nationality = json['nationality'];
    currentEmploymentStatus = json['currentEmploymentStatus'];
    employerName = json['employerName'];
    monthlyIncome = json['monthlyIncome'];
    additionalSourceOfIncome = json['additionalSourceOfIncome'];
    prefferedBank = json['prefferedBank'];
    existinRelaationshipWithBank = json['existinRelaationshipWithBank'];
    branch = json['branch'];
    productType = json['productType'];
    loanApplicationNo = json['loanApplicationNo'];
    pickedUpEmployeeId = (json['pickedUpEmployeeId'] as num?)?.toInt();
    connectorName = json['connectorName'];
    connectorMobileNo = json['connectorMobileNo'];
    connectorPercentage = (json['connectorPercentage'] as num?)?.toInt();
    existingLoans = json['existingLoans'];
    noOfExistingLoans = (json['noOfExistingLoans'] as num?)?.toInt();
    moveToCommon = json['moveToCommon'];
    pickedUpEmployeeName = json['pickedUpEmployeeName'];
    pickedUpEmployeeEmail = json['pickedUpEmployeeEmail'];
    pickedUpEmployeePhoneNumber = json['pickedUpEmployeePhoneNumber'];
    assignedEmployeeName = json['assignedEmployeeName'];
    assignedEmployeeEmail = json['assignedEmployeeEmail'];
    assignedEmployeePhoneNumber = json['assignedEmployeePhoneNumber'];
    paymentstatus = (json['paymentstatus'] as num?)?.toInt();
    statusUpdatedBy = (json['statusUpdatedBy'] as num?)?.toInt();
    bankName = json['bankName'];
    branchName = json['branchName'];
    segmentName = json['segmentName'];
    assignedEmployeePercentage = (json['assignedEmployeePercentage'] as num?)?.toInt();
    camNoteCount = (json['camNoteCount'] as num?)?.toInt();
    loanDetail = (json['loanDetail'] as num?)?.toInt();
    disburseDetail = (json['disburseDetail'] as num?)?.toInt();
    bankId = json['bankId'];
    illustration = json['illustration'];
    softsanctionStatus = json['softsanctionStatus'];
    lastUpdatedDate = json['lastUpdatedDate'];
    geoLocationOfOffice = json['geoLocationOfOffice'];
    geoLocationOfResidence = json['geoLocationOfResidence'];
    geoLocationOfProperty = json['geoLocationOfProperty'];
    photosOfProperty = json['photosOfProperty'];
    photosOfResidence = json['photosOfResidence'];
    photosOfOffice = json['photosOfOffice'];
    reminderDate = json['reminderDate'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'stageName': stageName,
      'mobileNumber': mobileNumber,
      'email': email,
      'pincode': pincode,
      'source': source,
      'leadStage': leadStage,
      'assignedEmployeeId': assignedEmployeeId,
      'assignedEmployeeDate': assignedEmployeeDate,
      'active': active,
      'uploadedBy': uploadedBy,
      'uploadedDate': uploadedDate,
      'interested': interested,
      'doable': doable,
      'interestedDate': interestedDate,
      'doableDate': doableDate,
      'campaign': campaign,
      'uniqueLeadNumber': uniqueLeadNumber,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'loanAmountRequested': loanAmountRequested,
      'adharCard': adharCard,
      'panCard': panCard,
      'streetAddress': streetAddress,
      'state': state,
      'district': district,
      'city': city,
      'stateName': stateName,
      'districtName': districtName,
      'cityName': cityName,
      'nationality': nationality,
      'currentEmploymentStatus': currentEmploymentStatus,
      'employerName': employerName,
      'monthlyIncome': monthlyIncome,
      'additionalSourceOfIncome': additionalSourceOfIncome,
      'prefferedBank': prefferedBank,
      'existinRelaationshipWithBank': existinRelaationshipWithBank,
      'branch': branch,
      'productType': productType,
      'loanApplicationNo': loanApplicationNo,
      'pickedUpEmployeeId': pickedUpEmployeeId,
      'connectorName': connectorName,
      'connectorMobileNo': connectorMobileNo,
      'connectorPercentage': connectorPercentage,
      'existingLoans': existingLoans,
      'noOfExistingLoans': noOfExistingLoans,
      'moveToCommon': moveToCommon,
      'pickedUpEmployeeName': pickedUpEmployeeName,
      'pickedUpEmployeeEmail': pickedUpEmployeeEmail,
      'pickedUpEmployeePhoneNumber': pickedUpEmployeePhoneNumber,
      'assignedEmployeeName': assignedEmployeeName,
      'assignedEmployeeEmail': assignedEmployeeEmail,
      'assignedEmployeePhoneNumber': assignedEmployeePhoneNumber,
      'paymentstatus': paymentstatus,
      'statusUpdatedBy': statusUpdatedBy,
      'bankName': bankName,
      'branchName': branchName,
      'segmentName': segmentName,
      'assignedEmployeePercentage': assignedEmployeePercentage,
      'camNoteCount': camNoteCount,
      'loanDetail': loanDetail,
      'disburseDetail': disburseDetail,
      'bankId': bankId,
      'illustration': illustration,
      'softsanctionStatus': softsanctionStatus,
      'lastUpdatedDate': lastUpdatedDate,
      'geoLocationOfOffice': geoLocationOfOffice,
      'geoLocationOfResidence': geoLocationOfResidence,
      'geoLocationOfProperty': geoLocationOfProperty,
      'photosOfProperty': photosOfProperty,
      'photosOfResidence': photosOfResidence,
      'photosOfOffice': photosOfOffice,
      'reminderDate': reminderDate,
    };
  }
}


