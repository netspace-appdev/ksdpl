
class GetLeadDetailByCustomerNumberModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  GetLeadDetailByCustomerNumberModel(
      {this.status, this.success, this.data, this.message});

  GetLeadDetailByCustomerNumberModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];

    if (json['data'] is Map) {
      data = Data.fromJson(json['data']);
    } else {
      data = null; // when data is []
    }

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
  String? name;
  String? mobileNumber;
  String? email;
  String? pincode;
  String? source;
  num? leadStage;
  num? assignedEmployeeId;
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
  num? state;
  num? district;
  num? packageId;
  num? city;
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
  num? pickedUpEmployeeId;
  String? connectorName;
  String? connectorMobileNo;
  num? connectorPercentage;
  String? existingLoans;
  num? noOfExistingLoans;
  String? moveToCommon;
  num? assignedEmployeePercentage;
  String? lastUpdatedDate;
  int? sanction;
  String? sanctionDate;
  int? login;
  String? loginDate;
  num? sanctionAmount;
  num? disburseAmount;
  num? packageAmount;
  String? cibilJSON;
  int? paymentstatus;
  int? statusUpdatedBy;
  int? otp;

  Data(
      {this.id,
        this.name,
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
        this.packageId,
        this.city,
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
        this.assignedEmployeePercentage,
        this.lastUpdatedDate,
        this.sanction,
        this.sanctionDate,
        this.login,
        this.loginDate,
        this.sanctionAmount,
        this.disburseAmount,
        this.packageAmount,
        this.cibilJSON,
        this.paymentstatus,
        this.statusUpdatedBy,
        this.otp});

  Data.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    name = json['name'];
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
    packageId = json['packageId'];
    city = json['city'];
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
    assignedEmployeePercentage = json['assignedEmployeePercentage'];
    lastUpdatedDate = json['lastUpdatedDate'];
    sanction = json['sanction'];
    sanctionDate = json['sanctionDate'];
    login = json['login'];
    loginDate = json['loginDate'];
    sanctionAmount = json['sanctionAmount'];
    disburseAmount = json['disburseAmount'];
    packageAmount = json['packageAmount'];
    cibilJSON = json['cibilJSON'];
    paymentstatus = json['paymentstatus'];
    statusUpdatedBy = json['statusUpdatedBy'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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
    data['packageId'] = this.packageId;
    data['city'] = this.city;
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
    data['assignedEmployeePercentage'] = this.assignedEmployeePercentage;
    data['lastUpdatedDate'] = this.lastUpdatedDate;
    data['sanction'] = this.sanction;
    data['sanctionDate'] = this.sanctionDate;
    data['login'] = this.login;
    data['loginDate'] = this.loginDate;
    data['sanctionAmount'] = this.sanctionAmount;
    data['disburseAmount'] = this.disburseAmount;
    data['packageAmount'] = this.packageAmount;
    data['cibilJSON'] = this.cibilJSON;
    data['paymentstatus'] = this.paymentstatus;
    data['statusUpdatedBy'] = this.statusUpdatedBy;
    data['otp'] = this.otp;
    return data;
  }
}

