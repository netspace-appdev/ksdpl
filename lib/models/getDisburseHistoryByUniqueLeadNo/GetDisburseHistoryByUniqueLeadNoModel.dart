class GetDisburseHistoryByUniqueLeadNoModel {
  String? status;
  bool? success;
  Data? data;
  String? message;

  GetDisburseHistoryByUniqueLeadNoModel(
      {this.status, this.success, this.data, this.message});

  GetDisburseHistoryByUniqueLeadNoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['status'] = status;
    map['success'] = success;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    map['message'] = message;
    return map;
  }
}

class Data {
  int? id;
  String? name;
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
  String? assignedEmployeeName;
  String? bankName;
  String? branchName;
  String? productCategoryName;
  int? assignedEmployeePercentage;
  String? lastUpdatedDate;
  String? stageName;
  String? employeeName;
  String? pickupEmployeeName;
  String? productName;
  int? sanctionAmount;
  int? disburseAmount;
  int? leadsegment;
  int? packageId;
  int? packageAmount;
  int? receiveableAmount;
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

  Data({
    this.id,
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
    this.cibilJSON,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = (json['id'] as num?)?.toInt();
    name = json['name'];
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
    assignedEmployeeName = json['assignedEmployeeName'];
    bankName = json['bankName'];
    branchName = json['branchName'];
    productCategoryName = json['productCategoryName'];
    assignedEmployeePercentage = (json['assignedEmployeePercentage'] as num?)?.toInt();
    lastUpdatedDate = json['lastUpdatedDate'];
    stageName = json['stageName'];
    employeeName = json['employeeName'];
    pickupEmployeeName = json['pickupEmployeeName'];
    productName = json['productName'];
    sanctionAmount = (json['sanctionAmount'] as num?)?.toInt();
    disburseAmount = (json['disburseAmount'] as num?)?.toInt();
    leadsegment = (json['leadsegment'] as num?)?.toInt();
    packageId = (json['packageId'] as num?)?.toInt();
    packageAmount = (json['packageAmount'] as num?)?.toInt();
    receiveableAmount = (json['receiveableAmount'] as num?)?.toInt();
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
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['mobileNumber'] = mobileNumber;
    map['email'] = email;
    map['pincode'] = pincode;
    map['source'] = source;
    map['leadStage'] = leadStage;
    map['assignedEmployeeId'] = assignedEmployeeId;
    map['assignedEmployeeDate'] = assignedEmployeeDate;
    map['active'] = active;
    map['uploadedBy'] = uploadedBy;
    map['uploadedDate'] = uploadedDate;
    map['interested'] = interested;
    map['doable'] = doable;
    map['interestedDate'] = interestedDate;
    map['doableDate'] = doableDate;
    map['campaign'] = campaign;
    map['uniqueLeadNumber'] = uniqueLeadNumber;
    map['dateOfBirth'] = dateOfBirth;
    map['gender'] = gender;
    map['loanAmountRequested'] = loanAmountRequested;
    map['adharCard'] = adharCard;
    map['panCard'] = panCard;
    map['streetAddress'] = streetAddress;
    map['state'] = state;
    map['district'] = district;
    map['city'] = city;
    map['stateName'] = stateName;
    map['districtName'] = districtName;
    map['cityName'] = cityName;
    map['nationality'] = nationality;
    map['currentEmploymentStatus'] = currentEmploymentStatus;
    map['employerName'] = employerName;
    map['monthlyIncome'] = monthlyIncome;
    map['additionalSourceOfIncome'] = additionalSourceOfIncome;
    map['prefferedBank'] = prefferedBank;
    map['existinRelaationshipWithBank'] = existinRelaationshipWithBank;
    map['branch'] = branch;
    map['productType'] = productType;
    map['loanApplicationNo'] = loanApplicationNo;
    map['pickedUpEmployeeId'] = pickedUpEmployeeId;
    map['connectorName'] = connectorName;
    map['connectorMobileNo'] = connectorMobileNo;
    map['connectorPercentage'] = connectorPercentage;
    map['existingLoans'] = existingLoans;
    map['noOfExistingLoans'] = noOfExistingLoans;
    map['moveToCommon'] = moveToCommon;
    map['pickedUpEmployeeName'] = pickedUpEmployeeName;
    map['assignedEmployeeName'] = assignedEmployeeName;
    map['bankName'] = bankName;
    map['branchName'] = branchName;
    map['productCategoryName'] = productCategoryName;
    map['assignedEmployeePercentage'] = assignedEmployeePercentage;
    map['lastUpdatedDate'] = lastUpdatedDate;
    map['stageName'] = stageName;
    map['employeeName'] = employeeName;
    map['pickupEmployeeName'] = pickupEmployeeName;
    map['productName'] = productName;
    map['sanctionAmount'] = sanctionAmount;
    map['disburseAmount'] = disburseAmount;
    map['leadsegment'] = leadsegment;
    map['packageId'] = packageId;
    map['packageAmount'] = packageAmount;
    map['receiveableAmount'] = receiveableAmount;
    map['receiveableDate'] = receiveableDate;
    map['transactionDetails'] = transactionDetails;
    map['remark'] = remark;
    map['geoLocationOfOffice'] = geoLocationOfOffice;
    map['geoLocationOfResidence'] = geoLocationOfResidence;
    map['geoLocationOfProperty'] = geoLocationOfProperty;
    map['photosOfProperty'] = photosOfProperty;
    map['photosOfResidence'] = photosOfResidence;
    map['photosOfOffice'] = photosOfOffice;
    map['cibilJSON'] = cibilJSON;
    return map;
  }
}
