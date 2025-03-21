import 'package:http/http.dart' as http;
import 'package:ksdpl/common/get_header.dart';
import 'package:ksdpl/common/helper.dart';
import 'dart:convert';

import '../common/base_url.dart';
import '../common/storage_service.dart';

class DashboardApiService{
  static const String baseUrl =BaseUrl.baseUrl; //'http://192.168.29.2:8085/api/';
  static const String base2 = '';
  static const String getEmployeeByPhoneNumber = baseUrl + 'Employee/GetEmployeeByPhoneNumber';
  static const String getCountOfLeadsForDashboard = baseUrl + 'LeadDetail/GetCountOfLeadsForDashboard';
  static const String getBreakingNews = baseUrl + 'UpdatedNews/GetBreakingNews';
  static const String getUpcomingDateOfBirth = baseUrl + 'Employee/GetUpcomingDateOfBirth';


  static Future<Map<String, dynamic>> getEmployeeByPhoneNumberApi({
    required String phone,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getEmployeeByPhoneNumber),
      );

      var headers = await MyHeader.getHeaders();


      request.headers.addAll(headers);

      request.fields['PhoneNumber'] = phone;

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Map<String, dynamic>> getCountOfLeadsApi({
    required employeeId,
    required applyDateFilter,
  }) async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getCountOfLeadsForDashboard),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['EmployeeId'] = employeeId;
      request.fields['ApplyDateFilter'] =applyDateFilter;

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("request===>  getCountOfLeadsApi==>${getCountOfLeadsApi.toString()}");
      print("request===>==>${request.fields.toString()}");
      print("response.statusCode===>${response.statusCode}");
      print("response==>${response.body.toString()}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }


  static Future<Map<String, dynamic>> getBreakingNewsApi() async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getBreakingNews),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("request===>  getBreakingNews==>${getBreakingNews.toString()}");
      print("request===>==>${request.fields.toString()}");
      print("response.statusCode===>${response.statusCode}");
      print("response==>${response.body.toString()}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Map<String, dynamic>> getUpcomingDateOfBirthApi() async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getUpcomingDateOfBirth),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("request===>  getUpcomingDateOfBirth==>${getUpcomingDateOfBirth.toString()}");
      print("request===>==>${request.fields.toString()}");
      print("response.statusCode===>${response.statusCode}");
      print("response==>${response.body.toString()}");
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {

          return jsonResponse;
        } else {
          //throw Exception('Invalid API response');
          return jsonResponse;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

}
