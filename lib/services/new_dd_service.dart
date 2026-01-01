import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ksdpl/common/get_header.dart';
import 'dart:convert';
import '../common/base_url.dart';
import 'package:http/http.dart' as http;

import '../common/helper.dart';

class NewDDService {


  static const String getBranchListOfDistrictByZipAndBank = BaseUrl.baseUrl + 'Branch/GetBranchListOfDistrictByZipAndBank';
  static const String getBankerDetailsByBranchId = BaseUrl.baseUrl + 'CamNoteDetail/GetBankerDetailsByBranchId'; //fetch bank
  static const String getBankerDetailsById = BaseUrl.baseUrl + 'CamNoteDetail/GetBankerDetailsById';
  static const String getAllPrimeSecurityMaster = BaseUrl.baseUrl + 'BankMaster/GetAllPrimeSecurityMaster';
  static const String insertCustomerPackageRequestOnCamnote = BaseUrl.baseUrl + 'FileUpload/InsertCustomerPackageRequestOnCamnote';






  static Future<Map<String, dynamic>> getBranchListOfDistrictByZipAndBankApi({

    String? zipcode,
    String? bankId,

  }) async {
    print("inside--->getBranchListOfDistrictByZipAndBank");
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getBranchListOfDistrictByZipAndBank),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'zipcode', zipcode,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'bankId', bankId,fallback: "0");


      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(getBranchListOfDistrictByZipAndBank, request.fields);
      Helper.ApiRes(getBranchListOfDistrictByZipAndBank, response.body);
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


  static Future<Map<String, dynamic>> getBankerDetailsByBranchIdApi({
    String? branchId,

  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getBankerDetailsByBranchId),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'BranchId', branchId,fallback: "0");


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



  static Future<Map<String, dynamic>> getBankerDetailsByIdApi({
    String? bankerId,

  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getBankerDetailsById),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Id', bankerId,fallback: "0");


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

  static Future<Map<String, dynamic>> getAllPrimeSecurityMasterApi() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllPrimeSecurityMaster),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);



      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(getAllPrimeSecurityMaster, request.fields);
      Helper.ApiRes(getAllPrimeSecurityMaster, response.body);



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

  static Future<Map<String, dynamic>> insertCustomerPackageRequestOnCamnoteApi({
    String? Id,
    String? Name,
    String? Mobile,
    String? Amount,
    String? ReceiveDate,
    String? Utr,
    String? User_ID,
    String? PackageId,
    String? LeadId,

  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(insertCustomerPackageRequestOnCamnote),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Id', Id,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Name', Name);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Mobile', Mobile);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Amount', Amount);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'ReceiveDate', ReceiveDate);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Utr', Utr);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'User_ID', User_ID);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'PackageId', PackageId);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'LeadId', LeadId);


      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);



      Helper.ApiReq(insertCustomerPackageRequestOnCamnote, request.fields);
      Helper.ApiRes(insertCustomerPackageRequestOnCamnote, response.body);

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