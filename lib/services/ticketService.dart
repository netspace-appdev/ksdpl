import 'dart:convert';
import 'dart:io';
import '../common/base_url.dart';
import 'package:http/http.dart'as http;
import '../common/get_header.dart';
import '../common/helper.dart';
import '../common/storage_service.dart';

class TicketService {

  static const String addTicketRequest = BaseUrl.baseUrl + 'Ticket/AddTicket';
  static const String getAllTicketRequest = BaseUrl.baseUrl + 'Ticket/GetAllTicket';
  static const String getTicketByIdRequest = BaseUrl.baseUrl + 'Ticket/GetTicketById';
  static const String sendRequestResponse = BaseUrl.baseUrl + 'Ticket/SendRequestResponse';
  static const String statusUpdateTicketRequest = BaseUrl.baseUrl + 'Ticket/StatusUpdateTicket';


  static Future<Map<String, dynamic>> addTicketApi({
    required String id,
    required String panelId,
    required String subject,
    required String category,
    required String issueDetails,
    required String priority,
  }) async {


    try {
      var empId=StorageService.get(StorageService.EMPLOYEE_ID).toString();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(addTicketRequest),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Id', id,fallback: "0");
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'PanelId', panelId);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Subject', subject,);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Category', category,);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'Priority', priority,);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'IssueDetails', issueDetails,);
      MultipartFieldHelper.addFieldWithoutNull(request.fields, 'CreatedBy', empId,);


      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(addTicketRequest, request.fields);
      Helper.ApiRes(addTicketRequest, response.body);

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



  static Future<Map<String, dynamic>> getAllTicketApi() async {

    try {
      var empId=StorageService.get(StorageService.EMPLOYEE_ID).toString();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllTicketRequest),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Id', empId ,fallback: "0");

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(getAllTicketRequest, request.fields);
      Helper.ApiRes(getAllTicketRequest, response.body);

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

  static Future<Map<String, dynamic>> getTicketByIdApi({int? id}) async {

    try {
      var empId=StorageService.get(StorageService.EMPLOYEE_ID).toString();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getTicketByIdRequest),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Id', id.toString() ,fallback: "0");

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(getTicketByIdRequest, request.fields);
      Helper.ApiRes(getTicketByIdRequest, response.body);

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


    static Future<Map<String, dynamic>>sendMessageApi({required String ticketId, required String message, File? image}) async {


      try {
        var empId=StorageService.get(StorageService.EMPLOYEE_ID).toString();

        var request = http.MultipartRequest(
          'POST',
          Uri.parse(sendRequestResponse),
        );

        var header=await MyHeader.getHeaders2();

        request.headers.addAll(header);
        MultipartFieldHelper.addFieldWithDefault(request.fields, 'TicketId', ticketId.toString() ,fallback: "0");
        MultipartFieldHelper.addFieldWithDefault(request.fields, 'Request', message.toString() ,fallback: "");
        MultipartFieldHelper.addFieldWithDefault(request.fields, 'Response', '' ,fallback: "");
        MultipartFieldHelper.addFieldWithDefault(request.fields, 'ActionBy', empId ,fallback: "0");
        if (image != null) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'Image',
              image.path,
            ),
          );
        } else {
          request.fields['Image'] = '';
        }

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        Helper.ApiReq(sendRequestResponse, request.fields);
        Helper.ApiRes(sendRequestResponse, response.body);

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


  static statusUpdateTicketApi({required String TicketNo, required String PanelId, required String status})async {


    try {
      var empId=StorageService.get(StorageService.EMPLOYEE_ID).toString();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(statusUpdateTicketRequest),
      );

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'TicketNo', TicketNo.toString() ,fallback: "0");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'PanelId', PanelId.toString() ,fallback: "");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'Status', status ,fallback: "");
      MultipartFieldHelper.addFieldWithDefault(request.fields, 'CloseBy', empId ,fallback: "0");

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(statusUpdateTicketRequest, request.fields);
      Helper.ApiRes(statusUpdateTicketRequest, response.body);

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