import 'dart:math';

import '../../models/camnote/GenerateCibilAadharModel.dart';

class CibilCalculatedValues {
  final int totalLoanAvailedOnCibil;
  final int totalLiveLoan;
  final double totalEMI;
  final int emiWillContinue;
  final int totalOverdueCasesAsPerCibil;
  final int totalOverdueAmountAsPerCibil;
  final int totalEnquiriesMadeAsPerCibil;

  CibilCalculatedValues({
    required this.totalLoanAvailedOnCibil,
    required this.totalLiveLoan,
    required this.totalEMI,
    required this.emiWillContinue,
    required this.totalOverdueCasesAsPerCibil,
    required this.totalOverdueAmountAsPerCibil,
    required this.totalEnquiriesMadeAsPerCibil,
  });
}

CibilCalculatedValues calculateCibilData(
    CreditReportInnerData data, {
      double annualInterestRate = 14.0,
      int tenureMonths = 36,
    }) {
  final addressList = data
      .creditReport
      .ccrResponse
      .cirReportDataLst
      .first
      .cirReportData
      .retailAccountDetails;

  int totalLoanAvailed = 0;
  int totalLiveLoan = 0;
  double totalEMI = 0.0;
  int emiWillContinue = 0;
  int totalOverdueCases = 0;
  int totalOverdueAmount = 0;

  for (var account in addressList) {
    // TotalLoanAvailedOnCibil
    totalLoanAvailed += int.tryParse(account.sanctionAmount) ?? 0;

    // TotalLiveLoan
    if (account.open == "Yes") totalLiveLoan++;

    // TotalEMI
    if (account.open == "Yes" && account.sanctionAmount.isNotEmpty) {
      double principal = double.tryParse(account.sanctionAmount) ?? 0.0;
      double emi = calculateEMI(principal, annualInterestRate, tenureMonths);
      totalEMI += emi;
    }

    // EMIWillContinue
    if (account.open == "Yes" &&
        (account.dateClosed == null || account.dateClosed.isEmpty)) {
      emiWillContinue++;
    }

    // TotalOverdueCasesAsPerCibil
    bool hasOverdueAmount = (double.tryParse(account.pastDueAmount) ?? 0) > 0;
    bool hasOverdueHistory = account.history48Months.any(
          (entry) => ["30+", "60+", "90+", "120+", "SUB", "SPM"]
          .contains(entry.paymentStatus),
    );
    if (hasOverdueAmount || hasOverdueHistory) totalOverdueCases++;

    // TotalOverdueAmountAsPerCibil
    int overdue = int.tryParse(account.pastDueAmount) ?? 0;
    if (overdue > 0) totalOverdueAmount += overdue;
  }

  int totalEnquiries = data.creditReport.ccrResponse.cirReportDataLst.length;

  return CibilCalculatedValues(
    totalLoanAvailedOnCibil: totalLoanAvailed,
    totalLiveLoan: totalLiveLoan,
    totalEMI: totalEMI,
    emiWillContinue: emiWillContinue,
    totalOverdueCasesAsPerCibil: totalOverdueCases,
    totalOverdueAmountAsPerCibil: totalOverdueAmount,
    totalEnquiriesMadeAsPerCibil: totalEnquiries,
  );
}

double calculateEMI(double principal, double annualInterestRate, int months) {
  final r = (annualInterestRate / 12) / 100;
  final emi = principal * r * pow(1 + r, months) / (pow(1 + r, months) - 1);
  return emi.isFinite ? emi : 0.0;
}
