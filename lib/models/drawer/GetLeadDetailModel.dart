
class GetLeadDetailModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  GetLeadDetailModel({this.status, this.success, this.data, this.message});

  GetLeadDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
  double? connectorPercentage;
  String? existingLoans;
  int? noOfExistingLoans;
  String? moveToCommon;
  double? assignedEmployeePercentage;
  String? lastUpdatedDate;

  // New fields from API response
  String? stateName;
  String? districtName;
  String? cityName;
  String? pickedUpEmployeeName;
  String? assignedEmployeeName;
  String? bankName;
  String? branchName;
  String? productCategoryName;
  String? employeeName;
  String? pickupEmployeeName;
  String? productName;

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
    // New fields
    this.stateName,
    this.districtName,
    this.cityName,
    this.pickedUpEmployeeName,
    this.assignedEmployeeName,
    this.bankName,
    this.branchName,
    this.productCategoryName,
    this.employeeName,
    this.pickupEmployeeName,
    this.productName,
  });

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
    connectorPercentage = (json['connectorPercentage'] as num?)?.toDouble();
    existingLoans = json['existingLoans'];
    noOfExistingLoans = json['noOfExistingLoans'];
    moveToCommon = json['moveToCommon'];
    assignedEmployeePercentage = (json['assignedEmployeePercentage'] as num?)?.toDouble();
    lastUpdatedDate = json['lastUpdatedDate'];

    // New fields from API response
    stateName = json['stateName'];
    districtName = json['districtName'];
    cityName = json['cityName'];
    pickedUpEmployeeName = json['pickedUpEmployeeName'];
    assignedEmployeeName = json['assignedEmployeeName'];
    bankName = json['bankName'];
    branchName = json['branchName'];
    productCategoryName = json['productCategoryName'];
    employeeName = json['employeeName'];
    pickupEmployeeName = json['pickupEmployeeName'];
    productName = json['productName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['stageName'] = stageName;
    data['mobileNumber'] = mobileNumber;
    data['email'] = email;
    data['pincode'] = pincode;
    data['source'] = source;
    data['leadStage'] = leadStage;
    data['assignedEmployeeId'] = assignedEmployeeId;
    data['assignedEmployeeDate'] = assignedEmployeeDate;
    data['active'] = active;
    data['uploadedBy'] = uploadedBy;
    data['uploadedDate'] = uploadedDate;
    data['interested'] = interested;
    data['doable'] = doable;
    data['interestedDate'] = interestedDate;
    data['doableDate'] = doableDate;
    data['campaign'] = campaign;
    data['uniqueLeadNumber'] = uniqueLeadNumber;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    data['loanAmountRequested'] = loanAmountRequested;
    data['adharCard'] = adharCard;
    data['panCard'] = panCard;
    data['streetAddress'] = streetAddress;
    data['state'] = state;
    data['district'] = district;
    data['city'] = city;
    data['nationality'] = nationality;
    data['currentEmploymentStatus'] = currentEmploymentStatus;
    data['employerName'] = employerName;
    data['monthlyIncome'] = monthlyIncome;
    data['additionalSourceOfIncome'] = additionalSourceOfIncome;
    data['prefferedBank'] = prefferedBank;
    data['existinRelaationshipWithBank'] = existinRelaationshipWithBank;
    data['branch'] = branch;
    data['productType'] = productType;
    data['loanApplicationNo'] = loanApplicationNo;
    data['pickedUpEmployeeId'] = pickedUpEmployeeId;
    data['connectorName'] = connectorName;
    data['connectorMobileNo'] = connectorMobileNo;
    data['connectorPercentage'] = connectorPercentage;
    data['existingLoans'] = existingLoans;
    data['noOfExistingLoans'] = noOfExistingLoans;
    data['moveToCommon'] = moveToCommon;
    data['assignedEmployeePercentage'] = assignedEmployeePercentage;
    data['lastUpdatedDate'] = lastUpdatedDate;

    // New fields
    data['stateName'] = stateName;
    data['districtName'] = districtName;
    data['cityName'] = cityName;
    data['pickedUpEmployeeName'] = pickedUpEmployeeName;
    data['assignedEmployeeName'] = assignedEmployeeName;
    data['bankName'] = bankName;
    data['branchName'] = branchName;
    data['productCategoryName'] = productCategoryName;
    data['employeeName'] = employeeName;
    data['pickupEmployeeName'] = pickupEmployeeName;
    data['productName'] = productName;

    return data;
  }
}


