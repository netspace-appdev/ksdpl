import 'dart:math';

import '../../models/camnote/GenerateCibilAadharModel.dart';


///old working code

/*class CibilCalculatedValues {
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

  //int totalEnquiries = data.creditReport.ccrResponse.cirReportDataLst.length;

  if (data.creditReport?.ccrResponse?.cirReportDataLst != null) {
    for (var i = 0; i < data.creditReport!.ccrResponse!.cirReportDataLst!.length; i++) {
      final item = data.creditReport!.ccrResponse!.cirReportDataLst![i];

      print("Index $i -> cirReportData: ${item?.cirReportData}");
    }
  }

  int totalEnquiries = data.creditReport?.ccrResponse?.cirReportDataLst
      ?.where((item) => item?.cirReportData != null)
      .length ?? 0;
  print("totalEnquiries --->: ${totalEnquiries.toString()}");
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
}*/

import 'dart:math';

class CibilCalculatedValues {
  final int cibil;
  final double totalLoanAvailedOnCibil;
  final int totalLiveLoan;
  final double totalEMI;
  final int totalOverdueCasesAsPerCibil;
  final double totalOverdueAmountAsPerCibil;
  final int totalEnquiriesMadeAsPerCibil;

  final int closedCases;
  final int writtenOffCases;
  final int settlementCases;
  final int suitFiledWillfulDefaultCases;
  final double totalSanctionedAmount;
  final double currentBalance;
  final int totalCounts;
  final int currentlyCasesBeingServed;
  final int standardCount;
  final int substandardCount;
  final int doubtfulCount;
  final int lossCount;
  final int specialMentionAccountCount;

  // Placeholder fields (not available in JSON)
  final double closedAmount;
  final double writtenOffAmount;
  final double settlementAmount;
  final double suitFiledWillfulDefaultAmount;
  final int numberOfDaysPastDueCount;
  final int npt;
  final int casesToBeForeclosedOnOrBeforeDisb;
  final int casesToBeContinued;
  final double emisOfExistingLiabilities;
  final double iir;

  CibilCalculatedValues({
    required this.cibil,
    required this.totalLoanAvailedOnCibil,
    required this.totalLiveLoan,
    required this.totalEMI,
    required this.totalOverdueCasesAsPerCibil,
    required this.totalOverdueAmountAsPerCibil,
    required this.totalEnquiriesMadeAsPerCibil,
    required this.closedCases,
    required this.writtenOffCases,
    required this.settlementCases,
    required this.suitFiledWillfulDefaultCases,
    required this.totalSanctionedAmount,
    required this.currentBalance,
    required this.totalCounts,
    required this.currentlyCasesBeingServed,
    required this.standardCount,
    required this.substandardCount,
    required this.doubtfulCount,
    required this.lossCount,
    required this.specialMentionAccountCount,
    required this.closedAmount,
    required this.writtenOffAmount,
    required this.settlementAmount,
    required this.suitFiledWillfulDefaultAmount,
    required this.numberOfDaysPastDueCount,
    required this.npt,
    required this.casesToBeForeclosedOnOrBeforeDisb,
    required this.casesToBeContinued,
    required this.emisOfExistingLiabilities,
    required this.iir,
  });
}

