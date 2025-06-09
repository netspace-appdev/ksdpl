import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ksdpl/common/get_header.dart';
import 'package:ksdpl/common/helper.dart';
import 'dart:convert';

import '../common/base_url.dart';
import '../common/storage_service.dart';

class LeadApiService {
  static const String baseUrl =BaseUrl.baseUrl;
  static const String base2 = '';
  static const String fillLeadForm = baseUrl + 'LeadDetail/FillLeadForm';
  static const String individualLeadUpload = baseUrl + 'LeadDetail/IndividualLeadUpload';


  static Future<Map<String, dynamic>> fillLeadFormApi({
    required String id,

    required String dob,

    required String gender,
    required String loanAmtReq,
    String? email,
    String? aadhar,
    String? pan,
    String? streetAdd,
    String state = "0",
    String district = "0",
    String city = "0",
    String? zip,
    String? nationality,
    String currEmpSt = "0",
    String? employerName,
    String? monthlyIncome,
    String? addSrcIncome,
    String prefBank = "0",
    String? exRelBank,
    String? branchLoc,
    String prodTypeInt = "0",
    String? connName,
    String? connMob,
    String? connShare,
    String? loanApplNo,
   }) async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(fillLeadForm),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['Id'] = id.toString();

      request.fields['DateOfBirth'] = dob;

      request.fields['Gender'] = gender;
      request.fields['LoanAmountRequested'] = loanAmtReq;
      if (email != "string") request.fields['Email'] = email ?? "null";
      if (aadhar != "string") request.fields['AdharCard'] = aadhar ?? "null";
      if (pan != "string") request.fields['PanCard'] = pan ?? "null";
      if (streetAdd != "streetAdd") request.fields['StreetAddress'] = streetAdd ?? "null";
      request.fields['State'] = state;
      request.fields['District'] = district;
      request.fields['City'] = city;
      if (zip != "string") request.fields['Pincode'] = zip ?? "null";
      if (nationality != "string") request.fields['Nationality'] = nationality ?? "null";
      request.fields['CurrentEmploymentStatus'] = currEmpSt;
      if (employerName != "string") request.fields['EmployerName'] = employerName ?? "null";
      if (monthlyIncome != "string") request.fields['MonthlyIncome'] = monthlyIncome ?? "null";
      if (addSrcIncome != "string") request.fields['AdditionalSourceOfIncome'] = addSrcIncome ?? "null";
      request.fields['PrefferedBank'] = prefBank;

      if (exRelBank != "string") request.fields['ExistinRelaationshipWithBank'] = exRelBank ?? "null";
      if (branchLoc != "string") request.fields['Branch'] = branchLoc ?? "null";
      request.fields['ProductType'] = prodTypeInt;
      if (connName != "string") request.fields['ConnectorName'] = connName ?? "null";
      if (connMob != "string") request.fields['ConnectorMobileNo'] = connMob ?? "null";
      if (connShare != "string") request.fields['ConnectorPercentage'] = connShare ?? "null";



      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(fillLeadForm, request.fields);
      Helper.ApiRes(fillLeadForm, response.body);


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


  static Future<Map<String, dynamic>> individualLeadUploadApi({


    required String name,
    required String mobileNo,
    required String createdBy,

    String? gender,
    String? dob,
    String? loanAmtReq,
    String? email,
    String? aadhar,
    String? pan,
    String? streetAdd,
    String state = "0",
    String district = "0",
    String city = "0",
    String? zip,
    String? nationality,
    String currEmpSt = "0",
    String? employerName,
    String? monthlyIncome,
    String? addSrcIncome,
    String prefBank = "0",
    String? exRelBank,
    String? branchLoc,
    String prodTypeInt = "0",
    String? connName,
    String? connMob,
    String? connShare,
    String? existingLoans,
    String? noOfExistingLoans,
  }) async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(individualLeadUpload),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);

      request.fields['Name'] = name;
      request.fields['MobileNumber'] = mobileNo;
      request.fields['CreatedBy'] = createdBy;
      if (email != "string") request.fields['Email'] = email ?? "null";
      if (zip != "string") request.fields['Pincode'] = zip ?? "null";
      if (dob != "string") request.fields['DateOfBirth'] = dob ?? "null";
      if (gender != "string") request.fields['Gender'] = gender ?? "null";
      if (loanAmtReq != "string") request.fields['LoanAmountRequested'] = loanAmtReq ?? "null";
      if (aadhar != "string") request.fields['AdharCard'] = aadhar ?? "null";
      if (pan != "string") request.fields['PanCard'] = pan ?? "null";
      if (streetAdd != "streetAdd") request.fields['StreetAddress'] = streetAdd ?? "null";
      request.fields['State'] = state;
      request.fields['District'] = district;
      request.fields['City'] = city;
      if (nationality != "string") request.fields['Nationality'] = nationality ?? "null";
      request.fields['CurrentEmploymentStatus'] = currEmpSt;
      if (employerName != "string") request.fields['EmployerName'] = employerName ?? "null";
      if (monthlyIncome != "string") request.fields['MonthlyIncome'] = monthlyIncome ?? "null";
      if (addSrcIncome != "string") request.fields['AdditionalSourceOfIncome'] = addSrcIncome ?? "null";
      if (branchLoc != "string") request.fields['Branch'] = branchLoc ?? "null";
      request.fields['ProductType'] = prodTypeInt;
      if (connName != "string") request.fields['ConnectorName'] = connName ?? "null";
      if (connMob != "string") request.fields['ConnectorMobileNo'] = connMob ?? "null";
      if (connShare != "string") request.fields['ConnectorPercentage'] = connShare ?? "null";
      if (existingLoans != "string") request.fields['ExistingLoans'] = existingLoans ?? "null";
      if (noOfExistingLoans != "string") request.fields['NoOfExistingLoans'] = noOfExistingLoans ?? "null";

     // ===============================



      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Helper.ApiReq(individualLeadUpload, request.fields);
      Helper.ApiRes(individualLeadUpload, response.body);

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
