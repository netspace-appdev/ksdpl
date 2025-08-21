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
  Null? employerName;
  Null? monthlyIncome;
  String? additionalSourceOfIncome;
  String? prefferedBank;
  Null? existinRelaationshipWithBank;
  String? branch;
  Null? productType;
  Null? loanApplicationNo;
  int? pickedUpEmployeeId;
  Null? connectorName;
  Null? connectorMobileNo;
  int? connectorPercentage;
  Null? existingLoans;
  int? noOfExistingLoans;
  Null? moveToCommon;
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
  Null? bankId;
  bool? illustration;
  Null? softsanctionStatus;
  String? lastUpdatedDate;
  Null? geoLocationOfOffice;
  Null? geoLocationOfResidence;
  Null? geoLocationOfProperty;
  Null? photosOfProperty;
  Null? photosOfResidence;
  Null? photosOfOffice;
  Null? reminderDate;

  Data(
      {this.id,
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
        this.reminderDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stageName = json['stageName'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    pincode = json['pincode'];
    source = json['source'];
    leadStage = json['leadStage'];
    assignedEmployeeId = json['assignedEmployeeId'];
    assignedEmployeeDate = json['assignedEmployeeDate'];
    active = json['active'];
    uploadedBy = json['uploadedBy'];
    uploadedDate = json['uploadedDate'];
    interested = json['interested'];
    doable = json['doable'];
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
    state = json['state'];
    district = json['district'];
    city = json['city'];
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
    pickedUpEmployeeId = json['pickedUpEmployeeId'];
    connectorName = json['connectorName'];
    connectorMobileNo = json['connectorMobileNo'];
    connectorPercentage = json['connectorPercentage'];
    existingLoans = json['existingLoans'];
    noOfExistingLoans = json['noOfExistingLoans'];
    moveToCommon = json['moveToCommon'];
    pickedUpEmployeeName = json['pickedUpEmployeeName'];
    pickedUpEmployeeEmail = json['pickedUpEmployeeEmail'];
    pickedUpEmployeePhoneNumber = json['pickedUpEmployeePhoneNumber'];
    assignedEmployeeName = json['assignedEmployeeName'];
    assignedEmployeeEmail = json['assignedEmployeeEmail'];
    assignedEmployeePhoneNumber = json['assignedEmployeePhoneNumber'];
    paymentstatus = json['paymentstatus'];
    statusUpdatedBy = json['statusUpdatedBy'];
    bankName = json['bankName'];
    branchName = json['branchName'];
    segmentName = json['segmentName'];
    assignedEmployeePercentage = json['assignedEmployeePercentage'];
    camNoteCount = json['camNoteCount'];
    loanDetail = json['loanDetail'];
    disburseDetail = json['disburseDetail'];
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['stageName'] = this.stageName;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['pincode'] = this.pincode;
    data['source'] = this.source;
    data['leadStage'] = this.leadStage;
    data['assignedEmployeeId'] = this.assignedEmployeeId;
    data['assignedEmployeeDate'] = this.assignedEmployeeDate;
    data['active'] = this.active;
    data['uploadedBy'] = this.uploadedBy;
    data['uploadedDate'] = this.uploadedDate;
    data['interested'] = this.interested;
    data['doable'] = this.doable;
    data['interestedDate'] = this.interestedDate;
    data['doableDate'] = this.doableDate;
    data['campaign'] = this.campaign;
    data['uniqueLeadNumber'] = this.uniqueLeadNumber;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['loanAmountRequested'] = this.loanAmountRequested;
    data['adharCard'] = this.adharCard;
    data['panCard'] = this.panCard;
    data['streetAddress'] = this.streetAddress;
    data['state'] = this.state;
    data['district'] = this.district;
    data['city'] = this.city;
    data['stateName'] = this.stateName;
    data['districtName'] = this.districtName;
    data['cityName'] = this.cityName;
    data['nationality'] = this.nationality;
    data['currentEmploymentStatus'] = this.currentEmploymentStatus;
    data['employerName'] = this.employerName;
    data['monthlyIncome'] = this.monthlyIncome;
    data['additionalSourceOfIncome'] = this.additionalSourceOfIncome;
    data['prefferedBank'] = this.prefferedBank;
    data['existinRelaationshipWithBank'] = this.existinRelaationshipWithBank;
    data['branch'] = this.branch;
    data['productType'] = this.productType;
    data['loanApplicationNo'] = this.loanApplicationNo;
    data['pickedUpEmployeeId'] = this.pickedUpEmployeeId;
    data['connectorName'] = this.connectorName;
    data['connectorMobileNo'] = this.connectorMobileNo;
    data['connectorPercentage'] = this.connectorPercentage;
    data['existingLoans'] = this.existingLoans;
    data['noOfExistingLoans'] = this.noOfExistingLoans;
    data['moveToCommon'] = this.moveToCommon;
    data['pickedUpEmployeeName'] = this.pickedUpEmployeeName;
    data['pickedUpEmployeeEmail'] = this.pickedUpEmployeeEmail;
    data['pickedUpEmployeePhoneNumber'] = this.pickedUpEmployeePhoneNumber;
    data['assignedEmployeeName'] = this.assignedEmployeeName;
    data['assignedEmployeeEmail'] = this.assignedEmployeeEmail;
    data['assignedEmployeePhoneNumber'] = this.assignedEmployeePhoneNumber;
    data['paymentstatus'] = this.paymentstatus;
    data['statusUpdatedBy'] = this.statusUpdatedBy;
    data['bankName'] = this.bankName;
    data['branchName'] = this.branchName;
    data['segmentName'] = this.segmentName;
    data['assignedEmployeePercentage'] = this.assignedEmployeePercentage;
    data['camNoteCount'] = this.camNoteCount;
    data['loanDetail'] = this.loanDetail;
    data['disburseDetail'] = this.disburseDetail;
    data['bankId'] = this.bankId;
    data['illustration'] = this.illustration;
    data['softsanctionStatus'] = this.softsanctionStatus;
    data['lastUpdatedDate'] = this.lastUpdatedDate;
    data['geoLocationOfOffice'] = this.geoLocationOfOffice;
    data['geoLocationOfResidence'] = this.geoLocationOfResidence;
    data['geoLocationOfProperty'] = this.geoLocationOfProperty;
    data['photosOfProperty'] = this.photosOfProperty;
    data['photosOfResidence'] = this.photosOfResidence;
    data['photosOfOffice'] = this.photosOfOffice;
    data['reminderDate'] = this.reminderDate;
    return data;
  }
}
