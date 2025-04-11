class GetAllKsdplBranchModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetAllKsdplBranchModel({this.status, this.success, this.data, this.message});

  GetAllKsdplBranchModel.fromJson(Map<String, dynamic> json) {
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
  String? branchName;
  String? branchCodeRegistrationNo;
  num? locationInchargeNameId;
  String? branchEmail;
  String? branchContactNo;
  String? branchWhatsappNo;
  bool? active;
  String? branchAddress;
  String? branchGeoLocation;
  num? pincode;
  num? stateId;
  num? districtId;
  num? cityId;
  num? branchType;
  String? venueType;
  num? areaInSquarMeter;
  String? propertyDocument;
  String? openingDate;
  num? monthlyRentAmount;
  num? electricityExpenses;
  num? internetExpenses;
  num? officeAccommodationCosts;
  num? waterBillExpenses;
  num? maintenanceExpenses;
  num? miscellaneousExpensesCosts;
  num? numberOfEmployees;
  String? branchWorkingHours;
  String? createdDate;
  String? createdBy;
  String? updatedDate;
  String? updatedBy;
  Null? deletedDate;
  Null? deletedBy;
  String? stateName;
  String? districtName;
  String? cityName;
  String? locationInchargeName;

  Data(
      {this.id,
        this.branchName,
        this.branchCodeRegistrationNo,
        this.locationInchargeNameId,
        this.branchEmail,
        this.branchContactNo,
        this.branchWhatsappNo,
        this.active,
        this.branchAddress,
        this.branchGeoLocation,
        this.pincode,
        this.stateId,
        this.districtId,
        this.cityId,
        this.branchType,
        this.venueType,
        this.areaInSquarMeter,
        this.propertyDocument,
        this.openingDate,
        this.monthlyRentAmount,
        this.electricityExpenses,
        this.internetExpenses,
        this.officeAccommodationCosts,
        this.waterBillExpenses,
        this.maintenanceExpenses,
        this.miscellaneousExpensesCosts,
        this.numberOfEmployees,
        this.branchWorkingHours,
        this.createdDate,
        this.createdBy,
        this.updatedDate,
        this.updatedBy,
        this.deletedDate,
        this.deletedBy,
        this.stateName,
        this.districtName,
        this.cityName,
        this.locationInchargeName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchName = json['branchName'];
    branchCodeRegistrationNo = json['branchCodeRegistrationNo'];
    locationInchargeNameId = json['locationInchargeNameId'];
    branchEmail = json['branchEmail'];
    branchContactNo = json['branchContactNo'];
    branchWhatsappNo = json['branchWhatsappNo'];
    active = json['active'];
    branchAddress = json['branchAddress'];
    branchGeoLocation = json['branchGeoLocation'];
    pincode = json['pincode'];
    stateId = json['stateId'];
    districtId = json['districtId'];
    cityId = json['cityId'];
    branchType = json['branchType'];
    venueType = json['venueType'];
    areaInSquarMeter = json['areaInSquarMeter'];
    propertyDocument = json['propertyDocument'];
    openingDate = json['opening_Date'];
    monthlyRentAmount = json['monthly_Rent_Amount'];
    electricityExpenses = json['electricity_Expenses'];
    internetExpenses = json['internet_Expenses'];
    officeAccommodationCosts = json['office_Accommodation_Costs'];
    waterBillExpenses = json['water_Bill_Expenses'];
    maintenanceExpenses = json['maintenance_Expenses'];
    miscellaneousExpensesCosts = json['miscellaneous_ExpensesCosts'];
    numberOfEmployees = json['number_of_Employees'];
    branchWorkingHours = json['branch_Working_Hours'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    updatedDate = json['updatedDate'];
    updatedBy = json['updatedBy'];
    deletedDate = json['deletedDate'];
    deletedBy = json['deletedBy'];
    stateName = json['stateName'];
    districtName = json['districtName'];
    cityName = json['cityName'];
    locationInchargeName = json['locationInchargeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branchName'] = this.branchName;
    data['branchCodeRegistrationNo'] = this.branchCodeRegistrationNo;
    data['locationInchargeNameId'] = this.locationInchargeNameId;
    data['branchEmail'] = this.branchEmail;
    data['branchContactNo'] = this.branchContactNo;
    data['branchWhatsappNo'] = this.branchWhatsappNo;
    data['active'] = this.active;
    data['branchAddress'] = this.branchAddress;
    data['branchGeoLocation'] = this.branchGeoLocation;
    data['pincode'] = this.pincode;
    data['stateId'] = this.stateId;
    data['districtId'] = this.districtId;
    data['cityId'] = this.cityId;
    data['branchType'] = this.branchType;
    data['venueType'] = this.venueType;
    data['areaInSquarMeter'] = this.areaInSquarMeter;
    data['propertyDocument'] = this.propertyDocument;
    data['opening_Date'] = this.openingDate;
    data['monthly_Rent_Amount'] = this.monthlyRentAmount;
    data['electricity_Expenses'] = this.electricityExpenses;
    data['internet_Expenses'] = this.internetExpenses;
    data['office_Accommodation_Costs'] = this.officeAccommodationCosts;
    data['water_Bill_Expenses'] = this.waterBillExpenses;
    data['maintenance_Expenses'] = this.maintenanceExpenses;
    data['miscellaneous_ExpensesCosts'] = this.miscellaneousExpensesCosts;
    data['number_of_Employees'] = this.numberOfEmployees;
    data['branch_Working_Hours'] = this.branchWorkingHours;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['updatedDate'] = this.updatedDate;
    data['updatedBy'] = this.updatedBy;
    data['deletedDate'] = this.deletedDate;
    data['deletedBy'] = this.deletedBy;
    data['stateName'] = this.stateName;
    data['districtName'] = this.districtName;
    data['cityName'] = this.cityName;
    data['locationInchargeName'] = this.locationInchargeName;
    return data;
  }
}
