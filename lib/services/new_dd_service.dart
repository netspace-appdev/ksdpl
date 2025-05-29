import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ksdpl/common/get_header.dart';
import 'dart:convert';
import '../common/base_url.dart';
import 'package:http/http.dart' as http;

import '../common/helper.dart';

class NewDDService {


  static const String getBranchListOfDistrictByZipAndBank = BaseUrl.baseUrl + 'Branch/GetBranchListOfDistrictByZipAndBank';
  static const String getBankerDetailsByBranchId = BaseUrl.baseUrl + 'CamNoteDetail/GetBankerDetailsByBranchId';






  static Future<Map<String, dynamic>> getBranchListOfDistrictByZipAndBankApi({

    String? zipcode,
    String? bankId,

  }) async {
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

      print("request===>==>getBankerDetailsByBranchIdApi===>${request.fields.toString()}");
      print("response.statusCode===>${response.statusCode}");
      print("response==>getBankerDetailsByBranchIdApi==>${response.body.toString()}");

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