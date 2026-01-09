import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ksdpl/common/get_header.dart';
import 'dart:convert';
import '../common/base_url.dart';
import 'package:http/http.dart' as http;

import '../common/helper.dart';

class CamNoteService {


  static const String getProductDetailsByFilter = BaseUrl.baseUrl + 'LeadDetail/GetProductDetailsByFilter';
  static const String addAdditionalSourceIncome = BaseUrl.baseUrl + 'CamNoteDetail/AddAdditionalSourceIncome';
  static const String getAllPackageMaster = BaseUrl.baseUrl + 'CamNoteDetail/GetAllPackageMaster';
  static const String updateBankerDetail = BaseUrl.baseUrl + 'CamNoteDetail/UpdateBankerDetail';
  static const String addBankerDetail = BaseUrl.baseUrl + 'CamNoteDetail/AddBankerDetail';
  static const String getBankerDetail = BaseUrl.baseUrl + 'CamNoteDetail/GetBankerDetail';
  static const String getAdditionalIncomeByUniqueLeadNumber = BaseUrl.baseUrl + 'CamNoteDetail/GetAdditionalIncomeByUniqueLeadNumber';
  static const String addCamNoteDetail = BaseUrl.baseUrl + 'CamNoteDetail/AddCamNoteDetail';
  static const String sendMailToBankerAfterGenerateCamNote = BaseUrl.baseUrl + 'CamNoteDetail/SendMailToBankerAfterGenerateCamNote';
  static const String generateCibilScoreByAadhar = BaseUrl.baseUrl + 'FileUpload/GenerateCibilScoreByAadhar';
  static const String generateCibilScoreByPAN = BaseUrl.baseUrl + 'FileUpload/GenerateCibilScoreByPAN';
  static const String addCibilDetails = BaseUrl.baseUrl + 'CamNoteDetail/AddCibilDetails';
  static const String getCamNoteDetailByLeadId = BaseUrl.baseUrl + 'CamNoteDetail/GetCamNoteDetailByLeadId';
  static const String getCamNoteDetailById = BaseUrl.baseUrl + 'CamNoteDetail/GetCamNoteDetailById';
  static const String editCamNoteDetail = BaseUrl.baseUrl + 'CamNoteDetail/EditCamNoteDetail';
  static const String getPackageDetailsById = BaseUrl.baseUrl + 'CamNoteDetail/GetPackageDetailsById';
  static const String fetchBankDetailBySegmentIdAndKSDPLProductId = BaseUrl.baseUrl + 'ProductList/FetchBankDetailBySegmentIdAndKSDPLProductId';
  static const String getProductDetailBySegmentAndProduct = BaseUrl.baseUrl + 'ProductList/GetProductDetailBySegmentAndProduct';
  static const String sendMailForLocationOfCustomer = BaseUrl.baseUrl + 'LeadDetail/SendMailForLocationOfCustomer';
  static const String requestForFinancialServices = BaseUrl.baseUrl + 'FileUpload/RequestForFinancialServices';
  static const String requestLeadDetailByCustomerNumber = BaseUrl.baseUrl + 'LeadDetail/GetLeadDetailByCustomerNumber';
  static const String getCamNoteDetailsByLeadIdForUpdate = BaseUrl.baseUrl + 'CamNoteDetail/GetCamNoteDetailsByLeadIdForUpdate';
  static const String addCustomerDetails = BaseUrl.baseUrl + 'Customer/AddCustomerDetails';
  static const String sendPaymentQRCodeOnWhatsAppToCustomer = BaseUrl.baseUrl + 'CamNoteDetail/SendPaymentQRCodeOnWhatsAppToCustomer';
  static const String checkReceiptStatusForCamNote = BaseUrl.baseUrl + 'CamNoteDetail/CheckReceiptStatusForCamNote';
  static const String saveCamnoteDetails = BaseUrl.baseUrl + 'CamNoteDetail/SaveCamnoteDetails';
  static const String getSalePackagesByLeadId = BaseUrl.baseUrl + 'CamNoteDetail/GetSalePackagesByLeadId';
  static const String UPIAPisGenerateQR = BaseUrl.baseUrl + 'UPIAPis/generate-qr';
  static const String sendBankerSelfUpdateLink = BaseUrl.baseUrl + 'CamNoteDetail/SendBankerSelfUpdateLink';
  static const String addCibilAccountSummary = BaseUrl.baseUrl + 'CamNoteDetail/AddCibilAccountSummary';
  static const String getCibilAccountSummaryByLeadId = BaseUrl.baseUrl + 'CamNoteDetail/GetCibilAccountSummaryByLeadId';






