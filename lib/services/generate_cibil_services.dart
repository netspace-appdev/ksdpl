import 'package:http/http.dart' as http;
import 'dart:convert';
import '../common/base_url.dart';
import '../common/get_header.dart';
import '../common/helper.dart';

class GenerateCibilServices {
  static const String addCustomerCibilRequest = BaseUrl.baseUrl + 'FileUpload/AddCustomerCibilRequest';
  static const String viewExpenseRequest = BaseUrl.baseUrl + 'Employee/GetExpenseByEmployeeID';
  static const String getExpenseByIDRequest = BaseUrl.baseUrl + 'Employee/GetExpenseByID';
  static const String addEmployeeExpenseRequest = BaseUrl.baseUrl + 'Employee/AddEmployeeExpenseDetails';
  static const String getCustomerCibilDetailRequest = BaseUrl.baseUrl + 'FileUpload/GetCustomerCibilDetailByUserId';
  static const String udateExpenseDetailsRequest = BaseUrl.baseUrl + 'Employee/UpdateExpenseDetails';




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


  static Future<Map<String, dynamic>> getExpenseByEmployeeIDApi({

    required String employeeId,


  })
  async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(viewExpenseRequest),
      );

      var header=await MyHeader.getHeaders2();


      request.headers.addAll(header);
      MultipartFieldHelper.addField(request.fields, 'employeeId', employeeId);


      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(viewExpenseRequest, request.fields);
      Helper.ApiRes(viewExpenseRequest, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to viewExpenseRequest: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while viewExpenseRequest : $e');
    }
  }





  static Future<Map<String, dynamic>> getEmployeeExpenseByIDRequest({
    required String ExpenseId,
  })
  async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getExpenseByIDRequest),
      );

      var header=await MyHeader.getHeaders2();


      request.headers.addAll(header);
      MultipartFieldHelper.addField(request.fields, 'ExpenseId', ExpenseId);


      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(getExpenseByIDRequest, request.fields);
      Helper.ApiRes(getExpenseByIDRequest, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to ExpenseByIDRequest: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while ExpenseByIDRequest : $e');
    }
  }


  static Future<Map<String, dynamic>> addEmployeeExpenseRequestApi({
    required String employeeId,
    required String entryDate,
    required String expenseDate,
    required String description,
    required List<http.MultipartFile> documents,
  }) async
  {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(addEmployeeExpenseRequest),
      );

      var header = await MyHeader.getHeaders2();
      request.headers.addAll(header);

      // Add form fields
      MultipartFieldHelper.addField(request.fields, 'Id', '0');
      MultipartFieldHelper.addField(request.fields, 'EmployeeId', employeeId);
      MultipartFieldHelper.addField(request.fields, 'EntryDate', entryDate);
      MultipartFieldHelper.addField(request.fields, 'ExpenseDate', expenseDate);
      MultipartFieldHelper.addField(request.fields, 'Description', description);

      // Add documents as files
      request.files.addAll(documents);

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(addEmployeeExpenseRequest, request.fields);
      Helper.ApiRes(addEmployeeExpenseRequest, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to addEmployeeExpenseRequest: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while addEmployeeExpenseRequest : $e');
    }
  }


  static Future<Map<String, dynamic>> addUdateExpenseDetailsRequest({
    required String id,
    required String employeeId,
    required String entryDate,
    required String expenseDate,
    required String description,
    required List<http.MultipartFile> documents,
  }) async
  {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(udateExpenseDetailsRequest),
      );

      var header = await MyHeader.getHeaders2();
      request.headers.addAll(header);

      // Add form fields
      MultipartFieldHelper.addField(request.fields, 'Id', id);
      MultipartFieldHelper.addField(request.fields, 'EmployeeId', employeeId);
      MultipartFieldHelper.addField(request.fields, 'EntryDate', entryDate);
      MultipartFieldHelper.addField(request.fields, 'ExpenseDate', expenseDate);
      MultipartFieldHelper.addField(request.fields, 'Description', description);

      // Add documents as files
      request.files.addAll(documents);

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(udateExpenseDetailsRequest, request.fields);
      Helper.ApiRes(udateExpenseDetailsRequest, response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to udateExpenseDetailsRequest: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error while udateExpenseDetailsRequest : $e');
    }
  }



  static Future<Map<String, dynamic>>  getCustomerCibilDetailByUserIdApiRequest(
      {required String userId}
      )
  async {
      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(getCustomerCibilDetailRequest),
        );

        var header=await MyHeader.getHeaders2();

        request.headers.addAll(header);
        MultipartFieldHelper.addField(request.fields, 'userId', userId);

        var streamedResponse = await request.send();

        var response = await http.Response.fromStream(streamedResponse);

        Helper.ApiReq(getCustomerCibilDetailRequest, request.fields);
        Helper.ApiRes(getCustomerCibilDetailRequest, response.body);

        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          throw Exception('Failed to getCustomerCibilDetailRequest: ${response.statusCode}');
        }
      } catch (e) {
        print("Error: $e");
        throw Exception('Error while getCustomerCibilDetailRequest : $e');
      }
    }
  }



