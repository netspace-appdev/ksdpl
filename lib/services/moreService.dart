import 'package:http/http.dart' as http;
import 'dart:convert';
import '../common/base_url.dart';
import '../common/get_header.dart';
import '../common/helper.dart';
import '../common/storage_service.dart';

class MoreServices {
  static const String CheckOldPassword = BaseUrl.baseUrl + 'Auth/CheckOldPassword';
  static const String ChangePassword = BaseUrl.baseUrl + 'Auth/ChangePassword';
  static const String ChangePhoneNumber = BaseUrl.baseUrl + 'Auth/ChangeUserPhoneNumber';
  static const String ChangeUserEmail = BaseUrl.baseUrl + 'Auth/ChangeUserEmail';
  static const String getUserByIdRequest = BaseUrl.baseUrl + 'Employee/GetEmployeeById';
  static const String getUserEducationByIdRequest = BaseUrl.baseUrl + 'Employee/GetEducationDetailsByEmployeeId';
  static const String getUserProfessionByIdRequest = BaseUrl.baseUrl + 'Employee/GetProfessionalDetailByEmployeeId';
  static const String generateAadharOtpRequest = BaseUrl.baseUrl + 'FileUpload/GenerateAadharOTP';


  //checkOldPasswordRequestApi

  static Future<Map<String, dynamic>> checkOldPasswordRequestApi({

 required String OldPassword,

  })
  async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(CheckOldPassword),
      );

      var header=await MyHeader.getHeaders2();


      request.headers.addAll(header);
      MultipartFieldHelper.addField(request.fields, 'OldPassword', OldPassword);


      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(CheckOldPassword, request.fields);
      Helper.ApiRes(CheckOldPassword, response.body);

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



  //changePasswordRequestApi

  static Future<Map<String, dynamic>> changePasswordRequestApi({

 required String NewPassword,

  })
  async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ChangePassword),
      );

      var header=await MyHeader.getHeaders2();


      request.headers.addAll(header);
      MultipartFieldHelper.addField(request.fields, 'NewPassword', NewPassword,);


      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(ChangePassword, request.fields);
      Helper.ApiRes(ChangePassword, response.body);

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



  //changeEmailRequestApi

  static Future<Map<String, dynamic>> changeEmailRequestApi({

 required String Email,
 required String PhoneNumber,

  })
  async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ChangeUserEmail),
      );

      var header=await MyHeader.getHeaders2();


      request.headers.addAll(header);
      MultipartFieldHelper.addField(request.fields, 'Email', Email,);
      MultipartFieldHelper.addField(request.fields, 'PhoneNumber', PhoneNumber,);


      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(ChangeUserEmail, request.fields);
      Helper.ApiRes(ChangeUserEmail, response.body);

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


  //ChangeUserPhoneNumberRequestApi

  static Future<Map<String, dynamic>> changeUserPhoneNumberRequestApi({

 required String PhoneNumber,
 required String Email,

  })
  async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ChangePhoneNumber),
      );

      var header=await MyHeader.getHeaders2();


      request.headers.addAll(header);
      MultipartFieldHelper.addField(request.fields, 'Email', Email,);
      MultipartFieldHelper.addField(request.fields, 'PhoneNumber', PhoneNumber,);


      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(ChangePhoneNumber, request.fields);
      Helper.ApiRes(ChangePhoneNumber, response.body);

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

  static Future<Map<String, dynamic>> getUserDetailRequestApi()
  async {
    try {
      var userId=StorageService.get(StorageService.EMPLOYEE_ID);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getUserByIdRequest),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addField(request.fields, 'Id', userId,);

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(getUserByIdRequest, request.fields);
      Helper.ApiRes(getUserByIdRequest, response.body);

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

  static getUserEducationDetailRequestApi() async {
    try {
      var userId=StorageService.get(StorageService.EMPLOYEE_ID);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getUserEducationByIdRequest),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addField(request.fields, 'Id', userId,);

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(getUserEducationByIdRequest, request.fields);
      Helper.ApiRes(getUserEducationByIdRequest, response.body);

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

  static getUserProfessionDetailRequestApi() async {
    try {
      var userId=StorageService.get(StorageService.EMPLOYEE_ID);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getUserProfessionByIdRequest),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addField(request.fields, 'Id', userId,);

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(getUserProfessionByIdRequest, request.fields);
      Helper.ApiRes(getUserProfessionByIdRequest, response.body);

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
