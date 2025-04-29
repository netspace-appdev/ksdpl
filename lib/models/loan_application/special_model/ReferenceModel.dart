class ReferenceModel {
  final String name;
  final String address;
  final String city;
  final String district;
  final String state;
  final String country;
  final String pinCode;
  final String phone;
  final String mobile;
  final String relationWithApplicant;

  ReferenceModel({
    required this.name,
    required this.address,
    required this.city,
    required this.district,
    required this.state,
    required this.country,
    required this.pinCode,
    required this.phone,
    required this.mobile,
    required this.relationWithApplicant,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "address": address,
      "city": city,
      "district": district,
      "state": state,
      "country": country,
      "pinCode": pinCode,
      "phone": phone,
      "mobile": mobile,
      "relationWithApplicant": relationWithApplicant,
    };
  }
}