  static Future<Map<String, dynamic>> getProductDetailsByFilterApi({

    String? cibil,
    String? segmentVertical,
    String? customerCategory,
    String? collateralSecurityCategory,
    String? collateralSecurityExcluded,
    String? incomeTypes,
    String? ageEarningApplicants,
    String? ageNonEarningCoApplicant,
    String? applicantMonthlySalary,
    String? loanAmount,
    String? tenor,
    String? roi,
    String? maximumTenorEligibilityCriteria,
    String? customerAddress,

    String? totalOverdueCases,
    String? totalOverdueAmount,
    String? totalEnquiries,
    String? kSDPLProductId,

  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getProductDetailsByFilter),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'MinCibil', cibil,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'SegmentVertical', segmentVertical,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'CustomerCategory', customerCategory);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'CollateralSecurityCategory', collateralSecurityCategory);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'CollateralSecurityExcluded', collateralSecurityExcluded);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalOverdueCasesCibil',  totalOverdueCases,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalOverdueAmountCibil',  totalOverdueAmount,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalEnquiriesMadeCibil',  totalEnquiries,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'IncomeTypes', incomeTypes);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'AgeEarningApplicants', ageEarningApplicants,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'AgeNonEarningCoApplicant',  ageNonEarningCoApplicant,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'ApplicantMonthlySalary',  applicantMonthlySalary,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LoanAmount',  loanAmount,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Tenor',  tenor,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Roi',  roi,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'MaximumTenorEligibilityCriteria',  maximumTenorEligibilityCriteria,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'CustomerAddress', customerAddress);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'KSDPLProductId',  kSDPLProductId,fallback: "0");
      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(getProductDetailsByFilter, request.fields);
      Helper.ApiRes(getProductDetailsByFilter, response.body);




      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }


  static Future<Map<String, dynamic>> addAdditionalSourceIncomeApi({
    required List<Map<String, dynamic>> body,
  }) async {
    try {
      var headers = await MyHeader.getHeaders3(); // should return 'Authorization' and 'Content-Type: application/json'

      var response = await http.post(
        Uri.parse(addAdditionalSourceIncome),
        headers: headers,
        body: jsonEncode(body),
      );
     // const JsonEncoder encoder = JsonEncoder.withIndent('  ');



      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }


  static Future<Map<String, dynamic>> getAllPackageMasterApi() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllPackageMaster),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(getAllPackageMaster, request.fields);
      Helper.ApiRes(getAllPackageMaster, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }


  static Future<Map<String, dynamic>> updateBankerDetailApi({
    String? bankId,
    String? branchId,
    String? bankersName,
    String? bankersMobileNumber,
    String? bankersWhatsAppNumber,
    String? bankersEmailId,
    String? city,
    String? superiorName,
    String? superiorMobile,
    String? superiorWhatsApp,
    String? superiorEmail,
    String? createdBy,

  })
  async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(updateBankerDetail),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'BankId', bankId,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'BranchId', branchId,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'BankersName', bankersName);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'BankersMobileNumber', bankersMobileNumber);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'BankersWhatsAppNumber', bankersWhatsAppNumber);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'BankersEmailId', bankersEmailId);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'City', city,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'SuperiorName', superiorName);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'SuperiorMobile', superiorMobile);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'SuperiorWhatsApp', superiorWhatsApp);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'SuperiorEmail', superiorEmail);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'CreatedBy', createdBy,fallback: "0");

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }

  static Future<Map<String, dynamic>> addBankerDetailApi({
    String? bankId,
    String? branchId,
    String? bankersName,
    String? bankersMobileNumber,
    String? bankersWhatsAppNumber,
    String? bankersEmailId,
    String? city,
    String? superiorName,
    String? superiorMobile,
    String? superiorWhatsApp,
    String? superiorEmail,
    String? createdBy,

  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(addBankerDetail),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'BankId', bankId,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'BranchId', branchId,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'BankersName', bankersName);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'BankersMobileNumber', bankersMobileNumber);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'BankersWhatsAppNumber', bankersWhatsAppNumber);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'BankersEmailId', bankersEmailId);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'City', city,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'SuperiorName', superiorName);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'SuperiorMobile', superiorMobile);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'SuperiorWhatsApp', superiorWhatsApp);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'SuperiorEmail', superiorEmail);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'CreatedBy', createdBy,fallback: "0");

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }


  static Future<Map<String, dynamic>> getBankerDetaillApi({
    required String phoneNo,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getBankerDetail),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'PhoneNo', phoneNo);

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(getBankerDetail, request.fields);
      Helper.ApiRes(getBankerDetail, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }

  static Future<Map<String, dynamic>> getAddIncUniqueLeadApi({
    required String uniqueLeadNumber,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAdditionalIncomeByUniqueLeadNumber),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'UniqueLeadNumber', uniqueLeadNumber);

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);
      Helper.ApiReq(getAdditionalIncomeByUniqueLeadNumber, request.fields);
      Helper.ApiRes(getAdditionalIncomeByUniqueLeadNumber, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }


  static Future<Map<String, dynamic>> addCamNoteDetailApi({
     String? Id,
     String? LeadID,
     String? BankId,
     String? BankersName,
     String? BankersMobileNumber,
     String? BankersWhatsAppNumber,
     String? BankersEmailID,
     String? Cibil,
     String? TotalLoanAvailedOnCibil,
     String? TotalLiveLoan,
     String? TotalEMI,
     String? EMIStoppedOnBeforeThisLoan,
     String? EMIWillContinue,
     String? TotalOverdueCasesAsPerCibil,
    String? TotalOverdueAmountAsPerCibil,
    String? TotalEnquiriesMadeAsPerCibil,
    String? LoanSegment,
    String? LoanProduct,
    String? OfferedSecurityType,
    String? IncomeType,
    String? EarningCustomerAge,
    String? NonEarningCustomerAge,
    String? TotalFamilyIncome,
    String? IncomeCanBeConsidered,
    String? LoanAmountRequested,
    String? LoanTenorRequested,
    String? ROI,
    String? ProposedEMI,
    String? PropertyValueAsPerCustomer,
    String? FOIR,
    String? LTV,
    String? BranchOfBank,
    String? SanctionProcessingCharges,
    String? Autoindividual,

    ///Newly Added on 26 Sep
    String? ClosedCases,
    String? WrittenOffCases,
    String? SettlementCases,
    String? Suit_Filed_Willful_Default_Cases,
    String? TotalSanctionedAmount,
    String? CurrentBalance,
    String? ClosedAmount,
    String? WrittenOffAmount,
    String? SettlementAmount,
    String? Suit_Filed_Willful_Default_Amount,
    String? Standard_Count,
    String? Number_of_days_past_due_Count,
    String? Loss_Count,
    String? Substandard_Count,
    String? Doubtful_Count,
    String? Special_Mention_account_Count,
    String? NPT,
    String? TotalCounts,
    String? CurrentlyCasesBeingServed,
    String? CasesToBeForeclosedOnOrBeforeDisb,
    String? CasesToBeContenued,
    String? EMIsOfExistingLiabilities,
    String? IIR,
    String? CreatedBy,
    String? DSACode,
    String? DSAName,

  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(addCamNoteDetail),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Id', Id,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LeadID', LeadID,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'BankId', BankId,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'BankersName', BankersName);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'BankersMobileNumber', BankersMobileNumber);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'BankersWhatsAppNumber', BankersWhatsAppNumber);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'BankersEmailID', BankersEmailID);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Cibil', Cibil,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalLoanAvailedOnCibil', TotalLoanAvailedOnCibil,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalLiveLoan', TotalLiveLoan,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalEMI', TotalEMI,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'EMIStoppedOnBeforeThisLoan', EMIStoppedOnBeforeThisLoan,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'EMIWillContinue', EMIWillContinue,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalOverdueCasesAsPerCibil', TotalOverdueCasesAsPerCibil,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalOverdueAmountAsPerCibil', TotalOverdueAmountAsPerCibil,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalEnquiriesMadeAsPerCibil', TotalEnquiriesMadeAsPerCibil,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LoanSegment', LoanSegment,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LoanProduct', LoanProduct,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'OfferedSecurityType', OfferedSecurityType);

      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'IncomeType', IncomeType);

      MultipartFieldHelper.addFieldWithDefault(request.fields, 'EarningCustomerAge', EarningCustomerAge,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'NonEarningCustomerAge', NonEarningCustomerAge,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalFamilyIncome', TotalFamilyIncome,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'IncomeCanBeConsidered', IncomeCanBeConsidered,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LoanAmountRequested', LoanAmountRequested,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LoanTenorRequested', LoanTenorRequested,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'ROI', ROI,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'ProposedEMI', ProposedEMI,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'PropertyValueAsPerCustomer', PropertyValueAsPerCustomer,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'FOIR', FOIR,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LTV', LTV,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'BranchOfBank', BranchOfBank,fallback: "0");


      MultipartFieldHelper.addFieldWithDefault(request.fields, 'SanctionProcessingCharges', SanctionProcessingCharges,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Autoindividual', Autoindividual,fallback: "0");

      ///Newly Added on 26 Sep
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'ClosedCases', ClosedCases,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'WrittenOffCases', WrittenOffCases,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'SettlementCases', SettlementCases, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Suit_Filed_Willful_Default_Cases', Suit_Filed_Willful_Default_Cases, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalSanctionedAmount', TotalSanctionedAmount, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'CurrentBalance', CurrentBalance, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'ClosedAmount', ClosedAmount, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'WrittenOffAmount', WrittenOffAmount, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'SettlementAmount', SettlementAmount, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Suit_Filed_Willful_Default_Amount', Suit_Filed_Willful_Default_Amount, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Standard_Count', Standard_Count, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Number_of_days_past_due_Count', Number_of_days_past_due_Count, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Loss_Count', Loss_Count, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Substandard_Count', Substandard_Count, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Doubtful_Count', Doubtful_Count, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Special_Mention_account_Count', Special_Mention_account_Count, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'NPT', NPT, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalCounts', TotalCounts, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'CurrentlyCasesBeingServed', CurrentlyCasesBeingServed, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'CasesToBeForeclosedOnOrBeforeDisb', CasesToBeForeclosedOnOrBeforeDisb, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'CasesToBeContenued', CasesToBeContenued, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'EMIsOfExistingLiabilities', EMIsOfExistingLiabilities, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'IIR', IIR, fallback: "0");


      MultipartFieldHelper.addFieldWithDefault(request.fields, 'CreatedBy', CreatedBy, fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'DSACode', DSACode);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'DSAName', DSAName);

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);
      Helper.ApiReq(addCamNoteDetail, request.fields);
      Helper.ApiRes(addCamNoteDetail, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }



  static Future<Map<String, dynamic>> sendMailToBankerAfterGenerateCamNoteApi({
    required String id,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(sendMailToBankerAfterGenerateCamNote),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Id', id);

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }



  static Future<Map<String, dynamic>> generateCibilScoreByAadharApi({
    required String fullName,
    required String idNumber,
    required String mobile,
    required String gender,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(generateCibilScoreByAadhar),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'fullName', fullName);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'IdNumber', idNumber);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'mobile', mobile);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'gender', gender);

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }

  static Future<Map<String, dynamic>> generateCibilScoreByPANApi({
    required String fullName,
    required String pan,
    required String mobile,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(generateCibilScoreByPAN),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'fullName', fullName);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'pan', pan);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'mobile', mobile);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }



  static Future<Map<String, dynamic>> addCibilDetailsApi({
    required String phoneNo,
    required String aadhar,
    required String pan,
    required String uniqueLeadNo,
    required String paymentTransactionId,
    required String cibilTransactionId,
    required String pdf,
    required String date,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(addCibilDetails),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'PhoneNo', phoneNo);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Aadhar', aadhar);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Pan', pan);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'UniqueLeadNo', uniqueLeadNo);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'PaymentTransactionId', paymentTransactionId);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'CibilTransactionId', cibilTransactionId);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'PDF', pdf);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Date', date);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed : ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error: $e');
    }
  }



  static Future<Map<String, dynamic>> getCamNoteDetailByLeadIdApi({
    required String leadId,

  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getCamNoteDetailByLeadId),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'LeadId', leadId);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(getCamNoteDetailByLeadId, request.fields);
      Helper.ApiReq(getCamNoteDetailByLeadId,response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed : ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error: $e');
    }
  }


  static Future<Map<String, dynamic>> getCamNoteDetailByIdApi({
    required String id,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getCamNoteDetailById),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Id', id, fallback: "0");

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(getCamNoteDetailById, request.fields);
      Helper.ApiRes(getCamNoteDetailById, response.body);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed : ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error: $e');
    }
  }


  static Future<Map<String, dynamic>> editCamNoteDetailApi({
    required Id,
    String? LeadID,
    String? BankId,
    String? BankersName,
    String? BankersMobileNumber,
    String? BankersWhatsAppNumber,
    String? BankersEmailID,
    String? Cibil,
    String? TotalLoanAvailedOnCibil,
    String? TotalLiveLoan,
    String? TotalEMI,
    String? EMIStoppedOnBeforeThisLoan,
    String? EMIWillContinue,
    String? TotalOverdueCasesAsPerCibil,
    String? TotalOverdueAmountAsPerCibil,
    String? TotalEnquiriesMadeAsPerCibil,
    String? LoanSegment,
    String? LoanProduct,
    String? OfferedSecurityType,

    String? IncomeType,
    String? EarningCustomerAge,
    String? NonEarningCustomerAge,
    String? TotalFamilyIncome,
    String? IncomeCanBeConsidered,
    String? LoanAmountRequested,
    String? LoanTenorRequested,
    String? ROI,
    String? ProposedEMI,
    String? PropertyValueAsPerCustomer,
    String? FOIR,
    String? LTV,
    String? BranchOfBank,
    String? SanctionProcessingCharges,
    String? Autoindividual,

  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(editCamNoteDetail),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Id', Id,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LeadID', LeadID,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'BankId', BankId,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'BankersName', BankersName);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'BankersMobileNumber', BankersMobileNumber);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'BankersWhatsAppNumber', BankersWhatsAppNumber);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'BankersEmailID', BankersEmailID);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Cibil', Cibil,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalLoanAvailedOnCibil', TotalLoanAvailedOnCibil,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalLiveLoan', TotalLiveLoan,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalEMI', TotalEMI,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'EMIStoppedOnBeforeThisLoan', EMIStoppedOnBeforeThisLoan,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'EMIWillContinue', EMIWillContinue,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalOverdueCasesAsPerCibil', TotalOverdueCasesAsPerCibil,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalOverdueAmountAsPerCibil', TotalOverdueAmountAsPerCibil,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalEnquiriesMadeAsPerCibil', TotalEnquiriesMadeAsPerCibil,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LoanSegment', LoanSegment,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LoanProduct', LoanProduct,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'OfferedSecurityType', OfferedSecurityType);

      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'IncomeType', IncomeType);

      MultipartFieldHelper.addFieldWithDefault(request.fields, 'EarningCustomerAge', EarningCustomerAge,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'NonEarningCustomerAge', NonEarningCustomerAge,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalFamilyIncome', TotalFamilyIncome,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'IncomeCanBeConsidered', IncomeCanBeConsidered,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LoanAmountRequested', LoanAmountRequested,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LoanTenorRequested', LoanTenorRequested,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'ROI', ROI,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'ProposedEMI', ProposedEMI,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'PropertyValueAsPerCustomer', PropertyValueAsPerCustomer,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'FOIR', FOIR,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LTV', LTV,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'BranchOfBank', BranchOfBank,fallback: "0");

      MultipartFieldHelper.addFieldWithDefault(request.fields, 'SanctionProcessingCharges', SanctionProcessingCharges,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Autoindividual', Autoindividual,fallback: "0");


      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);


      Helper.ApiReq(editCamNoteDetail, request.fields);
      Helper.ApiReq(editCamNoteDetail, response.body);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }


  static Future<Map<String, dynamic>> getPackageDetailsByIdApi({
    required String packageId,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getPackageDetailsById),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      MultipartFieldHelper.addFieldWithDefault(request.fields, 'PackageId', packageId, fallback: "0");

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(getPackageDetailsById, request.fields);
      Helper.ApiRes(getPackageDetailsById, response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed : ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error: $e');
    }
  }



  static Future<Map<String, dynamic>> fetchBankDetailBySegmentIdAndKSDPLProductIdApi({
    required String segmentVerticalId,
    required String KSDPLProductId,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(fetchBankDetailBySegmentIdAndKSDPLProductId),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      MultipartFieldHelper.addFieldWithDefault(request.fields, 'SegmentVerticalId', segmentVerticalId, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'KSDPLProductId', KSDPLProductId, fallback: "0");

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(fetchBankDetailBySegmentIdAndKSDPLProductId, request.fields);
      Helper.ApiRes(fetchBankDetailBySegmentIdAndKSDPLProductId, response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed : ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error: $e');
    }
  }




  static Future<Map<String, dynamic>> getProductDetailBySegmentAndProductApi({
    required String segmentVerticalId,
    required String kSDPLProductId,
    required String bankId,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getProductDetailBySegmentAndProduct),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      MultipartFieldHelper.addFieldWithDefault(request.fields, 'SegmentVerticalId', segmentVerticalId, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'KSDPLProductId', kSDPLProductId, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'BankId', bankId, fallback: "0");

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      Helper.ApiReq(fetchBankDetailBySegmentIdAndKSDPLProductId, request.fields);
      Helper.ApiRes(fetchBankDetailBySegmentIdAndKSDPLProductId, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed : ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error: $e');
    }
  }

  static Future<Map<String, dynamic>> sendMailForLocationOfCustomerApi({
    required String locationType,
    required String leadId,
    required String email,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(sendMailForLocationOfCustomer),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LocationType', locationType, fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'LeadId', leadId);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Email', email,);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      Helper.ApiReq(fetchBankDetailBySegmentIdAndKSDPLProductId, request.fields);
      Helper.ApiRes(fetchBankDetailBySegmentIdAndKSDPLProductId, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed : ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error: $e');
    }
  }


  static Future<Map<String, dynamic>>requestForFinancialServicesApi({
    required String leadID
  })
  async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(requestForFinancialServices),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['LeadID'] = leadID.toString();
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(requestForFinancialServices, request.fields);
      Helper.ApiRes(requestForFinancialServices, response.body);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed : ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error : $e');
    }
  }

  static void printInChunks(String text, {int chunkSize = 2048}) {
    final pattern = RegExp('.{1,$chunkSize}', dotAll: true);
    for (final match in pattern.allMatches(text)) {
      print(match.group(0));
    }
  }

  static   requestForgetLeadDetailByCustomerNumberApi({required String mobileNumber})
    async {
      print("getLeadDetailByCustomerNumberApi--->");
      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(requestLeadDetailByCustomerNumber),
        );

        // Headers

        var header=await MyHeader.getHeaders2();

        request.headers.addAll(header);
        request.fields['MobileNumber'] = mobileNumber.toString();
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        Helper.ApiReq(requestLeadDetailByCustomerNumber, request.fields);
        Helper.ApiRes(requestLeadDetailByCustomerNumber, response.body);


        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          throw Exception('Failed : ${response.statusCode}');
        }
      } catch (e) {
        print("Error: $e");
        throw Exception('Error : $e');
      }
    }


  static   getCamNoteDetailsByLeadIdForUpdateApi({required String leadId})
  async {
    print("getCamNoteDetailsByLeadIdForUpdateApi--->");
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getCamNoteDetailsByLeadIdForUpdate),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['leadId'] = leadId.toString();
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(getCamNoteDetailsByLeadIdForUpdate, request.fields);
      Helper.ApiRes(getCamNoteDetailsByLeadIdForUpdate, response.body);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed : ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error : $e');
    }
  }

  static addCustomerDetailsApi({
    String? Id,
    String? CustomerName,
    String? MobileNumber,
    String? Email,
    String? Gender,
    String? AdharCard,
    String? PanCard,
    String? StreetAddress,
    String? State,
    String? District,
    String? City,
    String? Nationality,
  })
  async {
    print("addCustomerDetails--->");
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(addCustomerDetails),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Id', Id, fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'CustomerName', CustomerName);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'MobileNumber', MobileNumber);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Email', Email);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Gender', Gender);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'AdharCard', AdharCard);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'PanCard', PanCard);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'StreetAddress', StreetAddress);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'State', State, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'District', District, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'City', City, fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Nationality', Nationality);
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(addCustomerDetails, request.fields);
      Helper.ApiRes(addCustomerDetails, response.body);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed : ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error : $e');
    }
  }


  static sendPaymentQRCodeOnWhatsAppToCustomerApi({
    String? PackageId,
    String? CustomerName,
    String? CustomerWhatsAppNo,
    String? QRString,
  })
  async {
    print("addCustomerDetails--->");
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(sendPaymentQRCodeOnWhatsAppToCustomer),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'PackageId', PackageId, fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'CustomerName', CustomerName);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'CustomerWhatsAppNo', CustomerWhatsAppNo);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'QRString', QRString);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(sendPaymentQRCodeOnWhatsAppToCustomer, request.fields);
      Helper.ApiRes(sendPaymentQRCodeOnWhatsAppToCustomer, response.body);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed : ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error : $e');
    }
  }



  static checkReceiptStatusForCamNoteApi({
    required String Mobile,
    required String  Utr,
  })
  async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(checkReceiptStatusForCamNote),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Mobile', Mobile, fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Utr', Utr);


      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(checkReceiptStatusForCamNote, request.fields);
      Helper.ApiRes(checkReceiptStatusForCamNote, response.body);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed : ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error : $e');
    }
  }



 //CamNoteDetail/SaveCamnoteDetails
  static saveCamnoteDetailsApi({
    String? LeadId,
    String? CasesToBeForeclosedOnOrBeforeDisb,
    String? CasesToBeContenued,
    String? EMIStoppedOnBeforeThisLoan,
    String? EMIWillContinue,
    String? EMIsOfExistingLiabilities,
    String? OfferedSecurityType,
    String? PropertyValueAsPerCustomer,
    String? LoanTenorRequested,
    String? LTV,
    String? IncomeType,
    String? TotalFamilyIncome,
    String? IncomeCanBeConsidered,
    String? NonEarningCustomerAge,
    String? ROI,
    String? ProposedEMI,
    String? IIR,
    String? FOIR,
  })
  async {
    print("saveCamnoteDetailsApi--->");
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(saveCamnoteDetails),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LeadId', LeadId, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'CasesToBeForeclosedOnOrBeforeDisb', CasesToBeForeclosedOnOrBeforeDisb, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'CasesToBeForeclosedOnOrBeforeDisb', CasesToBeForeclosedOnOrBeforeDisb, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'CasesToBeContenued', CasesToBeContenued, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'EMIStoppedOnBeforeThisLoan', EMIStoppedOnBeforeThisLoan, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'EMIWillContinue', EMIWillContinue, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'EMIsOfExistingLiabilities', EMIsOfExistingLiabilities, fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'OfferedSecurityType', OfferedSecurityType);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'PropertyValueAsPerCustomer', PropertyValueAsPerCustomer, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LoanTenorRequested', LoanTenorRequested, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LTV', LTV, fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'IncomeType', IncomeType,);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalFamilyIncome', TotalFamilyIncome, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'IncomeCanBeConsidered', IncomeCanBeConsidered, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'NonEarningCustomerAge', NonEarningCustomerAge, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'ROI', ROI, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'ProposedEMI', ProposedEMI, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'IIR', IIR, fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'FOIR', FOIR, fallback: "0");

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(saveCamnoteDetails, request.fields);
      Helper.ApiRes(saveCamnoteDetails, response.body);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed : ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error : $e');
    }
  }


  ///GetSalePackagesByLeadId
  static getSalePackagesByLeadIdApi({
    required String LeadId,
  })
  async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getSalePackagesByLeadId),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LeadId', LeadId, fallback: "0");


      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(getSalePackagesByLeadId, request.fields);
      Helper.ApiRes(getSalePackagesByLeadId, response.body);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed : ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error : $e');
    }
  }


  ///generate QR new API
  static Future<Map<String, dynamic>> newGenerateQRApi({
    required String serviceId,
    required String amount,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(UPIAPisGenerateQR),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Amount', amount,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'ServiceId', serviceId, fallback: "0");



      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);



      Helper.ApiReq(UPIAPisGenerateQR, request.fields);
      Helper.ApiRes(UPIAPisGenerateQR, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }

  static Future<Map<String, dynamic>> sendBankerSelfUpdateLinkApi({
    required String bankerId,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(sendBankerSelfUpdateLink),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'BankerId', bankerId,fallback: "0");

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);



      Helper.ApiReq(sendBankerSelfUpdateLink, request.fields);
      Helper.ApiRes(sendBankerSelfUpdateLink, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }


  static Future<Map<String, dynamic>> addCibilAccountSummaryApi({
    required List<Map<String, dynamic>> body,
  })
  async {
    try {
      var headers = await MyHeader.getHeaders3(); // should return 'Authorization' and 'Content-Type: application/json'

      var response = await http.post(
        Uri.parse(addCibilAccountSummary),
        headers: headers,
        body: jsonEncode(body),
      );
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      Helper.ApiReq(addCibilAccountSummary, jsonEncode(body));
      Helper.ApiRes(addCibilAccountSummary, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }

  static Future<Map<String, dynamic>> getCibilAccountSummaryByLeadIdApi({
    required String leadId,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getCibilAccountSummaryByLeadId),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'leadId', leadId,fallback: "0");

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);



      Helper.ApiReq(getCibilAccountSummaryByLeadId, request.fields);
      Helper.ApiRes(getCibilAccountSummaryByLeadId, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit application: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while submitting: $e');
    }
  }

}