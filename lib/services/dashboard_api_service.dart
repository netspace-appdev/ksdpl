import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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
  static const String getReminderCallListTodayAndTomorrow = baseUrl + 'LeadDetail/GetReminderCallListTodayAndTomorrow';
  static const String getCampaignName = baseUrl + 'LeadDetail/GetCampaignName';
  static const String getBreakingNewsById = baseUrl + 'UpdatedNews/GetBreakingNewsById';
  static const String todayWorkStatusOfRoBm = baseUrl + 'EmployeeDashboard/TodayWorkStatusOfRoBm';

  static const String GetDetailsCountOfLeadsForDashboard = baseUrl + 'LeadDetail/GetDetailsCountOfLeadsForDashboard';

/*
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
*/

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

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final jsonResponse = jsonDecode(response.body);
      print("jsonResponse===>${jsonResponse}");

      if (response.statusCode == 200) {
        if (jsonResponse['status'] == "200" && jsonResponse['success'] == true) {
          return jsonResponse;
        } else {
          return jsonResponse; // error but 200
        }
      } else {
        // Still return the error JSON body even if not 200
        return jsonResponse;
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

      print("Request lead count api===>${request.fields}");
      print("Response lead count api===>${response.body}");

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

  static Future<Map<String, dynamic>> getDetailsCountOfLeadsForDashboardApi({
    required employeeId,
    required applyDateFilter,
  }) async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(GetDetailsCountOfLeadsForDashboard),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['EmployeeId'] = employeeId;
      request.fields['ApplyDateFilter'] =applyDateFilter;

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("Request getDetailsCountOfLeadsForDashboardApi===>${request.fields}");
      print("Response getDetailsCountOfLeadsForDashboardApi===>${response.body}");

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


  static Future<Map<String, dynamic>> todayWorkStatusOfRoBmApi({
    required employeeId
}) async {
print("todayWorkStatusOfRoBmApi");
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(todayWorkStatusOfRoBm),
      );


    // Step 1: Get current DateTime
    DateTime now = DateTime.now();

    // Step 2: Format it to match your expected input
    String dateString = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SS").format(now);

    // Step 3: Call your method
    //String formatted = Helper.formatDate(dateString);
    print("dateString===>${dateString}");
    /*print("formatted===>${formatted}");

    print("Formatted: $formatted");
*/
      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['FromDate'] = dateString;
      request.fields['ToDate'] =dateString;
      request.fields['EmployeeId'] =employeeId;

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("request===>todayWorkStatusOfRoBmApi==>${request.fields.toString()}");
      print("resp===>todayWorkStatusOfRoBmApi======>${response.body.toString()}");

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

  static Future<Map<String, dynamic>> getRemindersApi({
    required employeeId,
  }) async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getReminderCallListTodayAndTomorrow),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      request.fields['AssignPickupEmployee'] =employeeId.toString();

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("request===>  getRemindersApi==>");
      print("request===>==>${request.fields.toString()}");
      print("response.statusCode===>${response.statusCode}");
      print("response==>getRemindersApi==>${response.body.toString()}");
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

  static Future<Map<String, dynamic>> getBreakingNewsByIdApi({
    required newsId,
  }) async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getBreakingNewsById),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      request.fields['Id'] =newsId.toString();

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("request===>  getBreakingNewsByIdApi==>");
      print("request===>==>${request.fields.toString()}");
      print("response.statusCode===>${response.statusCode}");
      print("response==>getBreakingNewsByIdApi==>${response.body.toString()}");
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
