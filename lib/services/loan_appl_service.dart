import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ksdpl/common/get_header.dart';
import 'package:ksdpl/common/helper.dart';
import 'dart:convert';

import '../common/base_url.dart';
import '../common/storage_service.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class LoanApplService {
  static const String addLoanApplicationDetails = BaseUrl.baseUrl + 'LeadDetail/AddLoanApplicationDetails';
  static const String SubmittLoanDocument = BaseUrl.baseUrl + 'LeadDetail/SubmittLoanDocument';
  static const String GetLoanApplicationDocumentByLoanIdApi = BaseUrl.baseUrl +'LeadDetail/GetLoanApplicationDocumentByLoanId';
  static const String RemovedLoanApplicationDocumentApi = BaseUrl.baseUrl +'LeadDetail/RemovedLoanApplicationDocument';



  // static const String getLoanApplicationDetailsById = BaseUrl.baseUrl +
  // 'LeadDetail/GetLoanApplicationDetailsById';
  static const String getLoanApplicationDetailsByUniqueLeadNumber =
      BaseUrl.baseUrl + 'LeadDetail/GetLoanApplicationDetailsByUniqueLeadNumber';




  static Future<Map<String, dynamic>> addLoanApplicationApi({
    required List<Map<String, dynamic>> body,
  })
  async {
    try {
      var headers = await MyHeader.getHeaders3(); // should return 'Authorization' and 'Content-Type: application/json'

      var response = await http.post(
        Uri.parse(addLoanApplicationDetails),
        headers: headers,
        body: jsonEncode(body),
      );
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');


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
  })
  async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getLoanApplicationDetailsByUniqueLeadNumber),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['UniqueLeadNumber'] = id.toString();


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

  static void printInChunks(String text, {int chunkSize = 2048}) {
    final pattern = RegExp('.{1,$chunkSize}', dotAll: true);
    for (final match in pattern.allMatches(text)) {
      print(match.group(0));
    }
  }

  //onUploadDocumentApi

  static Future<Map<String, dynamic>> SubmittLoanDocumentApi({
    required String id,
    required String LoanId,
    required String ImageName,
    required List<Map<String, dynamic>> imageMap,
  })
  async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(SubmittLoanDocument),
      );

      // Add headers
      var headers = await MyHeader.getHeaders2();
      request.headers.addAll(headers);

      // Add fields
      request.fields['Id'] = id;
      request.fields['LoanId'] = LoanId;
      request.fields['ImageName'] = ImageName;

      // Attach files properly under ImagePath (as array)
      for (var item in imageMap) {
        final filePath = item['filePath'];
        if (filePath != null && filePath.toString().isNotEmpty) {
          final file = File(filePath);
          if (await file.exists()) {
            request.files.add(await http.MultipartFile.fromPath(
              'ImagePath', // field name expected by server
              file.path,
            ));
          }
        }
      }


      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // Debug
      Helper.ApiReq(SubmittLoanDocument, request.fields);
      Helper.ApiRes(SubmittLoanDocument, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit document: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ Error while submitting document: $e");
      throw Exception('Error: $e');
    }
  }

  static Future<Map<String, dynamic>> getLoanApplicationDocumentByLoanIdApi({
    required String loanId,

  })
  async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(GetLoanApplicationDocumentByLoanIdApi),
      );

      // Add headers
      var headers = await MyHeader.getHeaders2();
      request.headers.addAll(headers);

      // Add fields
      request.fields['loanId'] = loanId;

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // Debug
      Helper.ApiReq(GetLoanApplicationDocumentByLoanIdApi, request.fields);
      Helper.ApiRes(GetLoanApplicationDocumentByLoanIdApi, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to GetLoanApplicationDocumentByLoanId document: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ Error while submitting document: $e");
      throw Exception('Error: $e');
    }
  }

  static Future<Map<String, dynamic>> getLoanApplicationRemoveDocumentApi({
    required String DocumentId,

  })
  async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(RemovedLoanApplicationDocumentApi),
      );

      // Add headers
      var headers = await MyHeader.getHeaders2();
      request.headers.addAll(headers);

      // Add fields
      request.fields['DocumentId'] = DocumentId;

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // Debug
      Helper.ApiReq(RemovedLoanApplicationDocumentApi, request.fields);
      Helper.ApiRes(RemovedLoanApplicationDocumentApi, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to RemovedLoanApplicationDocumentApi document: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ Error while submitting document: $e");
      throw Exception('Error: $e');
    }
  }



}

