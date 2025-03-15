import 'package:http/http.dart' as http;
import 'package:ksdpl/common/get_header.dart';
import 'package:ksdpl/common/helper.dart';
import 'dart:convert';

import '../common/base_url.dart';
import '../common/storage_service.dart';

class DrawerApiService {
  static const String baseUrl =BaseUrl.baseUrl; //'http://192.168.29.2:8085/api/';
  static const String base2 = '';
  static const String getBankerById = baseUrl + 'BankerRegistration/GetBankerById';
  static const String editBankerRegistration = baseUrl + 'BankerRegistration/EditBankerRegistration';
  static const String changePassword = baseUrl + 'Auth/ChangePassword';

  static const String getCompanyProfile = baseUrl + 'CompanyProfile/GetCompanyProfile';
  static const String addCompanyProfile = baseUrl + 'CompanyProfile/AddCompanyProfile';
  static const String getAllLeads = baseUrl + 'LeadDetail/GetAllLeads';
  static const String updateLeadStage = baseUrl + 'LeadDetail/UpdateLeadStage';
  static const String getLeadDetailById = baseUrl + 'LeadDetail/GetLeadDetailById';
  static const String leadMoveToCommonTask = baseUrl + 'LeadDetail/LeadMoveToCommonTask';

  static Future<Map<String, dynamic>> getBankerByIdApi({
    required String bankerId,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getBankerById),
      );

      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });

      request.fields['bankerId'] = bankerId;

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




  static Future<Map<String, dynamic>> editBankerRegistrationApi({
    required String id,
    required String bankId,
    required String branchId,
    required String bankerCode,
    required String bankerName,
    required String contactNo,
    required String whatsappNo,
    required String email,
    required String supervisorId,
    required String admSupervisorId,
    required String supervisorName,
    required String supervisorMobileNo,
    required String supervisorEmail,
    required String admSupervisorName,
    required String admSupervisorMobileNo,
    required String admSupervisorEmail,
    required String role,
    required String shortRole,
    required String levelId,
  }) async {
    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(editBankerRegistration),
      );
      var header=await MyHeader.getHeaders2();

      // Headers
      request.headers.addAll(header);

      request.fields['Id'] = id;
      request.fields['BankId'] = bankId;
      request.fields['BranchId'] = branchId;
      request.fields['BankerCode'] = bankerCode;
      request.fields['BankerName'] = bankerName;
      request.fields['ContactNo'] = contactNo;
      request.fields['WhatsappNo'] = whatsappNo;
      request.fields['Email'] = email;
      request.fields['SupervisorId'] = supervisorId;
      request.fields['AdmSupervisorId'] = admSupervisorId;
      request.fields['SupervisorName'] = supervisorName;
      request.fields['SupervisorMobileNo'] = supervisorMobileNo;
      request.fields['SupervisorEmail'] = supervisorEmail;
      request.fields['AdmSupervisorName'] = admSupervisorName;
      request.fields['AdmSupervisorMobileNo'] = admSupervisorMobileNo;
      request.fields['AdmSupervisorEmail'] = admSupervisorEmail;
      request.fields['Role'] = role;
      request.fields['ShortRole'] = shortRole;
      request.fields['LevelId'] = levelId;

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



  static Future<Map<String, dynamic>> changePasswordApi({
    required String newPassword,


  }) async {
    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(changePassword),
      );
      var header=await MyHeader.getHeaders2();



      // Headers
      request.headers.addAll(header);

      request.fields['NewPassword'] = newPassword;

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("request===>changePasswordApi==>${request.fields.toString()}");
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

  ///KSDPL


  static Future<Map<String, dynamic>> getCompanyProfileApi() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getCompanyProfile),
      );
      print("uri===>getCompanyProfileApi==>${getCompanyProfile.toString()}");
      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });
      var header=await MyHeader.getHeaders2();
      print("uri===>getCompanyProfileApi==>${header}");
      request.headers.addAll(header);
      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("request===>getCompanyProfileApi==>${request.fields.toString()}");
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

  static Future<Map<String, dynamic>> addCompanyProfileApi({
    required String id,
    required String companyName,
    required String founderName,
    required String ceoName,
    required String tagline,
    required String foundingDate,
    required String headquartersLocation,
    required String email,
    required String phoneNo,
    required String whatsAppNo,
    required String fax,
    required String websiteURL,
    required String linkedIn,
    required String facebook,
    required String twitter,
    required String companyAddress,
    required String mapIntegration,
    required String privacyPolicy,
    required String termsAndConditions,
    required String gstNumber,
    required String panNumber,
    required String cinNumber,
    required String createdDate,
    required String createdBy,
    required String updateDate,
    required String updatedBy,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(addCompanyProfile),
      );
      var header=await MyHeader.getHeaders2();

      // Headers
      request.headers.addAll(header);

      request.fields['Id'] = id;
      request.fields['CompanyName'] = companyName;
      request.fields['FounderName'] = founderName;
      request.fields['CEOName'] = ceoName;
      request.fields['Tagline'] = tagline;
      request.fields['FoundingDate'] = foundingDate;
      request.fields['HeadquartersLocation'] = headquartersLocation;
      request.fields['Email'] = email;
      request.fields['PhoneNo'] = phoneNo;
      request.fields['WhatsAppNo'] = whatsAppNo;
      request.fields['Fax'] = fax;
      request.fields['WebsiteURL'] = websiteURL;
      request.fields['LinkedIn'] = linkedIn;
      request.fields['Facebook'] = facebook;
      request.fields['Twitter'] = twitter;
      request.fields['CompanyAddress'] = companyAddress;
      request.fields['MapIntegration'] = mapIntegration;
      request.fields['PrivacyPolicy'] = privacyPolicy;
      request.fields['TermsAndConditions'] = termsAndConditions;
      request.fields['GSTNumber'] = gstNumber;
      request.fields['PANNumber'] = panNumber;
      request.fields['CINNumber'] = cinNumber;
      request.fields['CreatedDate'] = createdDate;
      request.fields['CreatedBy'] = createdBy;
      request.fields['UpdateDate'] = updateDate;
      request.fields['UpdatedBy'] = updatedBy;

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

  static Future<Map<String, dynamic>> getAllLeadsApi({
    required leadStage,
    required employeeId,
}) async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getAllLeads),
      );

      // Headers

      var header=await MyHeader.getHeaders2();

      request.headers.addAll(header);
      request.fields['LeadStage'] = leadStage.toString();
      request.fields['AssignedEmployeeId'] =employeeId.toString();
      request.fields['StateId'] ="0";
      request.fields['DistrictId'] ="0";
      request.fields['CityId'] ="0";
      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("request===> getAllLeadsApi==>${request.fields.toString()}");
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



  static Future<Map<String, dynamic>> updateLeadStageApi({
    required id,
    required stage,
    required active,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse( updateLeadStage),
      );
      print("uri===> updateLeadStage==>${getAllLeads.toString()}");
      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });
      var header=await MyHeader.getHeaders2();
      print("uri===> updateLeadStage==>${header}");
      request.headers.addAll(header);
      request.fields['Id'] = id;
      request.fields['Stage'] = stage;
      request.fields['Active'] = active;
      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("request===> updateLeadStage==>${request.fields.toString()}");
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


  static Future<Map<String, dynamic>> getLeadDetailByIdApi({
    required leadId,
  }) async {
    print("request===> getLeadDetailById==>");
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(getLeadDetailById),
      );

      // Headers

      var header=await MyHeader.getHeaders2();
      print("request===> getLeadDetailById==>${header.toString()}");
      request.headers.addAll(header);
      request.fields['LeadId'] = leadId.toString();
      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("request===> getLeadDetailById==>${request.fields.toString()}");
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


  static Future<Map<String, dynamic>> leadMoveToCommonTaskApi({
    required leadId,
    required percentage,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(leadMoveToCommonTask),
      );
      print("uri===> leadMoveToCommonTask==>${leadMoveToCommonTask.toString()}");
      // Headers
      request.headers.addAll({
        'accept': 'text/plain',
      });
      var header=await MyHeader.getHeaders2();
      print("uri===> leadMoveToCommonTask==>${header}");
      request.headers.addAll(header);
      request.fields['LeadId'] = leadId;
      request.fields['Percentage'] = percentage;

      // Sending request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("request===> leadMoveToCommonTask==>${request.fields.toString()}");
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
