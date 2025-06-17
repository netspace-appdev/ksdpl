class IncomeModel {
  final String uniqueLeadNumber;
  final String description;
  final double amount;

  IncomeModel({
    required this.uniqueLeadNumber,
    required this.description,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      "uniqueLeadNumber": uniqueLeadNumber,
      "description": description,
      "amount": amount,
    };
  }

  factory IncomeModel.fromMap(Map<String, dynamic> map) {
    return IncomeModel(
      uniqueLeadNumber: map['uniqueLeadNumber'] ?? '',
      description: map['description'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
    );
  }
}
