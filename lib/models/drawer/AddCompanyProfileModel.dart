class AddCompanyProfileModel {
  String? status;
  bool? success;
  List<Data>? data;
  String? message;

  AddCompanyProfileModel({this.status, this.success, this.data, this.message});

  AddCompanyProfileModel.fromJson(Map<String, dynamic> json) {
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
    id = json['Id'];
    companyName = json['CompanyName'];
    founderName = json['FounderName'];
    ceoname = json['Ceoname'];
    tagline = json['Tagline'];
    logo = json['Logo'];
    foundingDate = json['FoundingDate'];
    headquartersLocation = json['HeadquartersLocation'];
    email = json['Email'];
    phoneNo = json['PhoneNo'];
    whatsAppNo = json['WhatsAppNo'];
    fax = json['Fax'];
    websiteUrl = json['WebsiteUrl'];
    linkedIn = json['LinkedIn'];
    facebook = json['Facebook'];
    twitter = json['Twitter'];
    industryAwards = json['IndustryAwards'];
    isocertifications = json['Isocertifications'];
    collectionsIndustryCertifications =
    json['CollectionsIndustryCertifications'];
    companyAddress = json['CompanyAddress'];
    mapIntegration = json['MapIntegration'];
    privacyPolicy = json['PrivacyPolicy'];
    termsAndConditions = json['TermsAndConditions'];
    disclaimers = json['Disclaimers'];
    companyRegistrationNo = json['CompanyRegistrationNo'];
    gstnumber = json['Gstnumber'];
    pannumber = json['Pannumber'];
    cinnumber = json['Cinnumber'];
    createdDate = json['CreatedDate'];
    createdBy = json['CreatedBy'];
    updateDate = json['UpdateDate'];
    updatedBy = json['UpdatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['CompanyName'] = this.companyName;
    data['FounderName'] = this.founderName;
    data['Ceoname'] = this.ceoname;
    data['Tagline'] = this.tagline;
    data['Logo'] = this.logo;
    data['FoundingDate'] = this.foundingDate;
    data['HeadquartersLocation'] = this.headquartersLocation;
    data['Email'] = this.email;
    data['PhoneNo'] = this.phoneNo;
    data['WhatsAppNo'] = this.whatsAppNo;
    data['Fax'] = this.fax;
    data['WebsiteUrl'] = this.websiteUrl;
    data['LinkedIn'] = this.linkedIn;
    data['Facebook'] = this.facebook;
    data['Twitter'] = this.twitter;
    data['IndustryAwards'] = this.industryAwards;
    data['Isocertifications'] = this.isocertifications;
    data['CollectionsIndustryCertifications'] =
        this.collectionsIndustryCertifications;
    data['CompanyAddress'] = this.companyAddress;
    data['MapIntegration'] = this.mapIntegration;
    data['PrivacyPolicy'] = this.privacyPolicy;
    data['TermsAndConditions'] = this.termsAndConditions;
    data['Disclaimers'] = this.disclaimers;
    data['CompanyRegistrationNo'] = this.companyRegistrationNo;
    data['Gstnumber'] = this.gstnumber;
    data['Pannumber'] = this.pannumber;
    data['Cinnumber'] = this.cinnumber;
    data['CreatedDate'] = this.createdDate;
    data['CreatedBy'] = this.createdBy;
    data['UpdateDate'] = this.updateDate;
    data['UpdatedBy'] = this.updatedBy;
    return data;
  }
}
