class GetAllInsuranceIllustrationsModel {
  String? status;
  bool? success;
  List<IllustationData>? data;
  String? message;

  GetAllInsuranceIllustrationsModel(
      {this.status, this.success, this.data, this.message});

  GetAllInsuranceIllustrationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <IllustationData>[];
      json['data'].forEach((v) {
        data!.add(new IllustationData.fromJson(v));
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

class IllustationData {
  int? id;
  String? policyHolderName;
  String? age;
  String? gender;
  String? policyTerm;
  String? premiumPaymentTerm;
  num? amntOfInstallmentPremium;
  String? premiumPaymentMode;
  String? proposalNo;
  String? nameOfTheProduct;
  String? tagLine;
  String? uniqueIdentificationNo;
  num? gstrate;
  String? maxLifeState;
  String? policyHolderResidentialState;
  num? sumAssured;
  num? sumAssuredOnDeath;
  num? basePlanWithGst;
  num? basePlanWithoutGst;
  num? riderWithGst;
  num? riderWithoutGst;
  num? totalInstallmentPremium;
  String? uniqueLeadNumber;

  IllustationData({
    this.id,
    this.policyHolderName,
    this.age,
    this.gender,
    this.policyTerm,
    this.premiumPaymentTerm,
    this.amntOfInstallmentPremium,
    this.premiumPaymentMode,
    this.proposalNo,
    this.nameOfTheProduct,
    this.tagLine,
    this.uniqueIdentificationNo,
    this.gstrate,
    this.maxLifeState,
    this.policyHolderResidentialState,
    this.sumAssured,
    this.sumAssuredOnDeath,
    this.basePlanWithGst,
    this.basePlanWithoutGst,
    this.riderWithGst,
    this.riderWithoutGst,
    this.totalInstallmentPremium,
    this.uniqueLeadNumber,
  });

  IllustationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    policyHolderName = json['policyHolderName'];
    age = json['age'];
    gender = json['gender'];
    policyTerm = json['policyTerm'];
    premiumPaymentTerm = json['premiumPaymentTerm'];
    amntOfInstallmentPremium = json['amntOfInstallmentPremium'];
    premiumPaymentMode = json['premiumPaymentMode'];
    proposalNo = json['proposalNo'];
    nameOfTheProduct = json['nameOfTheProduct'];
    tagLine = json['tagLine'];
    uniqueIdentificationNo = json['uniqueIdentificationNo'];
    gstrate = json['gstrate'];
    maxLifeState = json['maxLifeState'];
    policyHolderResidentialState = json['policyHolderResidentialState'];
    sumAssured = json['sumAssured'];
    sumAssuredOnDeath = json['sumAssuredOnDeath'];
    basePlanWithGst = json['basePlanWithGst'];
    basePlanWithoutGst = json['basePlanWithoutGst'];
    riderWithGst = json['riderWithGst'];
    riderWithoutGst = json['riderWithoutGst'];
    totalInstallmentPremium = json['totalInstallmentPremium'];
    uniqueLeadNumber = json['uniqueLeadNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['policyHolderName'] = policyHolderName;
    data['age'] = age;
    data['gender'] = gender;
    data['policyTerm'] = policyTerm;
    data['premiumPaymentTerm'] = premiumPaymentTerm;
    data['amntOfInstallmentPremium'] = amntOfInstallmentPremium;
    data['premiumPaymentMode'] = premiumPaymentMode;
    data['proposalNo'] = proposalNo;
    data['nameOfTheProduct'] = nameOfTheProduct;
    data['tagLine'] = tagLine;
    data['uniqueIdentificationNo'] = uniqueIdentificationNo;
    data['gstrate'] = gstrate;
    data['maxLifeState'] = maxLifeState;
    data['policyHolderResidentialState'] = policyHolderResidentialState;
    data['sumAssured'] = sumAssured;
    data['sumAssuredOnDeath'] = sumAssuredOnDeath;
    data['basePlanWithGst'] = basePlanWithGst;
    data['basePlanWithoutGst'] = basePlanWithoutGst;
    data['riderWithGst'] = riderWithGst;
    data['riderWithoutGst'] = riderWithoutGst;
    data['totalInstallmentPremium'] = totalInstallmentPremium;
    data['uniqueLeadNumber'] = uniqueLeadNumber;
    return data;
  }
}

