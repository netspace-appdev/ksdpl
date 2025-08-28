

class GetAllLeadsModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetAllLeadsModel({this.status, this.success, this.data, this.message});

  GetAllLeadsModel.fromJson(Map<String, dynamic> json) {
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
  String? mobileNumber;
  String? email;
  String? pincode;
  String? source;
  String? stageName;
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

  // New Fields
  String? dateOfBirth;
  String? gender;
  dynamic loanAmountRequested;
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
  dynamic monthlyIncome;
  String? additionalSourceOfIncome;
  String? prefferedBank;
  String? existinRelaionshipWithBank;
  String? branch;
  String? productType;
  String? loanApplicationNo;
  int? pickedUpEmployeeId;
  String? connectorName;
  String? connectorMobileNo;
  num? connectorPercentage;
  String? existingLoans;
  int? noOfExistingLoans;
 // bool? moveToCommon;
  String? pickedUpEmployeeName;
  String? assignedEmployeeName;
  String? bankName;
  String? branchName;
  String? segmentName;
  num? assignedEmployeePercentage;
  int? camNoteCount;
  int? loanDetail;
  int? disburseDetail;
  String? reminderDate;
  String? lastUpdatedDate;

  Data({
    this.id,
    this.name,
    this.mobileNumber,
    this.email,
    this.pincode,
    this.source,
    this.stageName,
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
    this.existinRelaionshipWithBank,
    this.branch,
    this.productType,
    this.loanApplicationNo,
    this.pickedUpEmployeeId,
    this.connectorName,
    this.connectorMobileNo,
    this.connectorPercentage,
    this.existingLoans,
    this.noOfExistingLoans,
   // this.moveToCommon,
    this.pickedUpEmployeeName,
    this.assignedEmployeeName,
    this.bankName,
    this.branchName,
    this.segmentName,
    this.assignedEmployeePercentage,
    this.camNoteCount,
    this.loanDetail,
    this.disburseDetail,
  this.lastUpdatedDate,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    pincode = json['pincode'];
    source = json['source'];
    stageName = json['stageName'];
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

    // New fields
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
    existinRelaionshipWithBank = json['existinRelaionshipWithBank'];
    branch = json['branch'];
    productType = json['productType'];
    loanApplicationNo = json['loanApplicationNo'];
    pickedUpEmployeeId = json['pickedUpEmployeeId'];
    connectorName = json['connectorName'];
    connectorMobileNo = json['connectorMobileNo'];
    connectorPercentage = json['connectorPercentage'];
    existingLoans = json['existingLoans'];
    noOfExistingLoans = json['noOfExistingLoans'];
  //  moveToCommon = json['moveToCommon'];
    pickedUpEmployeeName = json['pickedUpEmployeeName'];
    assignedEmployeeName = json['assignedEmployeeName'];
    bankName = json['bankName'];
    branchName = json['branchName'];
    segmentName = json['segmentName'];
    assignedEmployeePercentage = json['assignedEmployeePercentage'];
    camNoteCount = json['camNoteCount'];
    loanDetail = json['loanDetail'];
    disburseDetail = json['disburseDetail'];
    reminderDate = json['reminderDate'];
    lastUpdatedDate = json['lastUpdatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobileNumber'] = mobileNumber;
    data['email'] = email;
    data['pincode'] = pincode;
    data['source'] = source;
    data['stageName'] = stageName;
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

    // New fields
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    data['loanAmountRequested'] = loanAmountRequested;
    data['adharCard'] = adharCard;
    data['panCard'] = panCard;
    data['streetAddress'] = streetAddress;
    data['state'] = state;
    data['district'] = district;
    data['city'] = city;
    data['stateName'] = stateName;
    data['districtName'] = districtName;
    data['cityName'] = cityName;
    data['nationality'] = nationality;
    data['currentEmploymentStatus'] = currentEmploymentStatus;
    data['employerName'] = employerName;
    data['monthlyIncome'] = monthlyIncome;
    data['additionalSourceOfIncome'] = additionalSourceOfIncome;
    data['prefferedBank'] = prefferedBank;
    data['existinRelaionshipWithBank'] = existinRelaionshipWithBank;
    data['branch'] = branch;
    data['productType'] = productType;
    data['loanApplicationNo'] = loanApplicationNo;
    data['pickedUpEmployeeId'] = pickedUpEmployeeId;
    data['connectorName'] = connectorName;
    data['connectorMobileNo'] = connectorMobileNo;
    data['connectorPercentage'] = connectorPercentage;
    data['existingLoans'] = existingLoans;
    data['noOfExistingLoans'] = noOfExistingLoans;
  //  data['moveToCommon'] = moveToCommon;
    data['pickedUpEmployeeName'] = pickedUpEmployeeName;
    data['assignedEmployeeName'] = assignedEmployeeName;
    data['bankName'] = bankName;
    data['branchName'] = branchName;
    data['segmentName'] = segmentName;
    data['assignedEmployeePercentage'] = assignedEmployeePercentage;
    data['camNoteCount'] = camNoteCount;
    data['loanDetail'] = loanDetail;
    data['disburseDetail'] = disburseDetail;
    data['reminderDate'] = this.reminderDate;
    data['lastUpdatedDate'] = this.lastUpdatedDate;
    return data;
  }
}

