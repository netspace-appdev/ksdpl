import 'package:http/http.dart' as http;
import 'dart:convert';
import '../common/base_url.dart';
import '../common/get_header.dart';
import '../common/helper.dart';

class GenerateCibilServices {
  static const String addCustomerCibilRequest = BaseUrl.baseUrl + 'FileUpload/AddCustomerCibilRequest';





  static Future<Map<String, dynamic>> addCustomerCibilRequestApi({


    required String Id,
    required String Name,
    required String Mobile,
    required String Amount,
    required String ReceiveDate,
    required String Utr,
    required String User_ID,

  })
  async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(addCustomerCibilRequest),
      );

      var header=await MyHeader.getHeaders2();


      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Id', Id,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Name', Name);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Mobile', Mobile);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Amount', Amount,fallback:"0" );
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'ReceiveDate', ReceiveDate);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Utr', Utr);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'User_ID', User_ID);

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(addCustomerCibilRequest, request.fields);
      Helper.ApiRes(addCustomerCibilRequest, response.body);

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
