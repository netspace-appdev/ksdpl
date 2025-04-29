class CreditCardModel {
  final String companyBank;
  final String cardNumber;
  final String havingSince;
  final int avgMonthlySpending;

  CreditCardModel({
    required this.companyBank,
    required this.cardNumber,
    required this.havingSince,
    required this.avgMonthlySpending,
  });

  Map<String, dynamic> toMap() {
    return {
      "companyBank": companyBank,
      "cardNumber": cardNumber,
      "havingSince": havingSince,
      "avgMonthlySpending": avgMonthlySpending,
    };
  }
}
