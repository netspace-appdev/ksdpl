class GetCompanyProfileModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  GetCompanyProfileModel({this.status, this.success, this.data, this.message});

  GetCompanyProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? companyName;
  String? founderName;
  String? ceoname;
  String? tagline;
  String? logo;
  String? foundingDate;
  String? headquartersLocation;
  String? email;
  String? phoneNo;
  String? whatsAppNo;
  String? fax;
  String? websiteUrl;
  String? linkedIn;
  String? facebook;
  String? twitter;
  String? industryAwards;
  String? isocertifications;
  String? collectionsIndustryCertifications;
  String? companyAddress;
  String? mapIntegration;
  String? privacyPolicy;
  String? termsAndConditions;
  String? disclaimers;
  String? companyRegistrationNo;
  String? gstnumber;
  String? pannumber;
  String? cinnumber;
  String? createdDate;
  String? createdBy;
  String? updateDate;
  String? updatedBy;

  Data(
      {this.id,
        this.companyName,
        this.founderName,
        this.ceoname,
        this.tagline,
        this.logo,
        this.foundingDate,
        this.headquartersLocation,
        this.email,
        this.phoneNo,
        this.whatsAppNo,
        this.fax,
        this.websiteUrl,
        this.linkedIn,
        this.facebook,
        this.twitter,
        this.industryAwards,
        this.isocertifications,
        this.collectionsIndustryCertifications,
        this.companyAddress,
        this.mapIntegration,
        this.privacyPolicy,
        this.termsAndConditions,
        this.disclaimers,
        this.companyRegistrationNo,
        this.gstnumber,
        this.pannumber,
        this.cinnumber,
        this.createdDate,
        this.createdBy,
        this.updateDate,
        this.updatedBy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    founderName = json['founderName'];
    ceoname = json['ceoname'];
    tagline = json['tagline'];
    logo = json['logo'];
    foundingDate = json['foundingDate'];
    headquartersLocation = json['headquartersLocation'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    whatsAppNo = json['whatsAppNo'];
    fax = json['fax'];
    websiteUrl = json['websiteUrl'];
    linkedIn = json['linkedIn'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    industryAwards = json['industryAwards'];
    isocertifications = json['isocertifications'];
    collectionsIndustryCertifications =
    json['collectionsIndustryCertifications'];
    companyAddress = json['companyAddress'];
    mapIntegration = json['mapIntegration'];
    privacyPolicy = json['privacyPolicy'];
    termsAndConditions = json['termsAndConditions'];
    disclaimers = json['disclaimers'];
    companyRegistrationNo = json['companyRegistrationNo'];
    gstnumber = json['gstnumber'];
    pannumber = json['pannumber'];
    cinnumber = json['cinnumber'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    updateDate = json['updateDate'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyName'] = this.companyName;
    data['founderName'] = this.founderName;
    data['ceoname'] = this.ceoname;
    data['tagline'] = this.tagline;
    data['logo'] = this.logo;
    data['foundingDate'] = this.foundingDate;
    data['headquartersLocation'] = this.headquartersLocation;
    data['email'] = this.email;
    data['phoneNo'] = this.phoneNo;
    data['whatsAppNo'] = this.whatsAppNo;
    data['fax'] = this.fax;
    data['websiteUrl'] = this.websiteUrl;
    data['linkedIn'] = this.linkedIn;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['industryAwards'] = this.industryAwards;
    data['isocertifications'] = this.isocertifications;
    data['collectionsIndustryCertifications'] =
        this.collectionsIndustryCertifications;
    data['companyAddress'] = this.companyAddress;
    data['mapIntegration'] = this.mapIntegration;
    data['privacyPolicy'] = this.privacyPolicy;
    data['termsAndConditions'] = this.termsAndConditions;
    data['disclaimers'] = this.disclaimers;
    data['companyRegistrationNo'] = this.companyRegistrationNo;
    data['gstnumber'] = this.gstnumber;
    data['pannumber'] = this.pannumber;
    data['cinnumber'] = this.cinnumber;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['updateDate'] = this.updateDate;
    data['updatedBy'] = this.updatedBy;
    return data;
  }
}
