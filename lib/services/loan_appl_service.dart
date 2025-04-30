import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ksdpl/common/get_header.dart';
import 'package:ksdpl/common/helper.dart';
import 'dart:convert';

import '../common/base_url.dart';
import '../common/storage_service.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class LoanApplService {
  static const String addLoanApplicationDetails = BaseUrl.baseUrl + 'LeadDetail/AddLoanApplicationDetails';
  static const String getLoanApplicationDetailsById = BaseUrl.baseUrl + 'LeadDetail/GetLoanApplicationDetailsById';

  static Future<Map<String, dynamic>> addLoanApplicationApi({
    required List<Map<String, dynamic>> body,
  }) async {
    try {
      var headers = await MyHeader.getHeaders3(); // should return 'Authorization' and 'Content-Type: application/json'

      var response = await http.post(
        Uri.parse(addLoanApplicationDetails),
        headers: headers,
        body: jsonEncode(body),
      );

      print("Request Body: ${jsonEncode(body)}");
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

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

  static Future<Map<String, dynamic>> getLoanApplicationDetailsByIdApi({
    required String id,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getLoanApplicationDetailsById),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['Id'] = id.toString();


      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("===>  getLoanApplicationDetailsByIdApi==>");
      print("request===>==>${request.fields.toString()}");
      print("response.statusCode===>${response.statusCode}");
      print("response==>getLoanApplicationDetailsByIdApi==>${response.body.toString()}");

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

