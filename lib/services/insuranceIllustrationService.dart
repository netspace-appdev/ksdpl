import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ksdpl/common/get_header.dart';
import 'dart:convert';
import '../common/base_url.dart';
import 'package:http/http.dart' as http;

import '../common/helper.dart';

class Insuranceillustrationservice {

  static const String getAllInsuranceIllustrations = BaseUrl.baseUrl + 'CamNoteDetail/GetAllInsuranceIllustrations';





  static Future<Map<String, dynamic>> getInsuranceLeadsApi() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllInsuranceIllustrations),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);


      print("response.statusCode===>getAllInsuranceIllustrations==>${response.statusCode}");
      print("response==>getAllInsuranceIllustrations==>${response.body.toString()}");
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




