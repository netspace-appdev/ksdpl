/*
class AddIncModel {
  String? source;
  String? income;

  AddIncModel({
    this.source,
    this.income,
  });

  factory AddIncModel.fromJson(Map<String, dynamic> json) {
    return AddIncModel(
      source: json['source'],
      income: json['income'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (source != null && source!.isNotEmpty) 'source': source,
      'income': income,
    };
  }
}
*/

class AddIncModel {
  String? uniqueLeadNumber;
  String? description;
  int? amount;

  AddIncModel({
    this.uniqueLeadNumber,
    this.description,
    this.amount,
  });

  factory AddIncModel.fromJson(Map<String, dynamic> json) {
    return AddIncModel(
      uniqueLeadNumber: json['uniqueLeadNumber'],
      description: json['description'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (uniqueLeadNumber != null) 'uniqueLeadNumber': uniqueLeadNumber,
      if (description != null) 'description': description,
      if (amount != null) 'amount': amount,
    };
  }
}
