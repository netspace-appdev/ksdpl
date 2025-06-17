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
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'IncomeTypes', incomeTypes);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'AgeEarningApplicants', ageEarningApplicants,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'AgeNonEarningCoApplicant',  ageNonEarningCoApplicant,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'ApplicantMonthlySalary',  applicantMonthlySalary,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LoanAmount',  loanAmount,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Tenor',  tenor,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Roi',  roi,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'MaximumTenorEligibilityCriteria',  maximumTenorEligibilityCriteria,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'CustomerAddress', customerAddress);

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

     Helper.ApiReq(addAdditionalSourceIncome, jsonEncode(body));
     Helper.ApiRes(addAdditionalSourceIncome, response.body);

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

  }) async {
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
      Helper.ApiReq(updateBankerDetail, request.fields);
      Helper.ApiRes(updateBankerDetail, response.body);

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
      Helper.ApiReq(addBankerDetail, request.fields);
      Helper.ApiRes(addBankerDetail, response.body);

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

  static void printInChunks(String text, {int chunkSize = 2048}) {
    final pattern = RegExp('.{1,$chunkSize}', dotAll: true);
    for (final match in pattern.allMatches(text)) {
      print(match.group(0));
    }
  }


}