CibilCalculatedValues calculateCibilData(
    CreditReportInnerData data, {
      double annualInterestRate = 14.0,
      int tenureMonths = 36,
    }) {
  final addressList = data.creditReport?.ccrResponse?.cirReportDataLst
      ?.first.cirReportData?.retailAccountDetails ??
      [];

  double totalLoanAvailed = 0;
  int totalLiveLoan = 0;
  double totalEMI = 0;
  int totalOverdueCases = 0;
  double totalOverdueAmount = 0;

  int closedCases = 0;
  int writtenOffCases = 0;
  int settlementCases = 0;
  int suitFiledWillfulDefaultCases = 0;
  double totalSanctionedAmount = 0;
  double currentBalance = 0;
  int currentlyCasesBeingServed = 0;
  int standardCount = 0;
  int substandardCount = 0;
  int doubtfulCount = 0;
  int lossCount = 0;
  int specialMentionAccountCount = 0;

  for (var account in addressList) {
    double sanctionAmount = double.tryParse(account.sanctionAmount ?? '0') ?? 0;
    double pastDueAmount = double.tryParse(account.pastDueAmount ?? '0') ?? 0;
    double balance = double.tryParse(account.balance ?? '0') ?? 0;

    // 🏦 Total Loan Availed
    totalLoanAvailed += sanctionAmount;

    // 💰 Live Loan Count
    if (account.open == "Yes") totalLiveLoan++;

    // 💸 Total EMI (for open accounts)
    if (account.open == "Yes" && sanctionAmount > 0) {
      totalEMI += calculateEMI(sanctionAmount, annualInterestRate, tenureMonths);
    }

    // ⚠️ Overdue Cases
    bool hasOverdueAmount = pastDueAmount > 0;
    bool hasOverdueHistory = account.history48Months?.any((entry) =>
        ["30+", "60+", "90+", "120+", "SUB", "SPM"]
            .contains(entry.paymentStatus)) ??
        false;

    if (hasOverdueAmount || hasOverdueHistory) totalOverdueCases++;

    // 💣 Overdue Amount
    if (pastDueAmount > 0) totalOverdueAmount += pastDueAmount;

    // 📁 Closed Cases
    if (account.accountStatus?.toLowerCase().contains("closed") ?? false) {
      closedCases++;
    }

    // 🧾 Written Off Cases
    if (account.accountStatus?.toLowerCase().contains("write-off") ?? false) {
      writtenOffCases++;
    }

    // ⚖️ Settlement Cases
    if (account.accountStatus?.toLowerCase().contains("settlement") ?? false) {
      settlementCases++;
    }
    //change on 6 Oct
    // ⚔️ Suit Filed / Willful Default
   /* if (account.suitFiledStatus == "Yes") {
      suitFiledWillfulDefaultCases++;
    }
*/
    // 💵 Total Sanctioned & Balance
    totalSanctionedAmount += sanctionAmount;
    currentBalance += balance;

    // 🔄 Currently Serving Cases
    if (account.open == "Yes") currentlyCasesBeingServed++;

    // 🏷️ Asset Classification counts
    switch (account.assetClassification) {
      case "STD":
        standardCount++;
        break;
      case "SUB":
        substandardCount++;
        break;
      case "DBT":
        doubtfulCount++;
        break;
      case "LOSS":
        lossCount++;
        break;
      case "SMA":
        specialMentionAccountCount++;
        break;
    }
  }

  // 🔍 Total Enquiries
  final totalEnquiries = data.creditReport?.ccrResponse?.cirReportDataLst
      ?.where((item) => item?.cirReportData != null)
      .length ??
      0;

  // 🧮 CIBIL Score
  final cibil = data.creditScore ?? 0.0;

  return CibilCalculatedValues(
    cibil:int.parse(cibil.toString()),//cibil,     //change on 6 Oct
    totalLoanAvailedOnCibil: totalLoanAvailed,
    totalLiveLoan: totalLiveLoan,
    totalEMI: double.parse(totalEMI.toStringAsFixed(2)),
    totalOverdueCasesAsPerCibil: totalOverdueCases,
    totalOverdueAmountAsPerCibil: totalOverdueAmount,
    totalEnquiriesMadeAsPerCibil: totalEnquiries,
    closedCases: closedCases,
    writtenOffCases: writtenOffCases,
    settlementCases: settlementCases,
    suitFiledWillfulDefaultCases: suitFiledWillfulDefaultCases,
    totalSanctionedAmount: totalSanctionedAmount,
    currentBalance: currentBalance,
    totalCounts: addressList.length,
    currentlyCasesBeingServed: currentlyCasesBeingServed,
    standardCount: standardCount,
    substandardCount: substandardCount,
    doubtfulCount: doubtfulCount,
    lossCount: lossCount,
    specialMentionAccountCount: specialMentionAccountCount,
    closedAmount: 0,
    writtenOffAmount: 0,
    settlementAmount: 0,
    suitFiledWillfulDefaultAmount: 0,
    numberOfDaysPastDueCount: 0,
    npt: 0,
    casesToBeForeclosedOnOrBeforeDisb: 0,
    casesToBeContinued: 0,
    emisOfExistingLiabilities: 0,
    iir: 0,
  );
}

double calculateEMI(double principal, double annualInterestRate, int months) {
  final r = (annualInterestRate / 12) / 100;
  final emi = principal * r * pow(1 + r, months) / (pow(1 + r, months) - 1);
  return emi.isFinite ? emi : 0.0;
}

