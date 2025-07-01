import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ksdpl/common/get_header.dart';
import 'dart:convert';
import '../common/base_url.dart';
import 'package:http/http.dart' as http;

import '../common/helper.dart';

class AttendanceService {


  static const String getAttendanceListOfEmployeesByEmployeeId = BaseUrl.baseUrl + 'Employee/GetAttendanceListOfEmployeesByEmployeeId';
  static const String getAllLeaveType = BaseUrl.baseUrl + 'Leave/GetAllLeaveType';
  static const String getAllLeaveDetailByEmployeeId = BaseUrl.baseUrl + 'Leave/GetAllLeaveDetailByEmployeeId';
  static const String addEmployeeLeaveDetail = BaseUrl.baseUrl + 'Leave/AddEmployeeLeaveDetail';


  static Future<Map<String, dynamic>> getAttendanceListOfEmployeesByEmployeeIdApi({

    required String employeeId,
    String? fromDate,
    String? toDate,

  }) async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAttendanceListOfEmployeesByEmployeeId),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'EmployeeId', employeeId,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'dateDTO.FromDate', fromDate);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'dateDTO.ToDate', toDate,);


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


  static Future<Map<String, dynamic>> getAllLeaveTypeApi() async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllLeaveType),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);


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

  static Future<Map<String, dynamic>> getAllLeaveDetailByEmployeeIdApi({

    required String employeeId,

  }) async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllLeaveDetailByEmployeeId),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'EmployeeId', employeeId,fallback: "0");



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

  static Future<Map<String, dynamic>> addEmployeeLeaveDetailApi({

    required String id,
    required String employeeId,
    required String leaveType,
    required String startDate,
    required String endDate,
    required String totalDays,
    required String reason,
  }) async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(addEmployeeLeaveDetail),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Id', id,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'EmployeeId', employeeId,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'LeaveType', leaveType,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'StartDate', startDate);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'EndDate', endDate,);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TotalDays', totalDays,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Reason', reason,);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);


      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed : ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error : $e');
    }
  }
}