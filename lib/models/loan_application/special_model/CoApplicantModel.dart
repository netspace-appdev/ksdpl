class CoApplicantModel {
  final String name;
  final String fatherName;
  final String gender;
  final String? dateOfBirth;
  final String qualification;
  final String maritalStatus;
  final String status;
  final String nationality;
  final String occupation;
  final String occupationSector;
  final AddressModel presentAddress;
  final AddressModel permanentAddress;
  final AddressModel officeAddress;
  final String emailID;
  final String mobile;
  final EmployerDetailsModel employerDetails;

  CoApplicantModel({
    required this.name,
    required this.fatherName,
    required this.gender,
    required this.dateOfBirth,
    required this.qualification,
    required this.maritalStatus,
    required this.status,
    required this.nationality,
    required this.occupation,
    required this.occupationSector,
    required this.presentAddress,
    required this.permanentAddress,
    required this.officeAddress,
    required this.emailID,
    required this.mobile,
    required this.employerDetails,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "fatherName": fatherName,
      "gender": gender,
    if (dateOfBirth != null && dateOfBirth!.isNotEmpty)  "dateOfBirth": dateOfBirth,
      "qualification": qualification,
      "maritalStatus": maritalStatus,
      "status": status,
      "nationality": nationality,
      "occupation": occupation,
      "occupationSector": occupationSector,
      "presentAddress": presentAddress.toMap(),
      "permanentAddress": permanentAddress.toMap(),
      "officeAddress": officeAddress.toMap(),
      "emailID": emailID,
      "mobile": mobile,
      "employerDetails": employerDetails.toMap(),
    };
  }
}

class AddressModel {
  final String houseFlatNo;
  final String buildingNo;
  final String societyName;
  final String locality;
  final String streetName;
  final String city;
  final String taluka;
  final String district;
  final String state;
  final String country;
  final String pinCode;

  AddressModel({
    required this.houseFlatNo,
    required this.buildingNo,
    required this.societyName,
    required this.locality,
    required this.streetName,
    required this.city,
    required this.taluka,
    required this.district,
    required this.state,
    required this.country,
    required this.pinCode,
  });

  Map<String, dynamic> toMap() {
    return {
      "houseFlatNo": houseFlatNo,
      "buildingNo": buildingNo,
      "societyName": societyName,
      "locality": locality,
      "streetName": streetName,
      "city": city,
      "taluka": taluka,
      "district": district,
      "state": state,
      "country": country,
      "pinCode": pinCode,
    };
  }
}

class EmployerDetailsModel {
  final String organizationName;
  final String ownershipType;
  final String natureOfBusiness;
  final int staffStrength;
  final String? dateOfSalary;

  EmployerDetailsModel({
    required this.organizationName,
    required this.ownershipType,
    required this.natureOfBusiness,
    required this.staffStrength,
    required this.dateOfSalary,
  });

  Map<String, dynamic> toMap() {
    return {
      "organizationName": organizationName,
      "ownershipType": ownershipType,
      "natureOfBusiness": natureOfBusiness,
      "staffStrength": staffStrength,
      if (dateOfSalary != null && dateOfSalary!.isNotEmpty)  "dateOfSalary": dateOfSalary,

    };
  }
}
