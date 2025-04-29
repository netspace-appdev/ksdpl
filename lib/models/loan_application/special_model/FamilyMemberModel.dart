class FamilyMemberModel {
  String? name;
  String? birthDate;
  String? gender;
  String? relationWithApplicant;
  bool? dependent;
  int? monthlyIncome;
  String? employedWith;

  FamilyMemberModel({
    this.name,
    this.birthDate,
    this.gender,
    this.relationWithApplicant,
    this.dependent,
    this.monthlyIncome,
    this.employedWith,
  });

  factory FamilyMemberModel.fromJson(Map<String, dynamic> json) {
    return FamilyMemberModel(
      name: json['name'],
      birthDate: json['birthDate'],
      gender: json['gender'],
      relationWithApplicant: json['relationWithApplicant'],
      dependent: json['dependent'],
      monthlyIncome: json['monthlyIncome'],
      employedWith: json['employedWith'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthDate': birthDate,
      'gender': gender,
      'relationWithApplicant': relationWithApplicant,
      'dependent': dependent,
      'monthlyIncome': monthlyIncome,
      'employedWith': employedWith,
    };
  }
}
