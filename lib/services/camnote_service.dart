import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ksdpl/common/get_header.dart';
import 'dart:convert';
import '../common/base_url.dart';
import 'package:http/http.dart' as http;

import '../common/helper.dart';

class CamNoteService {


  static const String getProductDetailsByFilter = BaseUrl.baseUrl + 'LeadDetail/GetProductDetailsByFilter';






  static Future<Map<String, dynamic>> getProductDetailsByFilterApi({

    String? cibil,

  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getProductDetailsByFilter),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'MinCibil', cibil,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'SegmentVertical', "",fallback: "0");
      MultipartFieldHelper.addField(request.fields, 'CustomerCategory', "");
      MultipartFieldHelper.addField(request.fields, 'CollateralSecurityCategory', "");
      MultipartFieldHelper.addField(request.fields, 'CollateralSecurityExcluded', "");
      MultipartFieldHelper.addField(request.fields, 'IncomeTypes', "");
      MultipartFieldHelper.addField(request.fields, 'IncomeTypes', "");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'AgeEarningApplicants', "",fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'AgeNonEarningCoApplicant',  "",fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'ApplicantMonthlySalary',  "",fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LoanAmount',  "",fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Tenor',  "",fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Roi',  "",fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'MaximumTenorEligibilityCriteria',  "",fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'MaximumTenorEligibilityCriteria',  "",fallback: "0");
      MultipartFieldHelper.addField(request.fields, 'CustomerAddress', "");

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      print("request===>==>getProductDetailsByFilterApi===>${request.fields.toString()}");
      print("response.statusCode===>${response.statusCode}");
      print("response==>getProductDetailsByFilterApi==>${response.body.toString()}");

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