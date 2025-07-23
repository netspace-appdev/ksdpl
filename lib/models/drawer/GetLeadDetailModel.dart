
class GetLeadDetailModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  GetLeadDetailModel({this.status, this.success, this.data, this.message});

  GetLeadDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  int? assignedEmployeeId;
  String? assignedEmployeeDate;
  bool? active;
  String? uploadedBy;
  String? uploadedDate;
  num? interested;
  num? doable;
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
  num? city;
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
  num? pickedUpEmployeeId;
  String? connectorName;
  String? connectorMobileNo;
  num? connectorPercentage;
  String? existingLoans;
  num? noOfExistingLoans;
  String? moveToCommon;
  String? pickedUpEmployeeName;
  String? assignedEmployeeName;
  String? bankName;
  String? branchName;
  String? productCategoryName;
  num? assignedEmployeePercentage;
  String? lastUpdatedDate;
  String? stageName;
  String? employeeName;
  String? pickupEmployeeName;
  String? productName;
  num? sanctionAmount;
  num? disburseAmount;
  num? leadsegment;
  int? packageId;
  num? packageAmount;
  num? receiveableAmount;
  String? receiveableDate;
  String? transactionDetails;
  String? remark;
  String? geoLocationOfOffice;
  String? geoLocationOfResidence;
  String? geoLocationOfProperty;
  String? photosOfProperty;
  String? photosOfResidence;
  String? photosOfOffice;
  String? cibilJSON;
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
        this.assignedEmployeeName,
        this.bankName,
        this.branchName,
        this.productCategoryName,
        this.assignedEmployeePercentage,
        this.lastUpdatedDate,
        this.stageName,
        this.employeeName,
        this.pickupEmployeeName,
        this.productName,
        this.sanctionAmount,
        this.disburseAmount,
        this.leadsegment,
        this.packageId,
        this.packageAmount,
        this.receiveableAmount,
        this.receiveableDate,
        this.transactionDetails,
        this.remark,
        this.geoLocationOfOffice,
        this.geoLocationOfResidence,
        this.geoLocationOfProperty,
        this.photosOfProperty,
        this.photosOfResidence,
        this.photosOfOffice,
        this.cibilJSON});

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
    assignedEmployeeName = json['assignedEmployeeName'];
    bankName = json['bankName'];
    branchName = json['branchName'];
    productCategoryName = json['productCategoryName'];
    assignedEmployeePercentage = json['assignedEmployeePercentage'];
    lastUpdatedDate = json['lastUpdatedDate'];
    stageName = json['stageName'];
    employeeName = json['employeeName'];
    pickupEmployeeName = json['pickupEmployeeName'];
    productName = json['productName'];
    sanctionAmount = json['sanctionAmount'];
    disburseAmount = json['disburseAmount'];
    leadsegment = json['leadsegment'];
    packageId = json['packageId'];
    packageAmount = json['packageAmount'];
    receiveableAmount = json['receiveableAmount'];
    receiveableDate = json['receiveableDate'];
    transactionDetails = json['transactionDetails'];
    remark = json['remark'];
    geoLocationOfOffice = json['geoLocationOfOffice'];
    geoLocationOfResidence = json['geoLocationOfResidence'];
    geoLocationOfProperty = json['geoLocationOfProperty'];
    photosOfProperty = json['photosOfProperty'];
    photosOfResidence = json['photosOfResidence'];
    photosOfOffice = json['photosOfOffice'];
    cibilJSON = json['cibilJSON'];
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
    data['assignedEmployeeName'] = this.assignedEmployeeName;
    data['bankName'] = this.bankName;
    data['branchName'] = this.branchName;
    data['productCategoryName'] = this.productCategoryName;
    data['assignedEmployeePercentage'] = this.assignedEmployeePercentage;
    data['lastUpdatedDate'] = this.lastUpdatedDate;
    data['stageName'] = this.stageName;
    data['employeeName'] = this.employeeName;
    data['pickupEmployeeName'] = this.pickupEmployeeName;
    data['productName'] = this.productName;
    data['sanctionAmount'] = this.sanctionAmount;
    data['disburseAmount'] = this.disburseAmount;
    data['leadsegment'] = this.leadsegment;
    data['packageId'] = this.packageId;
    data['packageAmount'] = this.packageAmount;
    data['receiveableAmount'] = this.receiveableAmount;
    data['receiveableDate'] = this.receiveableDate;
    data['transactionDetails'] = this.transactionDetails;
    data['remark'] = this.remark;
    data['geoLocationOfOffice'] = this.geoLocationOfOffice;
    data['geoLocationOfResidence'] = this.geoLocationOfResidence;
    data['geoLocationOfProperty'] = this.geoLocationOfProperty;
    data['photosOfProperty'] = this.photosOfProperty;
    data['photosOfResidence'] = this.photosOfResidence;
    data['photosOfOffice'] = this.photosOfOffice;
    data['cibilJSON'] = this.cibilJSON;
    return data;
  }
}
